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
				   + " values(com_seq.nextval,?,?,sysdate,?,?,?,com_seq.nextval)";
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
		//새 글을 등록하는 부분입니다.
	    pstmt.setString(1, c.getM_id());
	    pstmt.setString(2, c.getComm_content());
	    pstmt.setInt(3, c.getInf_num());
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
	
	public int getListCount(int inf_num) {
		int x = 0;
		
		String sql = "select count(*) from infocomm"
				   + " where inf_num = ?";

		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, inf_num);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1); // DB에 해당 id 있음
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return x;
	}

	public JsonArray getCommentList(int inf_num, int state) {
		String sort = "asc";
		if(state == 2) {
			sort = "desc";
		}
		String sql = "select comm_num, infocomm.m_id, comm_content, comm_reg, comm_lev, "
				   + "		 comm_seq, "
				   + " 		 comm_ref, memberimg.memberfile "
				   + " from  infocomm join member " 
				   + " on 	 infocomm.id = member.m_id "
				   + " where inf_num = ? "
				   + " order by comm_ref " + sort + ","
				   +" 		 comm_seq asc";
		  
		JsonArray array = new JsonArray();
		  
		  try (Connection con = ds.getConnection(); 
					PreparedStatement pstmt = con.prepareStatement(sql);) {
			  
			  pstmt.setInt(1, inf_num);
				
			  try (ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						JsonObject object = new JsonObject();
						object.addProperty("num", rs.getInt(1));
						object.addProperty("id", rs.getString(2));
						object.addProperty("content", rs.getString(3));
						object.addProperty("reg_date", rs.getString(4));
						object.addProperty("comment_re_lev", rs.getInt(5));
						object.addProperty("comment_re_seq", rs.getInt(6));
						object.addProperty("comment_re_ref", rs.getInt(7));
						object.addProperty("memberfile", rs.getString(8));
						
						array.add(object);
					}
				}
		  }catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCount() 에러 : " + ex);
			}
			return array;
		}

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
		}

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
}

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
	}

	public int reply_insert(Connection con, Comment c) throws SQLException{
		int result = 0;
		String insert_sql = "insert into infocomm "
				   		+  "values(com_seq.nextval,?,?,sysdate,?,?,?,?)";
		try (PreparedStatement pstmt = con.prepareStatement(insert_sql);) {
			pstmt.setString(1, c.getM_id());
			pstmt.setString(2, c.getComm_content());
			pstmt.setInt(3, c.getInf_num());
			pstmt.setInt(4, c.getComm_lev()+1);
			pstmt.setInt(5, c.getComm_seq()+1);
			pstmt.setInt(6, c.getComm_ref());
			result = pstmt.executeUpdate();
	}
		return result;
	}

	public int commentDelete(int num) {
		int result = 0;
		
		String delete_sql = "delete infocomm where num = ?";
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
	}
}
	
//http://localhost:8088/Board_Ajax/CommentList.bo?comment_board_num=7&state=1