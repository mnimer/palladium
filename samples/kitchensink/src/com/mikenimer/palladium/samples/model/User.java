package com.mikenimer.palladium.samples.model;

/**
 * @author: mikenimer@yahoo.com
 */
public class User
{
    private String username;
    private String password;
    private int  access = 0;


    public int getAccess()
    {
        return access;
    }


    public void setAccess( int access )
    {
        this.access=access;
    }


    public String getPassword()
    {
        return password;
    }


    public void setPassword( String password )
    {
        this.password=password;
    }


    public String getUsername()
    {
        return username;
    }


    public void setUsername( String username )
    {
        this.username=username;
    }
}
