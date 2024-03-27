package common.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public BoardDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	

	public boolean boardInsert(Board board) {
		int result = 0;
		String max_sql = "(select nvl(max(board_num),0)+1 from board)";

		// 원문글의 BOARD_RE_REF 필드는 자신의 글번호입니다.
		String sql = "INSERT INTO INFOBOARD " 
					+ "(INF_NUM, M_ID,INF_SUBJECT,INF_CONTENT"
					+ " INF_OPEN, INF_FILE, INF_REF," 
					+ " INF_LEV, INF_SEQ, INF_READCOUNT,INF_LOC,INF_REG)"
					+ " values(" + max_sql + ",?,?,?," 
					+ " 	  	  ?,?," + max_sql + "," 
					+ " 	  	  ?,?,?,?,?)";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			// 새로운 글을 등록하는 부분입니다.
			pstmt.setString(1, board.getM_id());
			pstmt.setString(2, board.getInf_subject());
			pstmt.setString(3, board.getInf_content());
			pstmt.setInt(4, board.getInf_open());
			pstmt.setString(5, board.getInf_file());

			// 원문의 경우 BOARD_RE_LEV, BOARD_RE_SEQ 필드 값은 0입니다.
			pstmt.setInt(6, 0); // LEV
			pstmt.setInt(7, 0); // SEQ
			pstmt.setInt(8, 0); // READCOUNT
			pstmt.setString(9, board.getInf_loc()); // READCOUNT
			pstmt.setString(10, board.getInf_reg()); // READCOUNT

			result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
		} catch (Exception ex) {
			System.out.println("boardInsert() 에러 : " + ex);
			ex.printStackTrace();
		}
		return false;
	}
}
	
