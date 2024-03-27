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

public class BoardDAO {
	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public BoardDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	
	
	public int boardInsert(Board board) {
		boolean resultcheck = false;
		int num = 0;
				
				String max_sql = "(select nvl(max(inf_num),0)+1 from INFOBOARD)";
		
				// 원문글의 BOARD_RE_REF 필드는 자신의 글번호입니다.
				String sql = "INSERT INTO INFOBOARD " 
							+ "(INF_NUM,M_ID,INF_SUBJECT,INF_CONTENT, "
							+ " INF_OPEN, INF_REF," 
							+ " INF_LEV, INF_SEQ, INF_READCOUNT,INF_LOC,INF_REG)"
							+ " values(" + max_sql + ",?,?,?," 
							+ " 	  	  ?," + max_sql + "," 
							+ " 	  	  ?,?,?,?,sysdate)";
				
				
				String select_sql = "select max(inf_num) "
						          + "from infoboard";
				
				try (Connection con = ds.getConnection();
					 PreparedStatement pstmt = con.prepareStatement(sql);) {
						pstmt.setString(1, board.getM_id());
						pstmt.setString(2, board.getInf_subject());
						pstmt.setString(3, board.getInf_content());
						pstmt.setInt(4, board.getInf_open());
			
						// 원문의 경우 BOARD_RE_LEV, BOARD_RE_SEQ 필드 값은 0입니다.
						pstmt.setInt(5, 0); // LEV
						pstmt.setInt(6, 0); // SEQ
						pstmt.setInt(7, 0); // READCOUNT
						pstmt.setString(8, board.getInf_loc()); // READCOUNT
			
						int count = pstmt.executeUpdate();
						if (count == 1)
							resultcheck = true;
					 try (PreparedStatement pstmt2 = con.prepareStatement(select_sql);
						  ResultSet rs = pstmt2.executeQuery();) {
						 if (rs.next()) {
							 num = rs.getInt(1);
						 }
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				} catch (Exception ex) {
					System.out.println("boardInsert() 에러 : " + ex);
					ex.printStackTrace();
				}
				
				return num;
	} //boardInsert() end
	
	public boolean boardinsertFile(int success, Boardfile boardfile) {
		
		String sql = "INSERT INTO INFOATTACH " 
					+ "(INFA_NUM,INF_NUM,INFA_FILENAME,INFA_REGDATE)"
					+ " values(" + success + ","+ success +", ? , sysdate)";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) { 
		
			pstmt.setString(1, boardfile.getInfa_filename());
			
			if (pstmt.executeUpdate() == 1) {
				System.out.println("첨부파일 등록 성공적");
				return true;
			}
		} catch (Exception ex) {
			System.out.println("board_attach() 에러 : " + ex);
			ex.printStackTrace();
		}
		
		return false;
	}


	public int getListCount() {
		String sql = "select count(*) from  infoboard";
		int x = 0;

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1); // DB에 해당 id 있음
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("getListCount() 에러 : " + e);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return x;
	}


	public List<Board> getBoardList(int page, int limit) {
		String board_list_sql = "select * " 
				+ " from	(select rownum rnum, c.* "
				+ " 		 from (select a.*, nvl(cnt,0) cnt "
				+ "			  	   from infoboard a left outer join (select inf_num,count(*) cnt"
				+ "										   	   from infocomm"
				+ "				   							   group by inf_num) b"
				+ " 		       on a.inf_num=b.inf_num" 
				+ "			 	   order by inf_ref desc,"
				+ "			  	   inf_seq asc) c " 
				+ " 		 where rownum <= ? " + ") "
				+ " where rnum >= ? and rnum<=?";

		List<Board> list = new ArrayList<Board>();
		// 한 페이지 당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, ...
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호(10 20 30 40 ...)

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(board_list_sql);) {
			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Board board = new Board();
					board.setInf_num(rs.getInt("INF_NUM"));
					board.setM_id(rs.getString("M_ID"));
					board.setInf_subject(rs.getString("INF_SUBJECT"));
					board.setInf_content(rs.getString("INF_CONTENT"));
					board.setInf_open(rs.getInt("INF_OPEN"));
					board.setInf_ref(rs.getInt("INF_REF"));
					board.setInf_lev(rs.getInt("INF_LEV"));
					board.setInf_seq(rs.getInt("INF_SEQ"));
					board.setInf_loc(rs.getString("INF_LOC"));
					board.setInf_reg(rs.getString("INF_REG"));
					board.setCnt(rs.getInt("cnt"));

					list.add(board);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return list;
	}


	public void setReadCountUpdate(int num) {
		String sql = "update  infoboard"
				   + " set	 inf_READCOUNT = inf_READCOUNT+1"
				   + " where inf_NUM=?";
		 try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			 pstmt.setInt(1, num);
			 pstmt.executeUpdate();
		 } catch (SQLException ex) {
			 System.out.println("setReadCountUpdate() 에러 : " + ex);
		 }
	}//setReadCountUpdate()메서드 end


	public Board getDetail(int num) {
		Board board = null;
		
		String sql = "select * from infoboard where inf_NUM = ?";
				    
		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					board = new Board();
					
					board.setInf_num(rs.getInt("INF_NUM"));
					board.setM_id(rs.getString("M_ID"));
					board.setInf_subject(rs.getString("INF_SUBJECT"));
					board.setInf_content(rs.getString("INF_CONTENT"));
					board.setInf_open(rs.getInt("INF_OPEN"));
					board.setInf_ref(rs.getInt("INF_REF"));
					board.setInf_lev(rs.getInt("INF_LEV"));
					board.setInf_seq(rs.getInt("INF_SEQ"));
					board.setInf_readcount(rs.getInt("INF_READCOUNT"));
					board.setInf_loc(rs.getString("INF_LOC"));
					board.setInf_reg(rs.getString("INF_REG"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return board;
  }
}//class end