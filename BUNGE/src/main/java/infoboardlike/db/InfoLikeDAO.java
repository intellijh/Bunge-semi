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