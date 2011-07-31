package litepost.hibernate;

import litepost.model.Category;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.Collection;

/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 5:52:00 PM */
public class CategoryDao
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

            Criteria criteria = session.createCriteria(Category.class);
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


    public Category load(int id)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            Category cat = (Category) session.get(Category.class, id);

            session.getTransaction().commit();
            //session.close();

            return cat;
        }
        finally
        {
            session.close();
        }
    }



    public Category save(Category category)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            session.saveOrUpdate(category);

            session.getTransaction().commit();
            //session.close();

            return category;
        }
        finally
        {
            session.close();
        }
    }



    public void delete(Category category)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            session.delete(category);

            session.getTransaction().commit();
        }
        finally
        {
            session.close();
        }
    }
}
