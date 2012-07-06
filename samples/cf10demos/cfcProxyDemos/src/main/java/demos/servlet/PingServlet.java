package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * User: mnimer
 * Date: 6/22/12
 */
public class PingServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = request.getRealPath("/demos-inf/components/" + "PingExample.cfc"); //cache this lookup for performance

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

        
        String result = "Execution: (" +(end - start) +"ms) <br/>";
        result += "Status: " +cfcResult.get("status") +"<br/>";
        result += "Date: " +cfcResult.get("data") +"<br/>";
        response.setContentType("text/html");
        response.getOutputStream().write(result.getBytes());
    }
}
