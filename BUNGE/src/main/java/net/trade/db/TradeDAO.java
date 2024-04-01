package net.trade.db;

import javax.naming.NamingException;
import java.util.ArrayList;
import java.sql.*;



public class TradeDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public TradeDAO() throws SQLException, NamingException{
        conn = DsCon.getConnection();
    }



    // 사진 업로드
    public int insertTrade(Trade trade) throws SQLException {
        String sql = "INSERT INTO trade (imageID, sellerID, description, title, category, quality, condition, tradeMethod) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, trade.getImageID());
        pstmt.setString(2, trade.getSellerID());
        pstmt.setString(3, trade.getDescription());
        pstmt.setString(4, trade.getTitle());
        pstmt.setString(5, trade.getCategory());
        pstmt.setString(6, trade.getQuality());
        pstmt.setString(7, trade.getCondition());
        pstmt.setString(8, trade.getTradeMethod());

        pstmt.executeUpdate();

        // 새로 삽입된 거래의 ID 반환
        rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        } else {
            throw new SQLException("Failed to insert trade, no ID obtained.");
        }
    }

     //조회를 위한 비디오 하나의 정보 SELECT
    public Trade selectOneTradeById(int tradeID) throws SQLException{
        String sql = "SELECT * FROM trade WHERE tradeid=?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, tradeID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            Trade trade= new Trade();
            trade.setTradeID(tradeID);
            trade.setSellerID(rs.getString("sellerID"));
            // Mariadb의 DATETIME 객체에서 분 단위까지만 substring
            trade.setCreateDate(rs.getTimestamp("createDate"));
            trade.setDescription(rs.getString("description"));
            trade.setImageID(rs.getString("imageID"));
            trade.setTitle(rs.getString("title"));

            return trade;
        } else {
            return null;
        }
    }
//
//    // 목록 출력을 위한 SELECT
    public ArrayList<Trade> getTradeList() throws SQLException{
        String sql = "SELECT imageID,title,sellerID,createDate,tradeID from trade order by tradeID desc";

        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        ArrayList<Trade> list = new ArrayList<Trade>();

        while (rs.next()) {
            Trade trade = new Trade();
            trade.setTradeID(rs.getInt("tradeID"));
            trade.setSellerID(rs.getString("sellerID"));
            // Mariadb의 DATETIME 객체에서 분 단위까지만 substring
            trade.setCreateDate(rs.getTimestamp("createDate"));
            trade.setImageID(rs.getString("imageID"));
            trade.setTitle(rs.getString("title"));

            list.add(trade);
        }

       return list;
    }
//
//    // 제목으로 책 검색
    public ArrayList<Trade> searchTradeByTitle(String keyword) throws SQLException{
        String sql = "SELECT imageID,title,sellerID,createdate,tradeID from trade where title like ? order by tradeID desc";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%"+keyword+"%");
        rs = pstmt.executeQuery();
        ArrayList<Trade> list = new ArrayList<Trade>();

        while (rs.next()) {
            Trade trade = new Trade();
            trade.setTradeID(rs.getInt("tradeID"));
            trade.setSellerID(rs.getString("sellerID"));
            // Mariadb의 DATETIME 객체에서 분 단위까지만 substring
            trade.setCreateDate(rs.getTimestamp("createDate"));
            trade.setImageID(rs.getString("imageID"));
            trade.setTitle(rs.getString("title"));

            list.add(trade);
        }

        return list;
    }

    // 내용으로 책 검색
    public ArrayList<Trade> searchTradeByDesc(String keyword) throws SQLException{
        String sql = "SELECT imageID,title,sellerID,createdate,tradeID from trade where description like ? order by tradeID desc";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%"+keyword+"%");
        rs = pstmt.executeQuery();
        ArrayList<Trade> list = new ArrayList<Trade>();

        while (rs.next()) {
            Trade trade = new Trade();
            trade.setTradeID(rs.getInt("tradeID"));
            trade.setSellerID(rs.getString("sellerID"));
            // Mariadb의 DATETIME 객체에서 분 단위까지만 substring
            trade.setCreateDate(rs.getTimestamp("createDate"));
            trade.setImageID(rs.getString("imageID"));
            trade.setTitle(rs.getString("title"));

            list.add(trade);
        }

        return list;
    }

    // 비밀번호 일치 체크
    public boolean passwordCheck(int tradeID,String password) throws SQLException {
        String sql = "select EXISTS (select * from video where tradeID=? and password=password(?)) as success";

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, tradeID);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        rs.next();
        return rs.getBoolean("success");
    }
//
//    // 비디오 삭제
//    public void deleteVideo(int id) throws SQLException{
//        String sql = "DELETE from video WHERE id=?";
//
//        pstmt = con.prepareStatement(sql);
//        pstmt.setInt(1, id);
//        pstmt.execute();
//
//        // 연관된 댓글 삭제
//        sql = "DELETE from comment WHERE video_id=?";
//        pstmt = con.prepareStatement(sql);
//        pstmt.setInt(1, id);
//        pstmt.execute();
//    }
//
    // 비디오 수정
    public void updateTrade(Trade trade) throws SQLException {
        String sql = "UPDATE trade SET title=?,imageID=?,description=?,sellerID=? WHERE tradeID=?";


        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, trade.getTitle());
        pstmt.setString(2, trade.getImageID());
        pstmt.setString(3, trade.getDescription());
        pstmt.setString(4, trade.getSellerID());
        pstmt.setInt(5, trade.getTradeID());

        pstmt.executeUpdate();
    }

    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
//}






}
