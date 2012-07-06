package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.sql.QueryTable;
import com.sun.deploy.net.HttpResponse;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * User: mnimer
 * Date: 7/6/12
 */
public class excelServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String action = req.getParameter("action");
        Object cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "spreadsheetExample.cfc"); //cache this lookup for performance

        String dir = "/demos-inf/presentations";
        long start = System.currentTimeMillis();
        try
        {
            if( action.equalsIgnoreCase("write"))
            {
                ResultSet query = runQuery(req);
                dir = dir +"/spreadsheetExample";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir, "spreadsheet1.xls", query};
                cfcResult = myCFC.invoke("queryToExcel", myArgs);
                resp.sendRedirect(dir +"/spreadsheet1.xls");
            }
            if( action.equalsIgnoreCase("readQuery"))
            {
                dir = dir +"/spreadsheetExample";
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {dir, "spreadsheet1.xls", req.getParameter("rows")};
                cfcResult = myCFC.invoke("readExcelQuery", myArgs);
                // output results
                dump(resp, cfcPath, cfcResult);
            }
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();

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
            resultSet = statement.executeQuery("SELECT * FROM Invoice");

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


    private String dump(HttpServletResponse response, String cfcPath, Object arg)
    {
        String dumpResult = "[ERROR DUMPING VALUE]";
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {arg};
            dumpResult = (String)myCFC.invoke("dump", myArgs);

            // output
            response.setContentType("text/html");
            response.getOutputStream().write(dumpResult.getBytes());
        }
        catch (Throwable e)
        {
            e.printStackTrace();
        }
        return dumpResult;
    }
}
