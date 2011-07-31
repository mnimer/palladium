package com.mikenimer.palladium.utils;

import java.util.Vector;

/**
 * @author: mikenimer@yahoo.com
 */
public class CollectionHelper
{

    /**
     * Convert generic java Collections (Iterable) into an array CF Can understand - aka Vector
     * @param collection
     * @return
     */
    public Vector toCFArray(Iterable collection)
    {
        Vector vector = new Vector();

        if( collection != null )
        {
            for (Object o : collection)
            {
                vector.add(o);
            }
        }
        return vector;
    }


}
