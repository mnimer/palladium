package com.mikenimer.palladium.samples.controllers;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;

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
        String cfcPath = request.getRealPath("/kitchensink-inf/components/" + "CFCProxyExamples.cfc"); //cache this lookup for performance

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



    @RequestMapping("/cfc/pdf")
    public ModelAndView testPdfExample(HttpServletRequest request, HttpServletResponse response)
    {
        Struct cfcResult = null;
        String cfcPath = request.getRealPath("/kitchensink-inf/components/" + "CFCProxyExamples.cfc"); //cache this lookup for performance

        long start = System.currentTimeMillis();
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {"<b>Hello World</b><br>Current Time:  " +new Date().toLocaleString()};
            cfcResult = (Struct)myCFC.invoke("createPDF", myArgs);


            byte[] pdfBytes = (byte[])cfcResult.get("pdf");
            response.setContentType("application/pdf");
            response.setContentLength(pdfBytes.length);
            response.setHeader("Content-Disposition", "inline;filename=example.pdf");
            OutputStream out = response.getOutputStream();
            out.write( pdfBytes );
            out.flush();

        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();
        return null;
    }

}

