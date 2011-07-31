package com.mikenimer.cfspringmvc.litepost.model;

import litepost.model.Entry;

import java.util.Date;

/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 6:03:52 PM */
public class Comment
{
    private int commentID;
    private Entry entry;
    private String comment;
    private String name;
    private String email;
    private String url;
    private Date dateCreated;


    public int getCommentID()
    {
        return commentID;
    }


    public void setCommentID(int commentID)
    {
        this.commentID = commentID;
    }


    public Entry getEntry()
    {
        return entry;
    }


    public void setEntry(Entry entry)
    {
        this.entry = entry;
    }


    public String getComment()
    {
        return comment;
    }


    public void setComment(String comment)
    {
        this.comment = comment;
    }


    public String getName()
    {
        return name;
    }


    public void setName(String name)
    {
        this.name = name;
    }


    public String getEmail()
    {
        return email;
    }


    public void setEmail(String email)
    {
        this.email = email;
    }


    public String getUrl()
    {
        return url;
    }


    public void setUrl(String url)
    {
        this.url = url;
    }


    public Date getDateCreated()
    {
        return dateCreated;
    }


    public void setDateCreated(Date dateCreated)
    {
        this.dateCreated = dateCreated;
    }
}
