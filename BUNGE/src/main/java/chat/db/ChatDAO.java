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
import java.util.ArrayList;
import java.util.List;

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

    public List<Chat> getChatList(String id) {

        List<Chat> list = new ArrayList<>();
        String sql =
                "SELECT c.chat_id, c.seller_id, c.buyer_id, c.update_date, m.content\n" +
                "FROM chat c\n" +
                "         JOIN chat_message m ON c.chat_id = m.chat_id\n" +
                "WHERE (c.seller_id = ? OR c.buyer_id = ?)\n" +
                "  AND m.send_date = (SELECT MAX(send_date)\n" +
                "                     FROM chat_message\n" +
                "                     WHERE chat_id = c.chat_id)\n" +
                "ORDER BY c.update_date DESC";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Chat chat = new Chat();
                    chat.setChatId(Long.parseLong(rs.getString("chat_id")));
                    chat.setSellerId(rs.getString("seller_id"));
                    chat.setBuyerId(rs.getString("buyer_id"));
                    chat.setUpdateDate(rs.getString("update_date").substring(0, 16));
                    chat.setLatestContent(rs.getString("content"));
                    list.add(chat);
                }
            }
        } catch (Exception e) {
            System.out.println("getChatList() 에러 : " + e.getStackTrace()[0]);
        }
        return list;
    }

    public long hasChatExist(Chat chat) {

        long chatId = 0L;
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
                    chatId = rs.getLong("chat_id");
                }
            } catch (SQLException e) {
                System.out.println("hasChatExist() 에러 : " + e.getStackTrace()[0]);
            }
        } catch (Exception e) {
            System.out.println("hasChatExist() 에러 : " + e.getStackTrace()[0]);
        }
        return chatId;
    }

    public long createChat(Chat chat) {

        long chatId = 0;
        String sql =
                "INSERT INTO chat\n" +
                "VALUES (?, ?, ?, ?, SYSTIMESTAMP, SYSTIMESTAMP)";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            chatId = incrementChatId(conn);
            pstmt.setLong(1, chatId); //서비스 전에 chat_seq.nextval 로 변경
            pstmt.setString(2, chat.getSellerId());
            pstmt.setString(3, chat.getBuyerId());
            pstmt.setLong(4, chat.getTrade_id());
            pstmt.executeUpdate();
        } catch (Exception e) {
//            System.out.println("createChat() 에러 : " + e.getStackTrace()[0]);
            e.printStackTrace();
        }
        return chatId;
    }

    private long incrementChatId(Connection conn) throws SQLException {
        long result = 0L;
        String sql =
                "SELECT MAX(NVL(chat_id, 0)) + 1\n" +
                "FROM chat";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result = rs.getLong(1);
                }
            }
        }
        return result;
    }

    public int delete(Long chatId, String loginId, String sellerId) {

        int result = 0;

        String sql;
        if (loginId.equals(sellerId)) {
            sql =
                    "UPDATE chat\n" +
                    "SET seller_id = NULL\n" +
                    "WHERE chat_id = ?";
        } else {
            sql =
                    "UPDATE chat\n" +
                    "SET buyer_id = NULL\n" +
                    "WHERE chat_id = ?";
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, chatId);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
