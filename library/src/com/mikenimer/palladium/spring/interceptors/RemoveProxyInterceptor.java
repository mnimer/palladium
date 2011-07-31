package com.mikenimer.palladium.spring.interceptors;

import net.sf.beanlib.hibernate3.Hibernate3BeanReplicator;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;

/**
 * A simple interceptor that uses the BeanLib Hibernate3BeanReplicator to do a deep copy on hibernate objects
 * before returning them to the xml/json view resolvers.
 *
 * This way xml/json which don't support lazyLoading can get the full object graph. But other languages, jsp, flex that can
 * support lazy loading keep the hibernate aware object.
 *
 * note: a deep copy can be expensive. So if you only use xml or json, you should turn off lazy loading in hibernate instead.
 *
 * @author: mikenimer@yahoo.com
 */
public class RemoveProxyInterceptor extends HandlerInterceptorAdapter
{
    private Hibernate3BeanReplicator rep = null;

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception
    {
        super.afterCompletion(request, response, handler, ex);
    }


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        return super.preHandle(request, response, handler);
    }


    /**
     * This method will do a special check
     * request.parameter "Lazy" is not null and false || request ends in .xml or .json
     *
     * if either of these are true, we will do a deep copy of the object
     *  and return the full object graph instead of a hibernate aware proxy object.
     *
     * The idea is that json/xml applications can't support lazy loading. But a server side call (jsp) or a flex application
     * using dpHibernate can support lazy loading of objects in the object graph, so we want to let those through. But we want
     * both all use-cases to use the same controller.
     *
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception
    {
        /**
        String lazyProp = request.getParameter("lazy");
        if( (lazyProp != null && !(new Boolean(lazyProp))) || (request.getRequestURI().toLowerCase().endsWith(".xml") || request.getRequestURI().toLowerCase().endsWith(".json") || request.getRequestURI().toLowerCase().endsWith(".amf")) )
        {
            modelAndView = deepCopyModel(modelAndView);
        }
         **/
        modelAndView = deepCopyModel(modelAndView);
        super.postHandle(request, response, handler, modelAndView);
    }




    private ModelAndView deepCopyModel(ModelAndView mv)
    {
        if( rep == null )
        {
            rep = new Hibernate3BeanReplicator();
        }

        Iterator itr = mv.getModel().keySet().iterator();
        while( itr.hasNext() )
        {
            String key = (String)itr.next();
            if( !key.startsWith("org.springframework") ) //skip spring internal classes (for instance Binding classes)
            {
                mv.addObject(key, rep.deepCopy(mv.getModel().get(key)) );
            }
        }

        return mv;
    }
}
