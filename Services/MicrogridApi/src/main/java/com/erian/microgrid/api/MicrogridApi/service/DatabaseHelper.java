package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseHelper 
{
	private String url;
	private static DatabaseHelper instance;

	private DatabaseHelper()
	{
    	
		try {
			Class.forName("com.mysql.jdbc.Driver");
			url = "jdbc:mysql://172.21.76.125:3306/smes_microgrid?user=mysqluser&password=mysql@erian";
            
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		if (instance == null) {
			instance = new DatabaseHelper();
		}
		try {
			return DriverManager.getConnection(instance.url);
		} catch (SQLException e) {
			throw e;
		}
	}
	
	public static void close(Connection connection)
	{
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
