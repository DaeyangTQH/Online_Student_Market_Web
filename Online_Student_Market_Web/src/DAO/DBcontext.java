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

//    public DBcontext() {
//        try {
//            String url = "jdbc:sqlserver://prj301-gr17.database.windows.net:1433;"
//                    + "database=OSMW_WEB;"
//                    + "encrypt=true;"
//                    + "trustServerCertificate=false;"
//                    + "hostNameInCertificate=*.database.windows.net;"
//                    + "loginTimeout=30;";
//            String user = "haitran";
//            String pass = "Group17prj@";
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            connection = DriverManager.getConnection(url, user, pass);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    public DBcontext() {
        try {
            String user = "sa";
            String password = "tranhai123456789";
            String url
                    = "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=OSMW_WEB;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    

}
