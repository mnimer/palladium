package com.mikenimer.palladium.samples.controllers;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;
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





    @RequestMapping("/cfc/ping")
    public ModelAndView testPingExample(HttpServletRequest request, HttpServletResponse response)
    {
        Struct cfcResult = null;
        String cfcPath = request.getRealPath("/kitchensink-inf/components/" + "JavaProxyExamples.cfc"); //cache this lookup for performance

        long start = System.currentTimeMillis();
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {};
            cfcResult = (Struct)myCFC.invoke("ping", myArgs);
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();


        ModelAndView view = new ModelAndView( "dump" );
        view.addObject("cfcResult", cfcResult);
        view.addObject("executionTime", end-start +"ms");
        return view;
    }

}

