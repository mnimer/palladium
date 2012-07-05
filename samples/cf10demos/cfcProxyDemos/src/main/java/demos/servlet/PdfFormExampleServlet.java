package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSet;

/**
 * User: mnimer
 * Date: 7/4/12
 */
public class PdfFormExampleServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "PdfFormExample.cfc"); //cache this lookup for performance

        long start = System.currentTimeMillis();
        try
        {
            String PolicyNum = req.getParameter("PolicyNum");
            String strInsuredName = req.getParameter("strInsuredName");
            String address1 = req.getParameter("address1");
            String State = req.getParameter("State");
            String Zip = req.getParameter("Zip");
            String city = req.getParameter("city");
            String phone = req.getParameter("phone");
            String bankName = req.getParameter("bankName");
            String PaymentName = req.getParameter("PaymentName");
            String bankAcctNum = req.getParameter("bankAcctNum");
            String bankCity = req.getParameter("bankCity");


            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {PolicyNum, strInsuredName, address1, State, Zip, city, phone, bankName, PaymentName, bankAcctNum, bankCity};
            cfcResult = (Struct)myCFC.invoke("pdfForm", myArgs);
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();


        // send pdf bytes back to browser
        outputPdf(resp, cfcResult, "htmlExample.pdf");
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
