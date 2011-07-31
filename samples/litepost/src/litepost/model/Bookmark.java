package litepost.model;

/** User: mikenimer@yahoo.com Date: Jun 28, 2010 Time: 10:57:42 PM */
public class Bookmark
{
    public int bookmarkID;
    public String name;
    public String url;


    public int getBookmarkID()
    {
        return bookmarkID;
    }


    public void setBookmarkID(int bookmarkID)
    {
        this.bookmarkID = bookmarkID;
    }


    public String getName()
    {
        return name;
    }


    public void setName(String name)
    {
        this.name = name;
    }


    public String getUrl()
    {
        return url;
    }


    public void setUrl(String url)
    {
        this.url = url;
    }
}
