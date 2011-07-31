package com.mikenimer.cfspringmvc.hibernate;

import litepost.model.Category;
import litepost.model.Comment;
import litepost.model.Entry;
import litepost.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/** User: mikenimer@yahoo.com Date: Jun 29, 2010 Time: 1:53:30 PM */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:///Users/mnimer/Development/OpenSourceProjects/litepost/web/WEB-INF/litepost-mvc-servlet.xml"})
public class EntryTests
{
    @Autowired
    public SessionFactory sessionFactory;

    Entry entry;
    User user;
    Category CFCategory;


    @Before
    public void loadUser()
    {
        Session s3 = sessionFactory.getCurrentSession();
        s3.beginTransaction();
        user = (User) s3.get(User.class, 1);
        CFCategory = (Category)s3.get(Category.class, 1);
        s3.getTransaction().commit();
    }


    @After
    public void cleanUp()
    {
        if (entry != null)
        {
            //clean up
            Session s3 = sessionFactory.getCurrentSession();
            s3.beginTransaction();
            s3.delete(entry);
            s3.getTransaction().commit();
        }

    }


    @Test
    public void testSaveFullEntry()
    {
        Category category = new Category();
        category.setCategory("test category");

        Comment comment1 = new Comment();
        comment1.setComment("Lorem ipsum");
        comment1.setEmail("foo@blah.com");
        comment1.setName("test user");
        comment1.setDateCreated(new Date());

        Comment comment2 = new Comment();
        comment2.setComment("Lorem ipsum");
        comment2.setEmail("foo@blah.com");
        comment2.setName("test user");
        comment2.setDateCreated(new Date());

        entry = new Entry();
        entry.setTitle("This is a test");
        entry.setBody("lorem ipsum body");
        entry.setUser(user);
        entry.setCategory(category);
        entry.setDateCreated(new Date());
        entry.setDateLastUpdated(new Date());

        Set entryList = new HashSet();
        entryList.add(entry);
        category.setEntries(entryList);

        Set comments = new HashSet();
        comments.add(comment1);
        comment1.setEntry(entry);
        comments.add(comment2);
        comment2.setEntry(entry);
        entry.setComments(comments);


        // save
        Session s = sessionFactory.getCurrentSession();
        s.beginTransaction();
        s.saveOrUpdate(category);
        s.saveOrUpdate(entry);
        s.getTransaction().commit();

        //load from db
        Session s2 = sessionFactory.getCurrentSession();
        s2.beginTransaction();
        Entry newEntry = (Entry) s2.load(Entry.class, entry.getEntryID());
        s2.getTransaction().commit();


        Assert.assertNotNull(newEntry);
        Assert.assertNotNull(newEntry.getCategory());
        Assert.assertEquals(2, newEntry.getComments().size());

    }

    @Test
    public void testSaveWithExistingCategory()
    {
        Comment comment1 = new Comment();
        comment1.setComment("Lorem ipsum");
        comment1.setEmail("foo@blah.com");
        comment1.setName("test user");
        comment1.setDateCreated(new Date());

        Comment comment2 = new Comment();
        comment2.setComment("Lorem ipsum");
        comment2.setEmail("foo@blah.com");
        comment2.setName("test user");
        comment2.setDateCreated(new Date());

        entry = new Entry();
        entry.setTitle("This is a test");
        entry.setBody("lorem ipsum body");
        entry.setUser(user);
        entry.setCategory(CFCategory);
        entry.setDateCreated(new Date());
        entry.setDateLastUpdated(new Date());

        ArrayList entryList = new ArrayList();
        entryList.add(entry);
        CFCategory.setEntries(entryList);

        Set comments = new HashSet();
        comments.add(comment1);
        comment1.setEntry(entry);
        comments.add(comment2);
        comment2.setEntry(entry);
        entry.setComments(comments);


        // save
        Session s = sessionFactory.getCurrentSession();
        s.beginTransaction();
        s.saveOrUpdate(entry);
        s.getTransaction().commit();

        //load from db
        Session s2 = sessionFactory.getCurrentSession();
        s2.beginTransaction();
        Entry newEntry = (Entry) s2.load(Entry.class, entry.getEntryID());
        s2.getTransaction().commit();


        Assert.assertNotNull(newEntry);
        Assert.assertNotNull(newEntry.getCategory());
        Assert.assertEquals(2, newEntry.getComments().size());

    }
}