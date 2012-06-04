package com.mikenimer.palladium.samples.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * @author: mikenimer@yahoo.com
 */
@Controller
public class PropertyTestController
{
    @RequestMapping("/index")
    public ModelAndView handleHome( HttpServletRequest request, HttpServletResponse response )
    {
        return new ModelAndView( "home" );
    }


    @RequestMapping("/arrayList")
    public ModelAndView handleArrayList( HttpServletRequest request, HttpServletResponse response )
    {
        ModelAndView view=new ModelAndView( "arrayview" );
        view.addObject( "data", getCollection() );
        return view;
    }


    @RequestMapping("/set")
    public ModelAndView handleSet( HttpServletRequest request, HttpServletResponse response )
    {
        ModelAndView view=new ModelAndView( "arrayview" );
        view.addObject( "data", getCollection() );
        return view;

    }


    @RequestMapping("/vector")
    public ModelAndView handleVector( HttpServletRequest request, HttpServletResponse response )
    {
        ModelAndView view=new ModelAndView( "arrayview" );
        view.addObject( "data", getCollection() );
        return view;
    }


    @RequestMapping("/hashmap")
    public ModelAndView handleHashMap( HttpServletRequest request, HttpServletResponse response )
    {
        ModelAndView view=new ModelAndView( "structview" );
        view.addObject( "data", getMap() );
        return view;
    }




    private Object getCollection()
    {
        Map map=new HashMap();
        map.put( "mapKey1", "map string" );
        map.put( "nullKey", null );

        ArrayList myArray=new ArrayList();
        myArray.add( "String 1" );
        myArray.add( 1234 );
        myArray.add( map );

        ArrayList subData1=new ArrayList();
        subData1.add( "String 2" );
        subData1.add( 4321 );
        subData1.add( map );
        myArray.add( subData1 );

        return myArray;
    }

    private Object getMap()
    {
        ArrayList myArray=new ArrayList();
        myArray.add( "String 1" );
        myArray.add( 1234 );

        Map map=new HashMap();
        map.put( "mapKey1", "map string" );
        map.put( "nullKey", null );
        map.put( "array", myArray );

        return map;
    }


}
