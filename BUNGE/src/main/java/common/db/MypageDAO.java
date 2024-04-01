package common.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MypageDAO {
private DataSource ds;
	
	public MypageDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	//회원정보 조회
	public MypageDAO mypage_info(String m_id) {
		mypage m = null;
		String info_sql = "select * from member  where m_id=?";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(info_sql);) {
			pstmt.setString(1, m_id);
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
				
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}

		return null;
	}
	public int getList() {
		String List_sql="select count(*) from infoboard";
		int x=0;
		try(Connection con =ds.getConnection();
				PreparedStatement pstmt= con.prepareStatement(List_sql);) {
			
				try(ResultSet rs = pstmt.executeQuery()) {
					if(rs.next()) {
						x = rs.getInt(1);
					}
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}catch (Exception ex) {
				ex.printStackTrace();
			}
			return x;
	}
	public List<mypage> getBoardList(String m_id, int page, int limit) {
		List<mypage> boardlist = new ArrayList<>();
		
		String board_list_sql = "SELECT b.inf_num, b.inf_subject, b.inf_content, b.inf_reg, b.inf_readcount, count(*) as k.inf_num "
				+ "FROM (SELECT ROWNUM AS rnum, b.* "
				+ "      FROM (SELECT * "
				+ "            FROM member m "
				+ "            JOIN infoboard b ON m.m_id = b.m_id "
				+ "            JOIN infolike k ON b.m_id = k.m_id "
				+ "            WHERE m.m_id = ? "
				+ "            ORDER BY b.inf_reg DESC) b "
				+ "      WHERE ROWNUM <= ?) "
				+ "WHERE rnum >= ?";
 
	    int startrow = (page - 1) * limit + 1;
	    int endrow = startrow + limit - 1;
	    
	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(board_list_sql)) {
	        
	        pstmt.setString(1, m_id);
	        pstmt.setInt(2, endrow);
	        pstmt.setInt(3, startrow);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                mypage board = new mypage();
	                board.getBo().setInf_num(rs.getInt("inf_num"));
	                board.getBo().setInf_subject(rs.getString("inf_subject"));
	                board.getBo().setInf_content(rs.getString("inf_content"));
	                board.getBo().setInf_reg(rs.getString("inf_reg"));
	                board.getBo().setInf_readcount(rs.getInt("inf_readcount"));
	                board.getLike().setInf_num(rs.getInt("inf_num"));
	                boardlist.add(board);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    }
	    return boardlist;
	}

}
