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
 * Date: 7/3/12
 */
public class PdfUrlExampleServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "PdfUrlExample.cfc"); //cache this lookup for performance

        String url = "http://www.google.com";
        if( req.getParameter("url") != null )
        {
            url = req.getParameter("url");
        }


        long start = System.currentTimeMillis();
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {url};
            cfcResult = (Struct)myCFC.invoke("urltopdf", myArgs);
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();


        // send pdf bytes back to browser
        outputPdf(resp, cfcResult, "urlExample.pdf");
    }


    private void outputPdf(HttpServletResponse resp, Struct cfcResult, String fileName) throws IOException
    {
        byte[] pdfBytes = (byte[])cfcResult.get("pdf");
        resp.setContentType("application/pdf");
        resp.setContentLength(pdfBytes.length);
        resp.setHeader("Content-Disposition", "inline;filename=" +fileName);
        OutputStream out = resp.getOutputStream();
        out.write( pdfBytes );
        out.flush();
    }
}
