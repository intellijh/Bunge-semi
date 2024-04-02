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

import info.db.Board;

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

	public int InfoLikeDelete(int inf_num, String m_id) {
		int num = 0;
		
		String sql = "delete infolike "
				   + " where inf_num=? and m_id=? ";
		 try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			 pstmt.setInt(1, inf_num);
			 pstmt.setString(2, m_id);
			 num = pstmt.executeUpdate();
		 } catch (SQLException ex) {
			 System.out.println("setNoUpdate() 에러 : " + ex);
		 }
		 return num; 
	}//setReadCountUpdate()메서드 end
	
	public int InfoLikeInsert(int inf_num, String m_id) {
		int num = 0;
		String sql = "INSERT INTO INFOLIKE " 
				   + " values(infolike_seq.nextval,?,?)"; 
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setInt(1, inf_num);
				pstmt.setString(2, m_id);
	
				num = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}catch (Exception ex) {
			System.out.println("InfolikeInsert() 에러 : " + ex);
			ex.printStackTrace();
		}
		return num;
	} //boardInsert() end

	public int Infolikecnt(int inf_num) {
		int result = -1;
		String sql = "select count(*) from infolike where inf_NUM = ? ";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1,  inf_num);
			
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
	
	public int Infolikecheck(int inf_num,String m_id) {
		int result = 0;
		String sql = "select count(*) from infolike where inf_num = ? and m_id = ? ";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, inf_num);
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
  }//getDetail end
	
}//class end