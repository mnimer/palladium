package com.mikenimer.palladium.samples.controllers;

import com.mikenimer.palladium.samples.resolvers.ThemeResolver;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author: mikenimer@yahoo.com
 */
@Controller
public class ThemeController
{
    public ThemeResolver themeResolver;


    public void setThemeResolver( ThemeResolver themeResolver )
    {
        this.themeResolver=themeResolver;
    }


    @RequestMapping("/index")
    public ModelAndView handleHome(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="theme", required=false) String theme)
    {
        if( theme != null )
        {
            themeResolver.setThemeName( request, response, theme );
        }


        return new ModelAndView( "home" );
    }
}
