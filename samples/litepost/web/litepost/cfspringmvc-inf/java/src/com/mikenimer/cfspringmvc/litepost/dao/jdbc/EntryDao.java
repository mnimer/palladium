package com.mikenimer.cfspringmvc.litepost.dao.jdbc;

import litepost.model.Entry;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;


/** User: mnimer Date: Jun 17, 2010 Time: 5:58:44 PM */
public class EntryDao
{
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;


    public void setDataSource(DataSource datasource)
    {
        this.jdbcTemplate = new JdbcTemplate(datasource);
    }


    public Entry load(int id)
    {
        String sql = "select * from entries where id = ?";
        Object[] args = new Object[]{id};
        Entry entry = (Entry) this.jdbcTemplate.queryForObject(sql, args, new EntryRowMapper() );

        if (entry == null)
        {
            throw new RuntimeException("invalid entry");
        }

        return entry;
    }


    public Entry save(Entry entry)
    {
        if (entry.getEntryID() == null)
        {
            insert(entry);
        }
        else
        {
            update(entry);
        }

        return load(entry.getEntryID());
    }


    private void insert(Entry entry)
    {
        String sql = "INSERT into entries (entryID, userID, categoryID, title, body, dateCreated, dateLastUpdated ) values (?,?,?,?,?,?,?)";
        Object[] args = new Object[]
                {
                        entry.getEntryID()
                        , entry.getUserID()
                        , entry.getCategoryID()
                        , entry.getTitle()
                        , entry.getBody()
                        , entry.getDateCreated()
                        , entry.getDateLastUpdated()
                };

        int id = this.jdbcTemplate.update(sql, args);
        entry.setEntryID(id);

        //todo add support for comments
    }


    private void update(Entry entry)
    {
        String sql = "UPDATE entries" +
                " set userID = ?" +
                ", categoryID = ?" +
                ", title = ?" +
                ", body = ?" +
                ", dateCreated = ?" +
                ", dateLastUpdated = ?" +
                " WHERE entryID = ?";

        Object[] args = new Object[]
                {
                        entry.getUserID()
                        , entry.getCategoryID()
                        , entry.getTitle()
                        , entry.getBody()
                        , entry.getDateCreated()
                        , entry.getDateLastUpdated()
                        , entry.getEntryID()
                };

        int id = this.jdbcTemplate.update(sql, args);

        //todo add support for comments
    }
}


    /**
     * Converts db rows to java POJO object
     * */
class EntryRowMapper implements RowMapper
{
    public Object mapRow(ResultSet rs, int rowNum) throws SQLException
    {
        Entry entry = new Entry();
        entry.setEntryID(rs.getInt("id"));
        entry.setUserID(rs.getString("userId"));
        entry.setCategoryID(rs.getInt("categoryID"));
        entry.setTitle(rs.getString("title"));
        entry.setBody(rs.getString("body"));
        entry.setDateCreated(rs.getDate("dateCreated"));
        entry.setDateLastUpdated(rs.getDate("dateLastUpdated"));

        return entry;
    }
}