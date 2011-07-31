package com.mikenimer.cfspringmvc.hibernate;

import litepost.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/** User: mikenimer@yahoo.com Date: Jun 29, 2010 Time: 1:53:30 PM */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:///Users/mnimer/Development/OpenSourceProjects/litepost/web/WEB-INF/litepost-mvc-servlet.xml"})
public class UserTests
{
    @Autowired
    public SessionFactory sessionFactory;

    User user;


    @After
    public void cleanUp()
    {
        if( user != null )
        {
            //clean up
            Session s3 = sessionFactory.getCurrentSession();
            s3.beginTransaction();
            s3.delete(user);
            s3.getTransaction().commit();
        }

    }


    @Test
    public void testSaveUser()
    {
        user = new User();
        user.setEmail("foo@blah.com");
        user.setUserName("foo");
        user.setPassword("foo");
        user.setRole("foo");
        user.setFirstName("test");
        user.setLastName("test");

        // save
        Session s = sessionFactory.getCurrentSession();
        s.beginTransaction();
        s.saveOrUpdate(user);
        s.getTransaction().commit();

        //load from db
        Session s2 = sessionFactory.getCurrentSession();
        s2.beginTransaction();
        User newUser = (User) s2.load(User.class, user.getUserId());
        s2.getTransaction().commit();


        Assert.assertNotNull(newUser);

    }
}
