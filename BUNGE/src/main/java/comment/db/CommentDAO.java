package comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CommentDAO {
	
private DataSource ds;
	
	public CommentDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	
	public int commentsInsert(Comment c) {
		int result = 0;
		String sql = "insert into infocomm"
				   + " values(com_seq.nextval,?,?,?,com_seq.nextval,?,?,sysdate)";
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
		//새 글을 등록하는 부분입니다.
	    pstmt.setString(1, c.getM_id());
	    pstmt.setInt(2, c.getInf_num());
	    pstmt.setString(3, c.getComm_content());
	    pstmt.setInt(4, c.getComm_lev());
	    pstmt.setInt(5, c.getComm_seq());
	   
	    result = pstmt.executeUpdate();
	    if(result == 1)
	    	System.out.println("데이터 삽입 완료되었습니다.");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int commentsinsertedNum() {
		int comm_num = -1;
		String sql = "select * "
				   + "from infocomm "
				   + "where comm_num = (select max(comm_num) from infocomm)";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					comm_num = rs.getInt("comm_num");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("comm_num 을 불러오는데 실패" + e);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("comm_num 불러오는 데 실패 + e");
		}
		return comm_num;
	} //commentsinsertedNum end		
	
	public int getListCount(int inf_num) {
		int x = 0;
		
		String sql = "select count(*) from infocomm"
				   + " where inf_num = ?";

		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, inf_num);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return x;
	}//getListCount end	

	public JsonArray getCommentList(int inf_num,int state) {
		String sort = "asc";
		if(state == 2) {
			sort = "desc";
		}

		String sql =" SELECT ic.comm_num, ic.m_id, ic.comm_content, ic.comm_reg,"
				+"    ic.comm_lev, ic.comm_seq, ic.comm_ref, m.m_profile,"
				+"    NVL(clike.like_count, 0) AS like_count"
				+" FROM infocomm ic JOIN member m ON ic.m_id = m.m_id"
				+"	LEFT JOIN (SELECT comm_num, COUNT(*) AS like_count"
				+"    	     	FROM infocommlike"
				+"    	     	GROUP BY comm_num) clike ON ic.comm_num = clike.comm_num"
				+" WHERE inf_num = ?"
				+" ORDER BY comm_ref " + sort + ", comm_seq ASC";


		JsonArray array = new JsonArray();
		  
		  try (Connection con = ds.getConnection(); 
					PreparedStatement pstmt = con.prepareStatement(sql);) {
			  
			  pstmt.setInt(1, inf_num);
				
			  try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						JsonObject object = new JsonObject();
						object.addProperty("comm_num", rs.getInt(1) );
						object.addProperty("m_id", rs.getString(2));
						object.addProperty("comm_content", rs.getString(3));
						object.addProperty("comm_reg", rs.getString(4));
						object.addProperty("comm_lev", rs.getInt(5));
						object.addProperty("comm_seq", rs.getInt(6));
						object.addProperty("comm_ref", rs.getInt(7));
						object.addProperty("m_profile", rs.getString(8));
						object.addProperty("like_count", rs.getString(9));
						
						array.add(object);
					}
				}
		  }catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCount() 에러 : " + ex);
			}
			return array;
		}//getCommentList end	

	public int commentsUpdate(Comment co) {
		int result = 0;
		String sql = "update infocomm set comm_content = ?"
				   + " where comm_num = ? ";
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, co.getComm_content());
			pstmt.setInt(2, co.getComm_num());
			
			result = pstmt.executeUpdate();
			if(result == 1) 
				System.out.println("데이터 수정되었습니다.");
			}catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}//commentsUpdate end

	public int commentsReply(Comment c) {
		int result = 0;
		
		try (Connection con = ds.getConnection();) {
			con.setAutoCommit(false);
			
			try {
				reply_update(con,c.getComm_ref(), c.getComm_seq());
				result = reply_insert(con,c);
				con.commit();
			}
			catch (Exception e) {
				e.printStackTrace();
				 if(con != null) {
					 try {
						 con.rollback();
					 }catch (SQLException ex) {
						 ex.printStackTrace();
					 }
				 }
			}
			con.setAutoCommit(true);
	} catch (Exception e) {
		e.printStackTrace();
	}
		return result;
}//commentsReply end

	public void reply_update(Connection con, int re_ref, int re_seq) throws SQLException{
		String update_sql = "update infocomm "
				   + "set	comm_seq = comm_seq+1 " 
				   + "where	comm_ref = ? "
				   + "and	comm_seq > ?";
		try (PreparedStatement pstmt = con.prepareStatement(update_sql);) {
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();
		}
	}//reply_update end

	public int reply_insert(Connection con, Comment c) throws SQLException{
		int result = 0;
		String insert_sql = "insert into infocomm "
				   		+  "values(com_seq.nextval,?,?,?,?,?,?,sysdate)";
		try (PreparedStatement pstmt = con.prepareStatement(insert_sql);) {
			pstmt.setString(1, c.getM_id());
			pstmt.setInt(2, c.getInf_num());
			pstmt.setString(3, c.getComm_content());
			pstmt.setInt(4, c.getComm_ref());
			pstmt.setInt(5, c.getComm_lev()+1);
			pstmt.setInt(6, c.getComm_seq()+1);
			result = pstmt.executeUpdate();
	}
		return result;
	}//reply_insert end

	public int commentDelete(int num) {
		int result = 0;
		
		String delete_sql = "delete infocomm where comm_num = ?";
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(delete_sql);) {
			
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			if(result == 1)
			System.out.println("데이터 삭제 되었습니다.");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}//commentDelete end
	
	public int CommLikeInsert(String m_id, int comm_num) {
		int result = 0;
		String sql = "insert into infocommlike (no, m_id, comm_num) "
				   + "values((select nvl(max(no),0)+1 from infocommlike), ?, ?) ";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, m_id);
			pstmt.setInt(2, comm_num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("CommLikeInsert() 에러" + e);
		}
		return result;
	} //CommLikeInsert() end
	
	public int CommLikeDelete(int comm_num, String m_id) {
		int num = 0;
		
		String sql = "delete infocommlike "
				   + "where comm_num=? "
				   + "and m_id=? ";
		 try (Connection con = ds.getConnection();
			  PreparedStatement pstmt = con.prepareStatement(sql);) {
			 pstmt.setInt(1, comm_num);
			 pstmt.setString(2, m_id);
			 num = pstmt.executeUpdate();
		 } catch (SQLException ex) {
			 System.out.println("setNoUpdate() 에러 : " + ex);
		 }
		 return num; 
	}//CommLikeDelete()메서드 end

	public int InfocommLikeCheck(int comm_num,String m_id) {
		int result = 0;
		String sql = "select count(*) from infocommlike "
				   + "where comm_num = ? and m_id = ? ";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, comm_num);
			pstmt.setString(2, m_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
				result = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return result;
  }//InfocommLikeCheck end		
	
	public int InfocommLikeCnt(int comm_num) {
		int result = -1;
		String sql = "select count(*) from infocommlike where comm_num = ? ";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1,  comm_num);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
				result = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return result;
  }//getDetail end
}
//http://localhost:8088/Board_Ajax/CommentList.bo?comment_board_num=7&state=1