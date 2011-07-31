package com.mikenimer.cfspringmvc.litepost.model;


/** User: mikenimer@yahoo.com Date: Jun 17, 2010 Time: 12:17:03 PM */
public class User
{

    public Integer UserId;
    public String firstName;
    public String lastName;
    public String email;
    public String userName;
    public String password;
    public String role;


    public Integer getUserId()
    {
        return UserId;
    }


    public void setUserId(Integer userId)
    {
        UserId = userId;
    }


    public String getFirstName()
    {
        return firstName;
    }


    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }


    public String getLastName()
    {
        return lastName;
    }


    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }


    public String getEmail()
    {
        return email;
    }


    public void setEmail(String email)
    {
        this.email = email;
    }


    public String getUserName()
    {
        return userName;
    }


    public void setUserName(String userName)
    {
        this.userName = userName;
    }


    public String getPassword()
    {
        return password;
    }


    public void setPassword(String password)
    {
        this.password = password;
    }


    public String getRole()
    {
        return role;
    }


    public void setRole(String role)
    {
        this.role = role;
    }
}
