package chat.db;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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


    public JsonArray getChatList() {
        JsonArray array = new JsonArray();
        String sql = "SELECT *\n" +
                "FROM chat";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    JsonObject object = new JsonObject();
                    object.addProperty("sellerId", rs.getString("seller_id"));
                    object.addProperty("buyerId", rs.getString("buyer_id"));
                    object.addProperty("openDate", rs.getString("open_date").substring(0, 16));
                    array.add(object);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getChatList() 에러 : " + e);
        }
        return array;
    }
}
