package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String jdbcURL = "jdbc:mysql://localhost:3306/Web_nhom3?useUnicode=true&characterEncoding=UTF-8";
        String jdbcUsername = "root";
        String jdbcPassword = "12345678";

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}