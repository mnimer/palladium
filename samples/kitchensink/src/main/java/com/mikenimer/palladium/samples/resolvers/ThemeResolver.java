package com.mikenimer.palladium.samples.resolvers;

import org.springframework.web.servlet.theme.AbstractThemeResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author: mikenimer@yahoo.com
 */
public class ThemeResolver extends AbstractThemeResolver
{
    /**
     * Return the name of the default theme.
     */
    @Override
    public String getDefaultThemeName()
    {
        return "com.mikenimer.palladium.samples.themes.default";
    }


    /**
     * Resolve the current theme name via the given request.
     * Should return a default theme as fallback in any case.
     *
     * @param request request to be used for resolution
     * @return the current theme name
     */
    public String resolveThemeName( HttpServletRequest request )
    {
        String theme = (String)request.getSession().getAttribute( "theme" );

        if( theme != null )
        {
            return theme;
        }

        return getDefaultThemeName();
    }


    /**
     * Set the current theme name to the given one.
     *
     * @param request   request to be used for theme name modification
     * @param response  response to be used for theme name modification
     * @param themeName the new theme name
     * @throws UnsupportedOperationException if the ThemeResolver implementation
     *                                       does not support dynamic changing of the theme
     */
    public void setThemeName( HttpServletRequest request, HttpServletResponse response, String themeName )
    {
        request.getSession().setAttribute( "theme", "com.mikenimer.palladium.samples.themes." +themeName );
    }
}
