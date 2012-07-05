package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;
import coldfusion.sql.QueryTable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * User: mnimer
 * Date: 7/4/12
 */
public class PdfHtmlExampleServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "PdfHtmlExample.cfc"); //cache this lookup for performance

        ResultSet artists = runQuery(req);

        long start = System.currentTimeMillis();
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {artists};
            cfcResult = (Struct)myCFC.invoke("artistList", myArgs);
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


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "PdfHtmlExample.cfc"); //cache this lookup for performance


        String html = "Hello <b>World</b>";
        if( req.getParameter("html") != null )
        {
            html = req.getParameter("html");
        }

        long start = System.currentTimeMillis();
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {html};
            cfcResult = (Struct)myCFC.invoke("htmlToPdf", myArgs);
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


    private ResultSet runQuery(HttpServletRequest request)
    {
        Connection connection = null;
        ResultSet resultSet = null;
        Statement statement = null;
        QueryTable cfquery = null;

        try {
            Class.forName("org.sqlite.JDBC");
            String dbPath = request.getRealPath("/WEB-INF/classes/Chinook_Sqlite.sqlite");
            connection = DriverManager.getConnection("jdbc:sqlite:" + dbPath);
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM Artist");

            //debug
            //while (resultSet.next()){System.out.println("artist:"+ resultSet.getString("Name"));}

            // save the result off into a cfquery (disconnected from db connection) for later use
            cfquery = new QueryTable();
            cfquery.populate(resultSet);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return cfquery;
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
