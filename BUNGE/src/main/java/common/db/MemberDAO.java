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
	//idcheck()
	public int idcheck(String m_id) {
		int result = -1; //db 아이디정보가 없을때 -1을 리턴한다.
		String idck_sql = "select m_id from MEMBER where m_id = ? ";
		
		//try-with-resource문
		try (Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(idck_sql);) {
			pstmt.setString(1, m_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					result=0; //DB에 해당 id가 있다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
				ex.printStackTrace();
		}
	return result;
	}//idcheck() end
	
	//nickcheck()
	public int nickcheck(String m_nick) {
		int result = -1; //db 닉네임정보가 없을때 -1을 리턴한다.
		String nickck_sql = "select m_nick from MEMBER where m_nick = ? ";
		
		//try-with-resource문
		try (Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(nickck_sql);) {
			pstmt.setString(1, m_nick);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					result=0; //DB에 해당 nick가 있다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
				ex.printStackTrace();
		}
	return result;
	}//nickcheck() end
	
	//emailcheck()
	public int emailcheck(String m_email) {
		int result = -1;
		String email_sql = "select m_email from member where m_email = ?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(email_sql);) {
			pstmt.setString(1, m_email);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					result=0; //DB에 해당 email이 있다.
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
	//loginid()
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
	
	//join()
	public int joininsert(Member m) {
		int result = 0;
		String join_sql =  "insert into member "
									+ "(m_id, m_pwd, m_name, m_nick, m_gender, m_zipcode, m_addr1, m_addr2, m_phone, m_email, m_birthdate, m_profile) "
									+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default)";
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
	}//join end
	
	public int imginsert(Member m,Memberimg mimg) {
		int result = 0;
		String join_sql = "insert into memberimg "
						+ "(pof_num,m_id) "
						+ "values (mimg_seq.nextval,?)";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(join_sql);) {
			pstmt.setString(1, m.getM_id());
			result= pstmt.executeUpdate();  //inset 성공시 result는1
				}catch (Exception e) {
					e.printStackTrace();
		}
		return result;
	}//insert end
	

	public String findid(String m_name, String m_email) {
			String m_id =null;
		String findid_sql = "select m_id from member where m_name= ? and m_email= ?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(findid_sql);) {
			
			pstmt.setString(1, m_name);
			pstmt.setString(2, m_email);
			try(ResultSet rs = pstmt.executeQuery()) {
				
				if(rs.next()) {
					m_id = rs.getString("m_id");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
				}catch (Exception ex) {
					ex.printStackTrace();
				}
		
		return m_id ;
	}//findid end
	
	//findpwd()
	public boolean findpwd(String m_id, String m_name, String m_email) {
		Boolean m_pwd = false;
		
		String findpwd_sql = "select decode(count(*), 1 ,'true' , 'false') as result from member "
										+ "where m_id=? and m_name=? and m_email=?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(findpwd_sql);) {
			
			pstmt.setString(1, m_id);
			pstmt.setString(2, m_name);
			pstmt.setString(3, m_email);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {		
							String result = rs.getString("result");// 결과 값을 문자열로 가져옴
							if(result != null) {
								m_pwd = Boolean.valueOf(result); // 문자열을 Boolean으로 변환
							}
					}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
				}catch (Exception ex) {
					ex.printStackTrace();
				}
		return m_pwd;
		}//findpwd() end
	//
	
	public boolean pwdreset(Member m) {
		boolean result=false;
		String pwdupdate = "update member set m_pwd=? where m_id=?";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(pwdupdate);) {
			
				pstmt.setString(1, m.getM_pwd());
				pstmt.setString(2, m.getM_id());
				
				System.out.println("비밀번호 수정 완료");
				
				int row=pstmt.executeUpdate();
				
				if(row > 0) {
					result = true;
				}
		}catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
	
	}

