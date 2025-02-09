package com.kleencleaners;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/laundry";
    private static final String USER = "Kleener";
    private static final String PASSWORD = "Kpassw0rd";

    public static Connection getConnection() throws SQLException {
        try {
            // Load and register MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish and return the connection
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
    }
}
