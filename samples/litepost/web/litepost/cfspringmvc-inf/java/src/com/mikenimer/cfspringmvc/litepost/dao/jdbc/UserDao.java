package com.mikenimer.cfspringmvc.litepost.dao.jdbc;

import litepost.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

/** User: mnimer Date: Jun 17, 2010 Time: 1:58:10 PM */
public class UserDao
{
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource datasource)
    {
        this.jdbcTemplate = new JdbcTemplate(datasource);
    }


    public User authorizeUser(String username, String password)
    {
        String sql = "select * from users where email = ? and password = ?";
        Object[] args = new Object[]{ username, password };
        User user = (User)this.jdbcTemplate.queryForObject(sql, args, new UserRowMapper() );

        if( user == null )
        {
            throw new RuntimeException("Invalid login");
        }

        return user;
    }


    public User load(String userId)
    {
        String sql = "select * from users where userId = ?";
        Object[] args = new Object[] { userId };
        User user = (User)this.jdbcTemplate.queryForObject(sql, args, new UserRowMapper() );


        if( user == null )
        {
            throw new RuntimeException("user not found");
        }

        return user;
    }

}


/**
 * Converts db rows to java POJO object
 */
class UserRowMapper implements RowMapper
{
    public Object mapRow(ResultSet rs, int rowNum) throws SQLException
    {
        User user = new User();
        user.setUserId( rs.getInt("userId") );
        user.setEmail(rs.getString("email") );
        user.setFirstName( rs.getString("firstName") );
        user.setLastName( rs.getString("lastName") );
        user.setPassword( rs.getString("password") );
        user.setRole( rs.getString("role") );
        return user;
    }
}