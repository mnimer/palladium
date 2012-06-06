package coldfusion.bootstrap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * User: mnimer
 * Date: 6/5/12
 */
public class SpringContextLoaderListener implements ServletContextListener
{
    private ClassLoader bscl;
    private ServletContextListener listener;


    public void contextInitialized(ServletContextEvent servletContextEvent)
    {
        try
        {
            String listenerClass = "org.springframework.web.context.ContextLoaderListener";
            ClassloaderHelper cHelper = ClassloaderHelper.getInstance();
            cHelper.init(servletContextEvent.getServletContext());
            bscl = cHelper.getClassLoader();
            //todo: get Adobe to add an initListener to the ColdFusion ClassLoaderHelper
            listener = (ServletContextListener) cHelper.getClassLoader().loadClass(listenerClass).newInstance();
        }
        catch (Exception ex)
        {
            throw new RuntimeException(ex);
        }

        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        ClassLoader bootstrap = BootstrapClassLoader.instance();
        Thread.currentThread().setContextClassLoader(bootstrap);

        listener.contextInitialized(servletContextEvent);

        Thread.currentThread().setContextClassLoader(cl);

    }


    public void contextDestroyed(ServletContextEvent event)
    {

        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        Thread.currentThread().setContextClassLoader(bscl);

        listener.contextDestroyed(event);

        Thread.currentThread().setContextClassLoader(cl);


    }
}
