package com.mikenimer.cfspringmvc.litepost.dao.jdbc;

import litepost.model.Category;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

/** User: mnimer Date: Jun 17, 2010 Time: 5:52:00 PM */
public class CategoryDao
{
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;


    public void setDataSource(DataSource datasource)
    {
        this.jdbcTemplate = new JdbcTemplate(datasource);
    }


    public Collection listAll()
    {
        String sql = "SELECT * from categories";
        Collection categoriesList = this.jdbcTemplate.queryForList(sql, new CategoryRowMapper() );

        return categoriesList;
    }
}



/**
 * Converts db rows to java POJO object
 */
class CategoryRowMapper implements RowMapper
{
    public Object mapRow(ResultSet rs, int rowNum) throws SQLException
    {
        Category category = new Category();
        category.setCategory(rs.getString("category"));
        category.setCategoryID( rs.getInt("categoryID") );
        category.setNumPosts( 0 ); // todo
        return category;
    }
}