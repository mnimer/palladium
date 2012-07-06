package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

/**
 * User: mnimer
 * Date: 7/6/12
 */
public class presentationServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

        Object cfcResult = null;
        String type = req.getParameter("type");
        String cfcPath = req.getRealPath("/demos-inf/components/" + "cfpresentationExample.cfc"); //cache this lookup for performance

        String dir = "/demos-inf/presentations";
        long start = System.currentTimeMillis();
        try
        {
            if( type.equalsIgnoreCase("flash"))
            {
                dir = dir +"/slideDeckFlash";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir};
                cfcResult = myCFC.invoke("slideDeckFlash", myArgs);
                resp.sendRedirect(dir +"/index.htm");
            }
            else if( type.equalsIgnoreCase("html"))
            {
                dir = dir +"/slideDeckHTML";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir};
                cfcResult = myCFC.invoke("slideDeckHTML", myArgs);
                resp.sendRedirect(dir +"/index.htm");
            }
            else if( type.equalsIgnoreCase("ppt"))
            {
                dir = dir +"/slideDeckPPT";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir};
                cfcResult = myCFC.invoke("slideDeckPPT", myArgs);
                resp.sendRedirect(dir +"/preso.ppt");
            }
            else if( type.equalsIgnoreCase("example1"))
            {
                dir = dir +"/example1";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir};
                cfcResult = myCFC.invoke("example1", myArgs);
                resp.sendRedirect(dir +"/index.htm");
            }
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();

    }



    private void outputPPT(HttpServletResponse resp, Struct cfcResult, String fileName) throws IOException
    {
        byte[] bytes = (byte[])cfcResult.get("pdf");
        resp.setContentType("application/pdf");
        resp.setContentLength(bytes.length);
        resp.setHeader("Content-Disposition", "inline;filename=" +fileName);
        OutputStream out = resp.getOutputStream();
        out.write( bytes );
        out.flush();
    }


    private void outputFlash(HttpServletResponse resp, Struct cfcResult, String fileName) throws IOException
    {
        byte[] bytes = (byte[])cfcResult.get("pdf");
        resp.setContentType("application/x-shockwave-flash");
        resp.setContentLength(bytes.length);
        OutputStream out = resp.getOutputStream();
        out.write( bytes );
        out.flush();
    }

}
