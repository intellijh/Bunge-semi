package net.trade.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import config.DB;

public class TradeDAO {

    public int updateReadCount(int sellerid) {
        String sql = "UPDATE TRADE SET READCOUNT = READCOUNT+1 WHERE SELLERID = ?";
        Connection conn = DB.getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sellerid);
            int result = pstmt.executeUpdate();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally { // 무조건 실행
            DB.close(conn, pstmt);
        }
        return -1;
    }

    public int deleteById(int sellerid) {
        String sql = "DELETE FROM TRADE WHERE sellerid = ?";
        Connection conn = DB.getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sellerid);
            int result = pstmt.executeUpdate();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        } finally { // 무조건 실행
            DB.close(conn, pstmt);
        }
        return -1;
    }
}
