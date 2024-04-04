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
        int tradeid =0;
        String tradeid_sql ="SELECT TRADE_SEQUENCE.NEXTVAL FROM DUAL";
        try (PreparedStatement pstmt = conn.prepareStatement(tradeid_sql);) {
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    tradeid = rs.getInt(1);
                }
            }
        }

        String sql = "INSERT INTO trade (imageID, sellerID, description, title, category, quality, condition, tradeMethod, price,tradeID,password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setString(1, trade.getImageID());
            pstmt.setString(2, trade.getSellerID());
            pstmt.setString(3, trade.getDescription());
            pstmt.setString(4, trade.getTitle());
            pstmt.setString(5, trade.getCategory());
            pstmt.setString(6, trade.getQuality());
            pstmt.setString(7, trade.getCondition());
            pstmt.setString(8, trade.getTradeMethod());
            pstmt.setInt(9, trade.getPrice());
            pstmt.setInt(10, tradeid);
            pstmt.setString(11, trade.getPassword());

            pstmt.executeUpdate();

        }
        return tradeid;
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
            trade.setCreateDate(rs.getTimestamp("createDate"));
            trade.setDescription(rs.getString("description"));
            trade.setImageID(rs.getString("imageID"));
            trade.setTitle(rs.getString("title"));
            trade.setPrice(rs.getInt("price"));
            trade.setCategory(rs.getString("category"));
            trade.setCondition(rs.getString("condition"));
            trade.setQuality(rs.getString("quality"));
            trade.setTradeMethod(rs.getString("tradeMethod"));

            return trade;
        } else {
            return null;
        }
    }
//
//    // 목록 출력을 위한 SELECT
    public ArrayList<Trade> getTradeList() throws SQLException{
        String sql = "SELECT imageID,title,sellerID,createDate,tradeID,price,category,quality,condition from trade order by tradeID desc";

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
            trade.setPrice(rs.getInt("price"));
            trade.setCategory(rs.getString("category"));
            trade.setQuality(rs.getString("quality"));
            trade.setCondition(rs.getString("condition"));


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
    public boolean passwordCheck(int tradeID, String password) throws SQLException {
        String sql = "SELECT CASE WHEN EXISTS (SELECT 1 FROM trade WHERE tradeID=? AND password=?) THEN 'true' ELSE 'false' END AS success FROM dual";

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, tradeID);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        rs.next();
        return rs.getBoolean("success");
    }

    // 비디오 삭제
    public boolean deleteTrade(int tradeID) throws SQLException{
        String sql = "DELETE from trade WHERE tradeID=?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tradeID);
            pstmt.executeUpdate();
        }
        return true;
    }
;
    // 비디오 수정
    public boolean updateTrade(Trade trade) {
        boolean result = false;
        // SQL 쿼리 작성
        String sql = "UPDATE trade SET imageID=?, description=?, title=?, category=?, quality=?, condition=?, tradeMethod=?, price=? WHERE tradeID=?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            // 매개변수 설정
            pstmt.setString(1, trade.getImageID());
            pstmt.setString(2, trade.getDescription());
            pstmt.setString(3, trade.getTitle());
            pstmt.setString(4, trade.getCategory());
            pstmt.setString(5, trade.getQuality());
            pstmt.setString(6, trade.getCondition());
            pstmt.setString(7, trade.getTradeMethod());
            pstmt.setInt(8, trade.getPrice());
            pstmt.setInt(9, trade.getTradeID());

            // 쿼리 실행
            int rows = pstmt.executeUpdate();
            // 업데이트가 성공적으로 수행되면 rows 값이 1 이상이 됩니다.
            System.out.println("업데이트 후" + rows) ;
            if (rows > 0) {
                result = true;
                System.out.println("업데이트 성공!");
            }
        } catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }
        return result;
    }

    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }

    public boolean isBoardWriter(int num, String password) throws SQLException {
        boolean result = false;
        String trade_sql = "select password from trade where tradeID=?";
        try(PreparedStatement pstmt = conn.prepareStatement(trade_sql);) {
            pstmt.setInt(1, num);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    if (password.equals(rs.getString("password"))) {
                        result = true;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException ex) {
            System.out.println("isBoardWriter() 에러 : " + ex);
            ex.printStackTrace();
        }
        return result;
    }

    public void hitReadCount(int tradeID) {
        int readCount = 0;
        int rs = 0;

        String sql = "update trade set readcount = (readcount+1) where tradeID =?";
        try {

        } catch(Exception e) {
            e.printStackTrace();
        }

    }


//    public void insertImagePath(String imagePath) {
//        String sql = "INSERT INTO trade (imageID) VALUES (?)";
//
//        try {
//            PreparedStatement pstmt = conn.prepareStatement(sql);
//            pstmt.setString(1, imagePath);
//            pstmt.executeUpdate();
//            pstmt.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//}






}
