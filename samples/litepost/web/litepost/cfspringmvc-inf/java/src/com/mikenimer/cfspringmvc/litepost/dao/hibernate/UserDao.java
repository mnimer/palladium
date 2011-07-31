package com.mikenimer.cfspringmvc.litepost.dao.hibernate;

import litepost.model.User;
import org.apache.commons.collections.CollectionUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;

import java.util.Collection;

/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 1:58:10 PM */
public class UserDao
{
    private SessionFactory sessionFactory;


    public void setSessionFactory(SessionFactory sessionFactory)
    {
        this.sessionFactory = sessionFactory;
    }


    public User authorizeUser(String username, String password)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            Criteria criteria = session.createCriteria(User.class);
            criteria.add(Restrictions.eq("userName", username));
            criteria.add(Restrictions.eq("password", password));
            Collection userRows = criteria.list();

            session.getTransaction().commit();
            //session.close();

            if (userRows.size() > 1)
            {
                throw new RuntimeException("Duplicate user records, please contact support");
            }
            else if (userRows.size() == 1)
            {
                User user = (User) CollectionUtils.index(userRows, 0);
                return user;
            }

            return null;
        }
        finally
        {
            session.close();
        }
    }


    public User load(String userId)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            User user = (User) session.get(User.class, new Integer(userId));

            session.getTransaction().commit();
            //session.close();

            return user;
        }
        finally
        {
            session.close();   
        }
    }
}
