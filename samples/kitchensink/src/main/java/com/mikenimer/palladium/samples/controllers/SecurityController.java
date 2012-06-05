package com.mikenimer.palladium.samples.controllers;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * A Good Example:
 * @see "http://krams915.blogspot.com/2010/12/spring-security-mvc-integration_18.html"
 *
 * @author: mikenimer@yahoo.com
 */
@Controller
public class SecurityController
{



    @RequestMapping("/index")
    public ModelAndView handleHome( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "home" );
    }


    @RequestMapping("/public")
    public ModelAndView handlePubli( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "public" );
    }


    @RequestMapping("/secured")
    public ModelAndView handleSecured( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "secured" );
    }


    @RequestMapping("/admin")
    public ModelAndView handleAdmin( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "admin" );
    }


    @RequestMapping("/login")
    public ModelAndView handleLogin( HttpServletRequest request, HttpServletResponse response )
    {
        String currentUser = SecurityContextHolder.getContext().getAuthentication().getName();


        ModelAndView view = new ModelAndView( "login" );

        if( currentUser != null )
        {

            if( currentUser.equalsIgnoreCase( "admin" ) )
            {
                view = new ModelAndView( "home" );
            }
        }


        if( request.getParameter( "error" ) != null )
        {
            view.addObject( "error", "Error logging in user" );
        }

        return view;
    }


    @RequestMapping("/logout")
    public ModelAndView handleLogout( HttpServletRequest request, HttpServletResponse response )
    {
        String currentUser = SecurityContextHolder.getContext().getAuthentication().getName();

        return new ModelAndView( "home" );
    }


    @RequestMapping("/denied")
    public ModelAndView handleDenied( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "admin" );
    }


}

