package com.mikenimer.palladium.spring.mvc.views;

import java.util.Map;
import java.util.Vector;

/**
 * Handle the auto conversion features to make the java more CF friendly
 *
 * @author: mikenimer@yahoo.com
 */
public class ColdFusionSerializer
{
    private Boolean convertKeys=false;
    private Boolean convertCollections=false;
    private Boolean lowerCaseKeys=false;
    private Boolean convertNullToString=false;


    public ColdFusionSerializer( Boolean convertCollections, Boolean convertKeys, Boolean convertNullToString, Boolean lowerCaseKeys )
    {
        this.convertCollections=convertCollections;
        this.convertKeys=convertKeys;
        this.convertNullToString=convertNullToString;
        this.lowerCaseKeys=lowerCaseKeys;
    }


    protected boolean modifyObjects()
    {
        if ( !convertCollections && !convertKeys && !convertNullToString && !lowerCaseKeys )
        {
            return false;
        }
        return true;
    }


    protected Object serialize( Object object )
    {

        if ( object instanceof Map )
        {
            return serialize( (Map) object );
        }
        else if ( object instanceof Iterable )
        {
            return serialize( (Iterable) object );
        }

        if ( convertNullToString )
        {
            if ( object == null )
            {
                object="";
            }
        }
        return object;
    }


    /**
     * Convert Object[] to Vectors for CF
     *
     * @param object
     * @return
     */
    protected Vector serialize( Object[] object )
    {
        Vector vector=new Vector();
        for ( int i=0; i < object.length; i++ )
        {
            vector.add( serialize( object[i] ) );
        }

        return vector;
    }


    protected int serialize( int object )
    {
        return object;
    }


    protected boolean serialize( boolean object )
    {
        return object;
    }


    protected byte serialize( byte object )
    {
        return object;
    }


    protected short serialize( short object )
    {
        return object;
    }


    protected long serialize( long object )
    {
        return object;
    }


    protected float serialize( float object )
    {
        return object;
    }


    protected double serialize( double object )
    {
        return object;
    }


    protected char serialize( char object )
    {
        return object;
    }


    protected Object serialize( Map map )
    {
        if ( !modifyObjects() )
        {
            return map;
        }

        Object[] keys=map.entrySet().toArray();
        for ( int i=0; i < keys.length; i++ )
        {
            Map.Entry key=(Map.Entry) keys[i];
            Object item=map.get( key.getKey() );

            if ( convertKeys || lowerCaseKeys )
            {
                //map.remove( key );
                map.remove( key.getKey() );
                //map.remove( item );

                if ( convertKeys || key.getKey() instanceof String )
                {
                    String k=key.getKey().toString();

                    if ( lowerCaseKeys )
                    {
                        k=k.toLowerCase();
                    }

                    map.put( k, serialize( item ) );
                }
                else
                {
                    map.put( key.getKey().toString(), serialize( item ) );
                }
            }
            else
            {
                // run single items in
                map.put( key, serialize( item ) );
            }
        }


        return map;
    }


    protected Object serialize( Iterable collection )
    {
        if ( !modifyObjects() )
        {
            return collection;
        }


        // convert collections to Vector, so CF can use it
        Vector vector=new Vector();

        for ( Object item : collection )
        {
            vector.add( serialize( item ) );
        }
        return vector;

    }


}
