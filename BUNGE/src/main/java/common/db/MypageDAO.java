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

import infomark.db.InfoMark;

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
		Mypage m = null;
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
	
	//리스트 조회
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
	public List<Myboard> getBoardList(String m_id) {
	    List<Myboard> boardlist = new ArrayList<>();
	    
	    String board_list_sql = "SELECT"
	    		+"     b.inf_num, "	
	    		+ "    b.inf_subject, "
	    		+ "    b.inf_content, "
	    		+ "    COUNT(DISTINCT c.inf_num) AS comment_count, "
	    		+ "    COUNT(DISTINCT k.inf_num) AS like_count "
	    		+ "FROM "
	    		+ "    infoboard b "
	    		+ "LEFT JOIN "
	    		+ "    infocomm c ON b.inf_num = c.inf_num "
	    		+ "LEFT JOIN "
	    		+ "    infolike k ON b.inf_num = k.inf_num "
	    		+ "WHERE "
	    		+ "    b.m_id = ? AND b.inf_lev = 0 "
	    		+ "group by  b.inf_num, b.inf_subject, b.inf_content";

	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(board_list_sql)) {

	        pstmt.setString(1, m_id);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Myboard board = new Myboard(); 
	                board.getBoard().setInf_num(rs.getInt("inf_num"));
	                board.getBoard().setInf_subject(rs.getString("inf_subject"));
	                board.getBoard().setInf_content(rs.getString("inf_content"));
	                board.getComment().setInf_num(rs.getInt("comment_count")); 
	                board.getInfoLike().setInf_num(rs.getInt("like_count"));
	                
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
	//내가 쓴 댓글 조회
	public List<Mycomm> getCommList(String m_id) {
		List<Mycomm> commlist = new ArrayList<>();
		
		String comm_sql = "select b.m_id,c.m_id, b.inf_subject, b.inf_content, c.comm_content "
				+ " from infoboard b "
				+ " join infocomm c on b.inf_num = c.inf_num "
				+ " where b.m_id = ? ";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(comm_sql);) {
			
			pstmt.setString(1, m_id);
			
			try(ResultSet rs=pstmt.executeQuery()){
				 while (rs.next()) {
					Mycomm comm = new Mycomm();
					comm.getBoard().setM_id(rs.getString("m_id"));
					comm.getComment().setM_id(rs.getString("m_id"));
					 comm.getBoard().setInf_subject(rs.getString("inf_subject"));
					 comm.getBoard().setInf_content(rs.getString("inf_content"));
					 comm.getComment().setComm_content(rs.getString("comm_content"));
					 
					 commlist.add(comm);
				 }
			}catch (SQLException e) {
			e.printStackTrace();
		}
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return commlist;
	}
	//내가 좋아요한 게시글 조회
	public List<Mymark> getMarkList(String m_id) {
		List<InfoMark> marklist = new ArrayList<>();
		String mark_sql= "select b.inf_num , b.inf_subject, b.inf_content , b.inf_reg, "
				+ "    COUNT(DISTINCT c.inf_num) AS comment_count, "
				+ "    COUNT(DISTINCT k.inf_num) AS like_count "
				+ "from "
				+ "    infoboard b "
				+ "LEFT JOIN "
				+ "    infocomm c ON b.inf_num = c.inf_num "
				+ "LEFT JOIN "
				+ "    infolike k ON b.inf_num = k.inf_num "
				+ "where b.m_id=? and b.inf_lev=0 "
				+ "group by b.inf_num, b.inf_subject, b.inf_content, b.inf_reg; ";
		return null;
	}


}
