package chat.db;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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


}
