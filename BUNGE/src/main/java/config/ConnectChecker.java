package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ConnectChecker {
    public static void main(String[] args) throws Exception {


        String sql = "select * from trade";
        String diver = "oracle.jdbc.driver.OracleDriver";
        String dbUrl = "jdbc:oracle:thin:@175.192.130.123:1521:xe";
        String id = "bunge";
        String pw = "book";
        PreparedStatement pstmt = null;
        Connection conn = null;


        ResultSet rs = null;
        try {
            Class.forName(diver);  //드라이버 연결
            conn = DriverManager.getConnection(dbUrl,id,pw); //DB주소, id, pw 를 통해 DB연결
            pstmt = conn.prepareStatement(sql); ///prepareStatement 를 통해 sql문 할당
            rs = pstmt.executeQuery(); //실행

            while(rs.next()){  //결과값을 반복물을 통해서 출력
                System.out.println("trid : "+rs.getString(1));
                System.out.println("sellerid : "+rs.getString(2));
                System.out.println("title : "+rs.getString(3));
                System.out.println("title : "+rs.getString(4));
                System.out.println("title : "+rs.getString(5));
                System.out.println("title : "+rs.getString(6));
                System.out.println("title : "+rs.getString(7));
                System.out.println("title : "+rs.getString(8));
                System.out.println("title : "+rs.getString(9));
                System.out.println("title : "+rs.getString(10));
                System.out.println("title : "+rs.getString(11));
                System.out.println("title : "+rs.getString(12));
                System.out.println("title : "+rs.getString(13));
                System.out.println("title : "+rs.getString(14));
            }

        }catch(Exception e){
            e.printStackTrace();

        } finally {

            //마지막으로 사용된 모든 자원 반환
            if(rs != null) {
                rs.close();
            }
            if(pstmt != null) {
                pstmt.close();
            }
            if(conn != null) {
                conn.close();
            }
        }
    }
}