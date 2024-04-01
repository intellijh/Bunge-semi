package common.db;

import java.sql.Connection;
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
	    
	    String board_list_sql = "SELECT * "
	    		+ "	FROM (SELECT b.inf_subject, b.inf_content, "
	    		+ "        COUNT(DISTINCT k.inf_num) AS like_count, "
	    		+ "        COUNT(DISTINCT c.inf_num) AS comment_count, "
	    		+ "        ROW_NUMBER() OVER (ORDER BY b.inf_num DESC) AS row_num "
	    		+ "        FROM member m "
	    		+ "    JOIN infoboard b ON m.m_id = b.m_id "
	    		+ "    LEFT JOIN infoLike k ON m.m_id = k.m_id "
	    		+ "    LEFT JOIN infocomm c ON m.m_id = c.m_id "
	    		+ "    WHERE m.m_id = ?"
	    		+ " 	 GROUP BY  "
	    		+ "    b.inf_subject, b.inf_content) AS sub "
	    		+ " 	 WHERE "
	    		+ "    row_num > (? - 1) * ? AND row_num <= ? * ?";

	    int startrow = (page - 1) * limit + 1;
	    int endrow = startrow + limit - 1;

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(board_list_sql)) {

	        pstmt.setString(1, m_id);
	        pstmt.setInt(2, startrow);
	        pstmt.setInt(3, endrow);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                mypage board = new mypage();
	                board.getBoard().setInf_subject(rs.getString("inf_subject"));
	                board.getBoard().setInf_content(rs.getString("inf_content"));
	                board.getInfoLike().setInf_num(rs.getInt("like_count"));
	                board.getComment().setInf_num(rs.getInt("comment_count"));
	               
	                boardlist.add(board);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	        System.out.println("getListCount() 에러" + ex);
	    }
	    return boardlist;
	}


}
