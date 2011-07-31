package com.mikenimer.cfspringmvc.litepost.dao.hibernate;

import litepost.model.Bookmark;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.Collection;

/** User: mikenimer@yahoo.com Date: Jun 28, 2010 Time: 11:02:10 PM */
public class BookmarkDao
{
    private SessionFactory sessionFactory;


    public void setSessionFactory(SessionFactory sessionFactory)
    {
        this.sessionFactory = sessionFactory;
    }


    public Collection listAll()
    {
        Session session = this.sessionFactory.openSession();
        try
        {

            session.beginTransaction();

            Criteria criteria = session.createCriteria(Bookmark.class);
            Collection categories = criteria.list();

            session.getTransaction().commit();
            //session.close();

            return categories;
        }
        finally
        {
            session.close();   
        }
    }



    public Bookmark load(int id)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            Bookmark mark = (Bookmark) session.get(Bookmark.class, id);

            session.getTransaction().commit();
            //session.close();

            return mark;
        }
        finally
        {
            session.close();
        }
    }



    public Bookmark save(Bookmark bookmark)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            session.saveOrUpdate(bookmark);

            session.getTransaction().commit();
            //session.close();

            return bookmark;
        }
        finally
        {
            session.close();
        }
    }

    

    public void delete(Bookmark bookmark)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            session.delete(bookmark);

            session.getTransaction().commit();
            //session.close();
        }
        finally
        {
            session.close();
        }
    }
}
