package chat.db;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChatDAO {

    private DataSource ds;

    public ChatDAO() {
        try {
            Context init = new InitialContext();
            ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
        } catch (Exception e) {
            System.out.println("DB 연결 실패 : " + e);
        }
    }

    public JsonArray getChatList(String id) {

        JsonArray array = new JsonArray();
        String sql = "SELECT *\n" +
                "FROM chat\n" +
                "WHERE seller_id = ?\n" +
                "OR buyer_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    JsonObject object = new JsonObject();
                    object.addProperty("chatId", rs.getString("chat_id"));
                    object.addProperty("sellerId", rs.getString("seller_id"));
                    object.addProperty("buyerId", rs.getString("buyer_id"));
                    object.addProperty("updateDate", rs.getString("update_date").substring(0, 16));
                    array.add(object);
                }
            }
        } catch (Exception e) {
            System.out.println("getChatList() 에러 : " + e.getStackTrace()[0]);
        }
        return array;
    }

    public boolean hasChatExist(Chat chat) {

        boolean result = false;
        String sql =
                "SELECT *\n" +
                "FROM chat\n" +
                "WHERE seller_id = ?\n" +
                "AND buyer_id = ?\n" +
                "AND trade_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, chat.getSellerId());
            pstmt.setString(2, chat.getBuyerId());
            pstmt.setLong(3, chat.getTrade_id());
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result = true;
                }
            } catch (SQLException e) {
                System.out.println("hasChatExist() 에러 : " + e.getStackTrace()[0]);
            }
        } catch (Exception e) {
            System.out.println("hasChatExist() 에러 : " + e.getStackTrace()[0]);
        }
        return result;
    }

    public int createChat(Chat chat) {

        int result = 0;
        String sql =
                "INSERT INTO chat\n" +
                "VALUES (?, ?, ?, ?, SYSTIMESTAMP, SYSTIMESTAMP)";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, incrementChatId(conn)); //서비스 전에 chat_seq.nextval 로 변경
            pstmt.setString(2, chat.getSellerId());
            pstmt.setString(3, chat.getBuyerId());
            pstmt.setLong(4, chat.getTrade_id());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("createChat() 에러 : " + e.getStackTrace()[0]);
        }
        return result;
    }

    private long incrementChatId(Connection conn) throws SQLException {
        String sql =
                "SELECT MAX(NVL(chat_id, 0)) + 1\n" +
                "FROM chat";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.getLong(1);
            }
        }
    }
}
