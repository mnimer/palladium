package demos.servlet;

import coldfusion.cfc.CFCProxy;
import coldfusion.image.Image;
import coldfusion.runtime.Struct;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

/**
 * User: mnimer
 * Date: 7/5/12
 */
public class ImageServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Object cfcResult = null;
        String cfcPath = req.getRealPath("/demos-inf/components/" + "ImageExample.cfc"); //cache this lookup for performance

        String action = req.getParameter("action");
        long start = System.currentTimeMillis();
        if( action.equalsIgnoreCase("info"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {"/demos-inf/images/kids.jpg"};
                cfcResult = myCFC.invoke("imageInfo", myArgs);

                resp.getOutputStream().write( dump(cfcPath, cfcResult).getBytes() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        else if( action.equalsIgnoreCase("rotate"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {"/demos-inf/images/kids.jpg", req.getParameter("angle")};
                cfcResult = myCFC.invoke("rotateImage", myArgs);

                outputImage(resp, ((Image)cfcResult).getCurrentImage() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        else if( action.equalsIgnoreCase("resize"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {"/demos-inf/images/kids.jpg", req.getParameter("width"), req.getParameter("height")};
                cfcResult = myCFC.invoke("resizeImage", myArgs);

                outputImage(resp, ((Image)cfcResult).getCurrentImage() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        else if( action.equalsIgnoreCase("border"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {"/demos-inf/images/kids.jpg", req.getParameter("color"), req.getParameter("thickness")};
                cfcResult = myCFC.invoke("addBorder", myArgs);

                outputImage(resp, ((Image)cfcResult).getCurrentImage() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        else if( action.equalsIgnoreCase("watermark"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {"/demos-inf/images/kids.jpg", req.getParameter("message")};
                cfcResult = myCFC.invoke("addWatermark", myArgs);

                outputImage(resp, ((Image)cfcResult).getCurrentImage() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        else if( action.equalsIgnoreCase("captcha"))
        {
            try
            {
                CFCProxy myCFC = new CFCProxy(cfcPath, false);
                Object[] myArgs = {req.getParameter("difficulty"),req.getParameter("width"),req.getParameter("height"),req.getParameter("text")};
                cfcResult = myCFC.invoke("generateCaptcha", myArgs);

                outputImage(resp, ((Image)cfcResult).getCurrentImage() );
            }
            catch (Throwable e)
            {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }

        long end = System.currentTimeMillis();
    }



    private void outputImage(HttpServletResponse resp, BufferedImage image) throws IOException
    {
        resp.setContentType("image/png");
        OutputStream out = resp.getOutputStream();
        ImageIO.write(image, "png", out);
        out.flush();
    }


    private String dump(String cfcPath, Object arg)
    {
        String dumpResult = "[ERROR DUMPING VARIABLE] " +arg.toString();
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
