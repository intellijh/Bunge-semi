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
	public Mypage mypage_info(String m_id) {
		Mypage m = null;
		String info_sql = "select * from member where m_id = ?";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(info_sql);) {
			
			pstmt.setString(1, m_id);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
				m = new Mypage();
				m.getMember().setM_id(rs.getString("m_id"));
				m.getMember().setM_pwd(rs.getString("m_pwd"));
				m.getMember().setM_name(rs.getString("m_name"));
				m.getMember().setM_nick(rs.getString("m_nick"));
				m.getMember().setM_gender(rs.getString("m_gender"));
				m.getMember().setM_zipcode(rs.getString("m_zipcode"));
				m.getMember().setM_addr1(rs.getString("m_addr1"));
				m.getMember().setM_addr2(rs.getString("m_addr2"));
				m.getMember().setM_phone(rs.getString("m_phone"));
				m.getMember().setM_email(rs.getString("m_email"));
				m.getMember().setM_profile(rs.getString("m_profile"));
	
			}
		}catch (SQLException e) {
			e.printStackTrace();
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return m;
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
	    		+ "	 b.inf_book, "
	    		+ "	 b.inf_cover, "
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
	    		+ "group by  b.inf_num, b.inf_subject, b.inf_content, b.inf_book, b.inf_cover";

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
	                board.getBoard().setInf_book(rs.getString("inf_book"));
	                board.getBoard().setInf_cover(rs.getString("inf_cover"));
	                
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
	public List<Mylike> getlikeList(String m_id) {
		List<Mylike> likelist = new ArrayList<>();
		String like_sql= "select b.inf_num , b.inf_subject, b.inf_content , b.inf_reg, b.inf_book, b.inf_cover, "
				+ "    COUNT(DISTINCT c.inf_num) AS comment_count, "
				+ "    COUNT(DISTINCT k.inf_num) AS like_count "
				+ "from "
				+ "    infoboard b "
				+ "LEFT JOIN "
				+ "    infocomm c ON b.inf_num = c.inf_num "
				+ "LEFT JOIN "
				+ "    infolike k ON b.inf_num = k.inf_num "
				+ "where b.m_id=? and b.inf_lev=0 "
				+ "group by b.inf_num, b.inf_subject, b.inf_content, b.inf_reg, b.inf_book, b.inf_cover ";
			
		try(Connection con =ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(like_sql);) {
			
			pstmt.setString(1, m_id);
			
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					Mylike like = new Mylike();
					like.getBoard().setInf_num(rs.getInt("inf_num"));
					like.getBoard().setInf_subject(rs.getString("inf_subject"));
					like.getBoard().setInf_content(rs.getString("inf_content"));
					like.getBoard().setInf_reg(rs.getString("inf_reg"));
					like.getComment().setInf_num(rs.getInt("comment_count"));
					like.getInfoLike().setInf_num(rs.getInt("like_count"));
					like.getBoard().setInf_book(rs.getString("inf_book"));
					like.getBoard().setInf_cover(rs.getString("inf_cover"));
					
					likelist.add(like);
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		return likelist;
	}
	//중고거래 좋아요(찜)한 내역 조회
	public List<Mytrade> gettradeList(String m_id) {
		List<Mytrade> tradelist = new ArrayList<>();
		String trade_sql = "select t.tradeid, t.title, t.description, t.price, t.category, t.imageid,t.readcount , k.tradeid "
				+ "from trade t "
				+ "join likey k on t.tradeid = k.tradeid "
				+ "where sellerid=? ";
	
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(trade_sql);) {
			
			pstmt.setString(1, m_id);
			
			try(ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					Mytrade mytrade = new Mytrade();
					mytrade.getTrade().setTradeID(rs.getInt("tradeid"));
					mytrade.getTrade().setTitle(rs.getString("title"));
					mytrade.getTrade().setDescription(rs.getString("description"));
					mytrade.getTrade().setPrice(rs.getInt("price"));
					mytrade.getTrade().setCategory(rs.getString("category"));
					mytrade.getTrade().setImageID(rs.getString("imageid"));
					mytrade.getTrade().setReadCount(rs.getInt("readcount"));
					mytrade.getLikey().setTradeid(rs.getInt("tradeid"));
					tradelist.add(mytrade);
				}
				}catch (SQLException e) {
					e.printStackTrace();
				}
			
			}catch (Exception ex) {
				ex.printStackTrace();
			}
		return tradelist;
	}
	//회원 정보 수정
	public boolean mypagechange(Mypage m) {
		boolean result = false;
		String change_sql = "update member "
						+ "set m_pwd=? , m_nick=?, m_zipcode=?, m_addr1=?, m_addr2=?, "
						+ "m_phone=?, m_email=?, m_profile=? "
						+ "where m_id=? ";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(change_sql);) {
			
			pstmt.setString(1, m.getMember().getM_pwd());
			pstmt.setString(2, m.getMember().getM_nick());
			pstmt.setString(3, m.getMember().getM_zipcode());
			pstmt.setString(4, m.getMember().getM_addr1());
			pstmt.setString(5, m.getMember().getM_addr2());
			pstmt.setString(6, m.getMember().getM_phone());
			pstmt.setString(7, m.getMember().getM_email());
			pstmt.setString(8, m.getMember().getM_profile());
			pstmt.setString(9, m.getMember().getM_id());
			int change=pstmt.executeUpdate();
			
			if(change > 0) {
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
