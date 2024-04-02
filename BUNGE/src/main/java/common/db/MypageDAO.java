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
	//내가 쓴 게시글 조회
	public List<myboard> getBoardList(String m_id, int page, int limit) {
	    List<myboard> boardlist = new ArrayList<>();
	    
	    String board_list_sql = "select *  from (select rownum rnum, j.*, b.m_id, b.inf_lev "
	    		+ " from ( select b.inf_num, b.inf_subject, b.inf_content, "
	    		+ " count(distinct c.inf_num) as comment_count, "
	    		+ " count(distinct k.inf_num) as like_count "
	    		+ " from "
	    		+ "    infoboard b "
	    		+ " left join "
	    		+ "    infocomm c on b.inf_num = c.inf_num "
	    		+ " left join "
	    		+ "    infolike k on b.inf_num = k.inf_num "
	    		+ " where b.m_id = ? and b.inf_lev = 0 "
	    		+ " group by b.inf_num, b.inf_subject, b.inf_content ) j "
	    		+ "							     where rownum <= ? ) "
	    		+ "				where rnum >= ? and rnum <= ?";

	    int startrow = (page - 1) * limit + 1;
	    int endrow = startrow + limit - 1;

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(board_list_sql)) {

	        pstmt.setString(1, m_id);
	        pstmt.setInt(2, startrow);
	        pstmt.setInt(3, endrow);
	        pstmt.setInt(4, startrow); 
	        pstmt.setInt(5, endrow); 
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                myboard board = new myboard();
	                board.getBoard().setM_id(rs.getString("m_id"));
	                board.getBoard().setInf_num(rs.getInt("inf_num")); 
	                board.getBoard().setInf_subject(rs.getString("inf_subject"));
	                board.getBoard().setInf_content(rs.getString("inf_content"));
	                board.getComment().setInf_num(rs.getInt("comment_count")); 
	                board.getInfoLike().setInf_num(rs.getInt("like_count"));
	                board.getBoard().setInf_lev(rs.getInt("inf_lev")); 
	                
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
