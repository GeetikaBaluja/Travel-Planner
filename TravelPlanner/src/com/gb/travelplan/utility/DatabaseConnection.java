package com.gb.travelplan.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
	private Connection prepareDatabaseConnection() throws Exception {
		String path = "jdbc:mysql://localhost:3306/";
		String place = "tourismdb";
		String uname = "root";
		String pass = "root";
		String MYSQL_DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
		Connection myconnection = null;
		try {
			Class.forName(MYSQL_DRIVER_NAME);
			myconnection = DriverManager.getConnection(path + place, uname, pass);
			return myconnection;
		} catch (Exception e) {
			throw new Exception("Database ConnectionFailed");
		}
	}

	public Connection getDatabaseConnection() throws Exception {
		return prepareDatabaseConnection();
	}
}