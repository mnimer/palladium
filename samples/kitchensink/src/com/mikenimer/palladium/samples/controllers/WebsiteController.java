package com.mikenimer.palladium.samples.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author: mikenimer@yahoo.com
 */
@Controller
public class WebsiteController
{

    @RequestMapping("/index")
    public ModelAndView handleHome(HttpServletRequest request, HttpServletResponse response)
    {
        return new ModelAndView( "home" );
    }

}

