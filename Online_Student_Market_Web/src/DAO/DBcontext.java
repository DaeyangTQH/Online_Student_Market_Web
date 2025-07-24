/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Haichann
 */
public class DBcontext {

protected static Connection connection;

    public DBcontext() {
        try {
            String user = "sa";
            String password = "123";
            String url
                    = "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=OSMW_WEB234;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }
}
