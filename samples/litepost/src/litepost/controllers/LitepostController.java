package litepost.controllers;

import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.SyndFeedOutput;
import litepost.hibernate.BookmarkDao;
import litepost.hibernate.CategoryDao;
import litepost.hibernate.EntryDao;
import litepost.hibernate.UserDao;
import litepost.model.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/** User: mikenimer@yahoo.com Date: Jun 16, 2010 Time: 4:36:43 PM */
@Controller
public class LitepostController
{
    private UserDao userDao;
    private CategoryDao categoryDao;
    private EntryDao entryDao;
    private BookmarkDao bookmarkDao;


    public void setUserDao(UserDao userDao)
    {
        this.userDao = userDao;
    }


    public void setCategoryDao(CategoryDao categoryDao)
    {
        this.categoryDao = categoryDao;
    }


    public void setEntryDao(EntryDao entryDao)
    {
        this.entryDao = entryDao;
    }


    public void setBookmarkDao(BookmarkDao bookmarkDao)
    {
        this.bookmarkDao = bookmarkDao;
    }


    /**
     * This is the main entry point, and will handle the basic items of - logging in and out - showing the home page (after successful login)
     *
     * @param request
     * @param response
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/index.*")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String errorMessage = null;

        // process login command
        if (request.getParameter("loginBtn") != null)
        {
            String username = request.getParameter("userName");
            String password = request.getParameter("password");

            User user = userDao.authorizeUser(username, password);

            if (user != null) // we found a valid user, open the app
            {
                // load posts
                Collection entries = this.entryDao.listAll();

                request.getSession(true).setAttribute("user", user); //todo, find way to put this in CF session scope
                ModelAndView view = new ModelAndView("main");
                view.addObject("user", user);
                view.addObject("entries", entries);
                view = initializeDefaults(view);
                return view;
            }
        }
        // Process logout action
        else if (request.getParameter("action") != null)
        {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("logout"))
            {
                // pull authentication user out of session scope.
                request.getSession().removeAttribute("user");
            }
        }
        // User is logged in 
        else if (request.getSession().getAttribute("user") != null)
        {
            // load posts
            Collection entries = this.entryDao.listAll();

            // Load Main View
            ModelAndView view = new ModelAndView("main");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }

        // New user - show login
        ModelAndView view = new ModelAndView("login");
        view.addObject("errorMessage", errorMessage);
        return view;
    }


    /**
     * These next 4 post_XXXX method are one way to do the mapping. Where each action has it's own method handler
     *
     * Note: I do it differently for categories and bookmarks - as a way to show off the options. I have no idea
     * which way is best. I'll leave that as a "art of programming" discussion. 
     */

    /**
     * Show the edit post view, for a new entry
     *
     * @param request
     * @param response
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/post/add.*")
    public ModelAndView post_add(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }


        Entry entry = new Entry();  // new entry to add

        ModelAndView view = new ModelAndView("editPost");
        view.addObject("user", request.getSession().getAttribute("user"));
        view.addObject("entry", entry);
        view = initializeDefaults(view);
        return view;

    }


    /**
     * Edit existing post
     *
     * @param request
     * @param response
     * @param postId
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/post/{postId}/edit.*")
    public ModelAndView post_edit(HttpServletRequest request, HttpServletResponse response, @PathVariable("postId") Integer postId) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

        Entry entry = this.entryDao.load(postId);   //load entry to edit
        if (entry == null)
        {
            throw new RuntimeException("Invalid PostId");
        }

        ModelAndView view = new ModelAndView("editPost");
        view.addObject("user", request.getSession().getAttribute("user"));
        view.addObject("entry", entry);
        view = initializeDefaults(view);
        return view;
    }


    /**
     * Edit existing post
     *
     * @param request
     * @param response
     * @param postId
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/post/{postId}/addComment.*")
    public ModelAndView post_comment_handler(HttpServletRequest request, HttpServletResponse response, @PathVariable("postId") Integer postId) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String url   = request.getParameter("url");
        String commentBody = request.getParameter("comment");

        Entry entry = this.entryDao.load( postId );

        Comment comment = new Comment();
        comment.setEmail( email );
        comment.setName( name );
        comment.setUrl( url );
        comment.setComment( commentBody );
        comment.setEntry( entry );
        comment.setDateCreated( new Date() );

        if( entry.getComments() == null )
        {
            entry.setComments( new HashSet() );
        }
        entry.getComments().add(comment);


        // save entry
        this.entryDao.save(entry);


        ModelAndView view = new ModelAndView("viewPost");
        view.addObject("user", request.getSession().getAttribute("user"));
        view.addObject("entry", entry);
        view = initializeDefaults(view);
        return view;
    }


    /**
     * save the post then show the "view" version of this post.
     *
     * @param request
     * @param response
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/post/save.*")
    public RedirectView post_save(HttpServletRequest request, HttpServletResponse response)
    {
        if (request.getSession().getAttribute("user") == null)
        {
            RedirectView view = new RedirectView("login");
            return view;
        }

        User user = (User) request.getSession().getAttribute("user"); // load user from session.
        Integer entryID = null;

        // check if this is an edit or save.
        if (request.getParameter("entryID").length() > 0)
        {
            entryID = new Integer(request.getParameter("entryID"));
        }


        //load entry to view (if we are editing one we'll save this one too)
        Entry entry = null;
        if (entryID != null)
        {
            entry = this.entryDao.load(entryID);
        }

        Category category = this.categoryDao.load(new Integer(request.getParameter("categoryID")));

        // First check to see if we need to save a post being edited.
        if (request.getParameter("savePostBtn") != null)
        {
            if (entry == null)
            {
                // it's a new entry
                entry = new Entry();
                entry.setDateCreated(new Date());
            }
            //set property from form variables
            entry.setUser(user);
            entry.setBody(request.getParameter("body"));
            entry.setTitle(request.getParameter("title"));
            entry.setDateLastUpdated(new Date());
            entry.setCategory(category);
            category.getEntries().add(entry);

            // save entry
            entry = this.entryDao.save(entry);


            // Save was complete, now return the user to the view page. with a REDIRECT VIEW
            RedirectView view = new RedirectView("./" + entry.getEntryID() + "/view.cfm");
            return view;
        }
        else
        {
            throw new RuntimeException("Invalid Post Values");
        }
    }



    /**
     * This will do two things - Show selected post - Save an edited post.. The add/edit views post to this view (so after a save a user can see the saved post).
     *
     * @param request
     * @param response
     * @param postId
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/post/{postId}/view.*")
    public ModelAndView post_view(HttpServletRequest request, HttpServletResponse response, @PathVariable("postId") Integer postId) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }


        User user = (User) request.getSession().getAttribute("user");
        //load entry to view (if we are editing one we'll save this one too)
        Entry entry = null;
        if (postId > 0)
        {
            entry = this.entryDao.load(postId);
        }


        if (entry != null)
        {
            User postingUser = this.userDao.load(entry.getUser().getUserId().toString());

            ModelAndView view = new ModelAndView("viewPost");
            view.addObject("user", user);
            view.addObject("entry", entry);
            view.addObject("postingUser", postingUser);
            view = initializeDefaults(view);
            return view;
        }
        else
        {
            ModelAndView view = new ModelAndView("error");
            view.addObject("errorMessage", "Invalid PostId");
            return view;
        }
    }


    /**
     * Add/Edit/Save/View existing category
     * <p/>
     * Note: in this example I put the URL action as a required URL param.. For instance /index.cfm?action=add|edit|save|view
     *
     * @param request
     * @param response
     * @param action
     *
     * @return
     *
     * @throws Exception
     */

    @RequestMapping(value = "/category/index.*")
    public ModelAndView category_handler(HttpServletRequest request, HttpServletResponse response, String action) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

        if (action.equalsIgnoreCase("add"))
        {
            ModelAndView view = new ModelAndView("editCategory");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("category", new Category()); //create empty category for cfoutput vars
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("edit"))
        {
            int catId = new Integer(request.getParameter("categoryID")).intValue();
            Category category = this.categoryDao.load(catId);

            ModelAndView view = new ModelAndView("editCategory");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("category", category);
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("delete"))
        {
            int catId = new Integer(request.getParameter("categoryID")).intValue();
            Category category = this.categoryDao.load(catId);

            this.categoryDao.delete(category);
            Collection entries = this.entryDao.listAll();

            ModelAndView view = new ModelAndView("main");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("save"))
        {
            Category category = new Category();
            category.setCategory(request.getParameter("categoryName"));

            if (new Integer(request.getParameter("categoryID")) > 0)
            {
                category.setCategoryID(new Integer(request.getParameter("categoryID")).intValue());
            }

            this.categoryDao.save(category);
            Collection entries = this.entryDao.listAll();

            ModelAndView view = new ModelAndView("main");//back to home page
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("category", category);
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("view"))
        {
            User user = (User) request.getSession().getAttribute("user"); // load user from session.
            // load category
            int catId = new Integer(request.getParameter("categoryID")).intValue();
            Category category = this.categoryDao.load(catId);

            // load posts filtered by category
            Collection entries = this.entryDao.listAll(category);

            request.getSession(true).setAttribute("user", user); //todo, find way to put this in CF session scope
            ModelAndView view = new ModelAndView("main");
            view.addObject("user", user);
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }
        else
        {
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

    }


    /**
     * This will return a rss/atom xml String for CF to return.
     * <p/>
     * However, a better way. Would be to create a custom view that based on the extension would output the right format for instance /category/rss.atom = would output a atom xml /category/rss.rss  = would output rss xml /category/rss.json = would
     * output json xml.
     *
     * @param request
     * @param response
     * @param action
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/category/rss.*")
    public ModelAndView rss_handler(HttpServletRequest request, HttpServletResponse response, String action) throws Exception
    {
        User user = (User) request.getSession().getAttribute("user"); // load user from session.
        // load category
        int catId = new Integer(request.getParameter("categoryID")).intValue();
        Category category = this.categoryDao.load(catId);

        // load posts filtered by category
        Collection<Entry> entries = this.entryDao.listAll(category);


        // Build up ATOM/RSS XML for litepost entries
        SyndFeed feed = new SyndFeedImpl();
        feed.setTitle("Litepost Feed");
        feed.setPublishedDate(new Date());

        ArrayList feedEntries = new ArrayList();
        feed.setEntries(feedEntries);

        for (Entry entry : entries)
        {
            SyndEntry feedEntry = new SyndEntryImpl();
            feedEntry.setTitle(entry.getTitle());
            feedEntry.setUri(entry.getEntryID().toString());
            feedEntry.setLink("http://www.foo.com/?id=" +entry.getEntryID().toString()); //fake url
            feedEntry.setPublishedDate(entry.getDateCreated());

            // author
            SyndPerson author = new SyndPersonImpl();
            author.setName(entry.getUser().getFirstName() + " " + entry.getUser().getLastName());
            feedEntry.setAuthors(Collections.singletonList(author));

            feedEntries.add(feedEntry);
        }


        /**
         * Note this part is what could be moved to a custom view resolver. And the model would return the
         * SyndFeed object, not the xml String.
         */
        // The sun ROME libraries support lot's of different rss/atom output types, so we check
        // for optional param in case you'd like something other then atom.
        String outXMLMimeType = "application/xml";
        if (request.getParameter("rssFormat") != null)
        {
            String format = request.getParameter("rssFormat");
            feed.setFeedType(format);

            if (format.toLowerCase().contains("rss"))
            {
                outXMLMimeType = "application/rss+xml";
            }
            else if (format.toLowerCase().contains("atom"))
            {
                outXMLMimeType = "application/atom+xml";
            }
        }
        else
        {
            feed.setFeedType("atom_1.0");
            outXMLMimeType = "application/atom+xml";
        }
        SyndFeedOutput output = new SyndFeedOutput();
        String outXML = output.outputString(feed);


        request.getSession(true).setAttribute("user", user); //todo, find way to put this in CF session scope
        ModelAndView view = new ModelAndView("rss");
        view.addObject("user", user);
        view.addObject("feedXml", outXML);
        view.addObject("feedMimeType", outXMLMimeType);
        view = initializeDefaults(view);
        return view;
    }


    /**
     * Add/Edit/Save/View existing bookmark
     * <p/>
     * Note: in this example I put the URL action as the file name.. Which doesn't really exists, since we support 4 actions but only use 2 .cfm templates
     *
     * @param request
     * @param response
     * @param action
     *
     * @return
     *
     * @throws Exception
     */
    @RequestMapping(value = "/bookmark/{action}.*")
    public ModelAndView bookmark_handler(HttpServletRequest request, HttpServletResponse response, @PathVariable("action") String action) throws Exception
    {
        if (request.getSession().getAttribute("user") == null)
        {
            // we could just return login. but doing a forward. means that any logic that sets default variables
            // only happens in one place.
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

        if (action.equalsIgnoreCase("add"))
        {
            ModelAndView view = new ModelAndView("editBookmark");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("bookmark", new Bookmark()); //create empty category for cfoutput vars
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("edit"))
        {
            int bookMarkId = new Integer(request.getParameter("bookmarkID")).intValue();
            Bookmark bookmark = this.bookmarkDao.load(bookMarkId);

            ModelAndView view = new ModelAndView("editBookmark");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("bookmark", bookmark);
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("delete"))
        {
            int bookMarkId = new Integer(request.getParameter("bookmarkID")).intValue();
            Bookmark bookmark = this.bookmarkDao.load(bookMarkId);

            this.bookmarkDao.delete(bookmark);
            Collection entries = this.entryDao.listAll();

            ModelAndView view = new ModelAndView("main");
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }
        else if (action.equalsIgnoreCase("save"))
        {
            Bookmark bookmark = new Bookmark();
            bookmark.setName(request.getParameter("bookmarkName"));
            bookmark.setUrl(request.getParameter("bookmarkUrl"));

            if (new Integer(request.getParameter("bookmarkID")) > 0)
            {
                bookmark.setBookmarkID(new Integer(request.getParameter("bookmarkID")).intValue());
            }

            this.bookmarkDao.save(bookmark);
            Collection entries = this.entryDao.listAll();

            ModelAndView view = new ModelAndView("main"); // back to home page
            view.addObject("user", request.getSession().getAttribute("user"));
            view.addObject("bookmark", bookmark);
            view.addObject("entries", entries);
            view = initializeDefaults(view);
            return view;
        }
        else
        {
            ModelAndView view = new ModelAndView("forward:/litepost/cfspringmvc/index.cfm");
            return view;
        }

    }


    /**
     * Add properties to the model that are used by all pages (in navigation panel)
     *
     * @param view
     *
     * @return
     */
    private ModelAndView initializeDefaults(ModelAndView view)
    {
        // load categories
        Collection categories = this.categoryDao.listAll();
        // load links
        Collection bookmarks = this.bookmarkDao.listAll();

        view.addObject("categories", categories);
        view.addObject("bookmarks", bookmarks);

        return view;
    }

}
