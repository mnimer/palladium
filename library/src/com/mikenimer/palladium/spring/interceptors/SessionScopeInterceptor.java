package com.mikenimer.palladium.spring.interceptors;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * RegisteredUser: mike
 */
public class SessionScopeInterceptor extends HandlerInterceptorAdapter
{
    public String CFSessionName = null;

    public void setCFSessionName( String CFSessionName )
    {
        this.CFSessionName = CFSessionName;
    }


    @Override
    /**
     * A special check to make sure the java user exists in the ColdFusion Session scope
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        /**
        if( CFSessionName != null )
        {
            Map appModel = (Map)request.getSession().getAttribute(CFSessionName);


            if( appModel != null )
            {
                //RegisteredUser registeredUser = new RegisteredUser();
                //appModel.put("user", registeredUser );
                request.getSession().setAttribute(CFSessionName, appModel);
            }
        }
        return true;
         **/
        return false;
    }


    @Override
    public void postHandle( HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView ) throws Exception
    {
        // TODO copy java session objects into CF session scope
        super.postHandle( request, response, handler, modelAndView );
    }
}
