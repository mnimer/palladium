package com.mikenimer.cfspringmvc.litepost.model;

import java.util.Collection;
import java.util.HashSet;
import java.util.Vector;

/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 5:47:55 PM */
public class Category
{
    private int categoryID;
    private String category;
    private Collection entries;


    public int getCategoryID()
    {
        return categoryID;
    }


    public void setCategoryID(int categoryID)
    {
        this.categoryID = categoryID;
    }


    public String getCategory()
    {
        return category;
    }


    public void setCategory(String category)
    {
        this.category = category;
    }


    public Collection getEntries()
    {
        if( entries == null )
        {
            entries = new HashSet();
        }

        return entries;
    }


    public void setEntries(Collection entries)
    {
        this.entries = entries;
    }
}
