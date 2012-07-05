package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * User: mnimer
 * Date: 7/3/12
 */
public class S3FileExampleServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "CFFileExample.cfc"); //cache this lookup for performance


        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {};
            cfcResult = (String)myCFC.invoke("dump", myArgs);
        }
        catch (Throwable e)
        {
            //throw new RuntimeException(e);
        }



        String result = "<strong>CFFILE/S3 Example</strong>";
        resp.setContentType("text/html");
        resp.getOutputStream().write(result.getBytes());
    }
}
