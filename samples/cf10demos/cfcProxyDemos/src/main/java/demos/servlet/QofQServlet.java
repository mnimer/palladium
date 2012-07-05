package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.runtime.Struct;
import coldfusion.sql.QueryTable;

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
 * Date: 6/25/12
 */
public class QofQServlet extends HttpServlet
{
    private static ResultSet cachedResultSet = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Struct cfcResult = null;
        String cfcPath = request.getRealPath("/demos-inf/components/" + "qofqExample.cfc"); //cache this lookup for performance

        String keyword = request.getParameter("q");
        if( keyword == null )
        {
            keyword = "Led Zeppelin";
        }
        
        long start = System.currentTimeMillis();
        try
        {
            if( cachedResultSet == null )
            {
                cachedResultSet = runQuery(request);
            }

            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {keyword, cachedResultSet};
            cfcResult = (Struct)myCFC.invoke("findArtist", myArgs);
        }
        catch (Throwable e)
        {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        long end = System.currentTimeMillis();



        String result = "<strong>Query of Query Example</strong>";
        result += "<form method='get'>Search For: <input type='text' name='q' value='" +keyword +"'><input type='submit' value='search'></form><br/>";
        result += "Output (cf: " +(end-start) +"ms)<br/>";
        result += "Filtered Query:<br/>";
        result += dump(cfcPath, cfcResult.get("filteredQuery"));

        //result += "Full Query:<br/>";

        response.setContentType("text/html");
        response.getOutputStream().write(result.getBytes());
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
            connection = DriverManager.getConnection("jdbc:sqlite:" +dbPath);
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
    
    
    private String dump(String cfcPath, Object arg)
    {
        String dumpResult = "[ERROR]";
        try
        {
            CFCProxy myCFC = new CFCProxy(cfcPath, false);
            Object[] myArgs = {arg};
            dumpResult = (String)myCFC.invoke("dump", myArgs);
        }
        catch (Throwable e)
        {
            //throw new RuntimeException(e);
        }
        return dumpResult;
    }
}
