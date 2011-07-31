package com.mikenimer.palladium.utils;

/**
 * @author: mikenimer@yahoo.com
 */
public class PropertyHelper
{


    /**
     * Since CF doesn't understand java NULL, this wrapper will return a default value for java object that are null
     * @param object
     * @param defaultVal
     * @return
     */
    public Object ifNull(Object object, Object defaultVal)
    {
        if( object == null )
        {
            return defaultVal;
        }
        return object;
    }


}
