package config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {

    public static Connection getConnection() {
        try {
            Context init = new InitialContext();
            DataSource ds = (DataSource) init.lookup("java:/comp/jdbc/OracleDB");
            Connection conn = ds.getConnection();

            return conn;
        } catch (Exception e) {
            System.out.println("DB연결실패");
            e.printStackTrace();
        }
        return null;
    }

    public static void close(Connection conn, PreparedStatement pstmt) {
        try {
            conn.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            conn.close();
            pstmt.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
