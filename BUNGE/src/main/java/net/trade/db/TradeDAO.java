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
    public int insertTrade(Trade trade) throws SQLException{
        // 비밀번호는 SHA-1 암호화
        String sql = "INSERT INTO trade (tradeid,imageID) values(?,?)";


        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, trade.getTradeID());
        pstmt.setString(2, trade.getImageID());

        pstmt.executeUpdate();

        // 마지막 업로드된 ID 가져옴 (비권장)
        sql = "SELECT LAST_INSERT_ID() AS last_id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        rs.next();

        return rs.getInt("last_id");
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
    public ArrayList<Trade> searchVideoByDesc(String keyword) throws SQLException{
        String sql = "SELECT thumbnail,title,author,date,id from video where description like ? order by id desc";

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

//    // 비밀번호 일치 체크
//    public boolean passwordCheck(int id,String password) throws SQLException {
//        String sql = "select EXISTS (select * from video where id=? and password=password(?)) as success";
//
//        pstmt = con.prepareStatement(sql);
//        pstmt.setInt(1, id);
//        pstmt.setString(2, password);
//        rs = pstmt.executeQuery();
//
//        rs.next();
//        return rs.getBoolean("success");
//    }
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
//    // 비디오 수정
//    public void updateVideo(Video video) throws SQLException {
//        String sql = "UPDATE video SET title=?,video=?,thumbnail=?,description=? WHERE id=?";
//
//
//        pstmt = con.prepareStatement(sql);
//        pstmt.setString(1, video.getTitle());
//        pstmt.setString(2, video.getVideo());
//        pstmt.setString(3, video.getThumbnail());
//        pstmt.setString(4, video.getDesc());
//        pstmt.setInt(5, video.getId());
//
//        pstmt.executeUpdate();
//    }
//
    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
//}






}
