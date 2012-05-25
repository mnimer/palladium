package controllers;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.TransformerFactory;
import java.util.Date;
import java.util.Map;

/**
 * User: mnimer
 * Date: 5/23/12
 */
@Controller
public class WebsiteController
{

    @RequestMapping("/index")
    public ModelAndView indexHandler(HttpServletRequest request, HttpServletResponse response)
    {

        ModelAndView view = new ModelAndView( "index" );
        view.addObject("title", "Hello World");
        view.addObject("timestamp", new Date().toGMTString() );
        return view;
    }


    @RequestMapping("/test/ping")
    public ModelAndView testPingExample(HttpServletRequest request, HttpServletResponse response)
    {
        Struct cfcResult = null;
        String cfcPath = request.getRealPath("/helloworld-inf/components/" + "JavaProxyExamples.cfc"); //cache this lookup for performance

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
