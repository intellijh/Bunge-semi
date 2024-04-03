package chat.db;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDao {

    private DataSource ds;

    public MessageDao() {
        try {
            Context init = new InitialContext();
            ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
        } catch (Exception e) {
            System.out.println("DB 연결 실패 : " + e);
        }
    }


    public int insertText(Message message) {
        int result = 0;
        String sql =
                "INSERT INTO chat_message\n" +
                "VALUES(message_seq.nextval, ?, ?, ?, SYSTIMESTAMP, 'N')";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, message.getChatId());
            pstmt.setString(2, message.getMemberId());
            pstmt.setString(3, message.getContent());
            result = pstmt.executeUpdate();

            if (result > 0) {
                updateChatDate(conn, message);
            }
        } catch (Exception e) {
            System.out.println("insertText() 에러: " + e.getStackTrace()[0]);
        }

        return result;
    }

    public List<Message> getMessage(int chatId) {

        List<Message> list = new ArrayList<>();
        String sql =
                "SELECT *\n" +
                "FROM chat_message\n" +
                "WHERE chat_id = ?\n" +
                "ORDER BY MESSAGE_ID";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, chatId);
            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    long id = rs.getLong("chat_id");
                    String memberId = rs.getString("member_id");
                    String content = rs.getString("content");
                    String sendDate = rs.getString("send_date");
                    char contentType = rs.getString("content_type").charAt(0);
                    Message message = new Message(id, memberId, content, sendDate, contentType);

                    list.add(message);
                }
            } catch (SQLException e) {
                System.out.println("getMessage() 에러: " + e.getStackTrace()[0]);
            }
        } catch (Exception e) {
            System.out.println("getMessage() 에러: " + e.getStackTrace()[0]);
        }

        return list;
    }

    private int updateChatDate(Connection conn, Message message) {

        int result = 0;
        String sql =
                "UPDATE chat\n" +
                "SET update_date = SYSTIMESTAMP\n" +
                "WHERE chat_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, message.getChatId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
