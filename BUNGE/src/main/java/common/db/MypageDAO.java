package common.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MypageDAO {
/*private DataSource ds;
	
//	public MypageDAO() {
//		try {
//			Context init = new InitialContext();
//			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
//		} catch (Exception ex) {
//			System.out.println("DB 연결 실패 : " + ex);
//		}
//	}
	//회원정보 조회
	public MypageDAO mypage_info(String m_id) {
		mypage m = null;
		String info_sql = "select * from member  where m_id=?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(info_sql);) {
			pstmt.setString(1, m_id);
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					m=new mypage();
					m.setM(rs.getString(m_id));
					m.setM_pwd(rs.getString(2));
					m.setM_name(rs.getString(3));
					m.setM_nick(rs.getString(4));
					m.setM_gender(rs.getString(5));
					m.setM_zipcode(rs.getString(6));
					m.setM_addr1(rs.getString(7));
					m.setM_addr2(rs.getString(8));
					m.setM_phone(rs.getString(9));
					m.setM_email(rs.getString(10));
					m.setM_birthdate(rs.getDate(11));
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return m;
	}*/
}
