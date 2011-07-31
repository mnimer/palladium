package com.mikenimer.cfspringmvc.litepost.model;


import litepost.model.Category;
import litepost.model.User;

import java.util.Collection;
import java.util.Date;

/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 5:56:04 PM */
public class Entry
{

    private Integer entryID;
    private Category category;
    private User user;
    private String title;
    private String body;
    private Date dateCreated;
    private Date dateLastUpdated;
    private Collection comments;


    public Integer getEntryID()
    {
        return entryID;
    }


    public void setEntryID(Integer entryID)
    {
        this.entryID = entryID;
    }


    public Category getCategory()
    {
        return category;
    }


    public void setCategory(Category category)
    {
        this.category = category;
    }


    public User getUser()
    {
        return user;
    }


    public void setUser(User user)
    {
        this.user = user;
    }


    public String getTitle()
    {
        return title;
    }


    public void setTitle(String title)
    {
        this.title = title;
    }


    public String getBody()
    {
        return body;
    }


    public void setBody(String body)
    {
        this.body = body;
    }


    public Date getDateCreated()
    {
        return dateCreated;
    }


    public void setDateCreated(Date dateCreated)
    {
        this.dateCreated = dateCreated;
    }


    public Date getDateLastUpdated()
    {
        return dateLastUpdated;
    }


    public void setDateLastUpdated(Date dateLastUpdated)
    {
        this.dateLastUpdated = dateLastUpdated;
    }


    public Collection getComments()
    {
        return comments;
    }


    public void setComments(Collection comments)
    {
        this.comments = comments;
    }

}
