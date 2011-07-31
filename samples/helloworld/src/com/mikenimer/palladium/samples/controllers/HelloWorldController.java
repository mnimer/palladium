package com.mikenimer.palladium.samples.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

@Controller
public class HelloWorldController
{
    @RequestMapping("/index")
    public ModelAndView indexHandler(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView model = new ModelAndView("index");
        model.addObject("title", "Hello World");
        model.addObject("timestamp", new Date().toGMTString() );
        return model;
    }
}
