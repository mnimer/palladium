package litepost.hibernate;

import litepost.model.Category;
import litepost.model.Entry;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;

import java.util.Collection;


/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 5:58:44 PM */
public class EntryDao
{
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory)
    {
        this.sessionFactory = sessionFactory;
    }



    public Collection listAll()
    {
        return listAll(null);
    }


    /**
     * List all entries, and if defined - filter them by category
     * @param categoryFilter
     * @return
     */
    public Collection listAll(Category categoryFilter)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            Criteria criteria = session.createCriteria(Entry.class);
            if( categoryFilter != null )
            {
                criteria.add( Restrictions.eq("category", categoryFilter));   
            }
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


    public Entry load(int id)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            Entry entry = (Entry)session.get(Entry.class,  id);

            session.getTransaction().commit();
            //session.close();

            return entry;
        }
        finally
        {
            session.close();
        }
    }


    public Entry save(Entry entry)
    {
        Session session = this.sessionFactory.openSession();
        try
        {
            session.beginTransaction();

            session.saveOrUpdate(entry);

            session.getTransaction().commit();
            //session.close();

            return entry;
        }
        finally
        {
            session.close();
        }
    }
}
