package org.example.thuchanh.until;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/phongtro", "codegym", "raisingthebar"
        );
    }
}