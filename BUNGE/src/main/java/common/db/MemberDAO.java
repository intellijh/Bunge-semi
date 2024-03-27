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
	public int idcheck(String m_id) {
		int result = 0; 
		String idck_sql = "select m_id from MEMBER where m_id = ? ";
		
		//try-with-resource문
		try (Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(idck_sql);) {
			pstmt.setString(1, m_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					result=1; //DB에 해당 id가 있다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
				e.printStackTrace();
		}
	return result;
	}//idcheck() end
	
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
	}//loginid() end
	
	public int joininsert(Member m) {
		int result = 0;
		String join_sql =  "insert into member "
									+ "(m_id, m_pwd, m_name, m_nick, m_gender, m_zipcode, m_addr1, m_addr2, m_phone, m_email, m_birthdate) "
									+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(join_sql);) {
			pstmt.setString(1, m.getM_id());
			pstmt.setString(2, m.getM_pwd());
			pstmt.setString(3, m.getM_name());
			pstmt.setString(4, m.getM_nick());
			pstmt.setString(5, m.getM_gender());
			pstmt.setString(6, m.getM_zipcode());
			pstmt.setString(7, m.getM_addr1());
			pstmt.setString(8, m.getM_addr2());
			pstmt.setString(9, m.getM_phone());
			pstmt.setString(10, m.getM_email());
			pstmt.setDate(11, m.getM_birthdate());
			result= pstmt.executeUpdate();  //inset 성공시 result는1
				}catch (Exception e) {
					e.printStackTrace();
		}
		return result;
	}//insert end

}
