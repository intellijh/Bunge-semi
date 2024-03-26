package common.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private DataSource ds;
	
	public MemberDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	public int loginid(String m_id) {
		int result = -1; //DB에 해당 id가 없다.
		String login_sql = "select m_id from MEMBER where m_id = ? ";
		
		//try-with-resource문
		try (Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(login_sql);) {
			pstmt.setString(1, m_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					result=0; //DB에 해당 id가 있다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
	return result;
	}//loginid() end
	
	public int loginid(String m_id, String m_pwd) {
		int result = -1; //db에 해당 아이디가 없을때
		String login_sql = "select m_id, m_pwd from MEMBER where m_id = ?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(login_sql);) {
			
			pstmt.setString(1, m_id);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					if(rs.getString(2).equals(m_pwd)) {
						result = 1; //일치
					}else {
						result = 0; //불일치
					}
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}	
		return result;
	}

}
