package infoboardlike.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class InfoLikeDAO {
	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public InfoLikeDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	

	public InfoLike getDetail(int num) {
		InfoLike infolike = null;
		
		String sql = "select * from infolike where inf_NUM = ?";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					infolike = new InfoLike();
					
					infolike.setNo(rs.getInt("NO"));
					infolike.setInf_num(rs.getInt("INF_NUM"));
					infolike.setM_id(rs.getString("M_ID"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return infolike;
  }//getDetail end

	public boolean boardDelete(int num) {
		String select_sql = "select INF_REF,INF_LEV,INF_SEQ "
				  + "from infoboard "
				  + "where INF_NUM=?";

		String board_delete_sql = "delete from infoboard" 
				+ "				where INF_REF=?" 
				+ "				and INF_LEV>=?"
				+ "				and INF_SEQ>=? " 
				+ "				and INF_SEQ<=("
				+ "								   nvl((select min(inf_seq)-1 "
				+ "										from infoboard "
				+ "										where INF_REF=? " 
				+ "										and INF_LEV=? " 
				+ "										and INF_SEQ>?),"
				+ " 					 				(select max(inf_seq)" 
				+ "			  		  					from infoboard"
				+ "			  		  					where inf_ref=?)"
				+ " ))";

		boolean result_check = false;
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(select_sql);) {
			 	
			 pstmt.setInt(1,num);
			 try (ResultSet rs = pstmt.executeQuery();) {
				 if (rs.next()) {
					 try (PreparedStatement pstmt2 = con.prepareStatement(board_delete_sql);){ 
							pstmt2.setInt(1, rs.getInt("INF_REF"));
							pstmt2.setInt(2, rs.getInt("INF_LEV"));
							pstmt2.setInt(3, rs.getInt("INF_SEQ"));
							pstmt2.setInt(4, rs.getInt("INF_REF"));
							pstmt2.setInt(5, rs.getInt("INF_LEV"));
							pstmt2.setInt(6, rs.getInt("INF_SEQ"));
							pstmt2.setInt(7, rs.getInt("INF_REF"));
							int count = pstmt2.executeUpdate();
							if (count >= 1) 
								result_check = true; //삭제가 안된 경우에는 false 반환.
							}
				 }
			 }catch (SQLException e) {
				 e.printStackTrace();
			 }
		}catch (Exception ex) {
			 System.out.println("boardDelete()에러 : " + ex);
			 ex.printStackTrace();
		}
		return result_check;	 
		}



	public void setNoUpdate(String m_id) {
		
		String sql = "update  infolike"
				   + " set	 no = no+1"
				   + " where m_Id = ?";
		 try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			 pstmt.setString(1, m_id);
			 pstmt.executeUpdate();
		 } catch (SQLException ex) {
			 System.out.println("setNoUpdate() 에러 : " + ex);
		 }
	}//setReadCountUpdate()메서드 end
}//class end