package info.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;


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
		int num = 0;
				
				String max_sql = "(select nvl(max(inf_num),0)+1 from INFOBOARD)";
		
				// 원문글의 BOARD_RE_REF 필드는 자신의 글번호입니다.
				String sql = "INSERT INTO INFOBOARD " 
							+ "(INF_NUM, M_ID, INF_SUBJECT, INF_CONTENT, INF_REF, "
							+ " INF_LEV, INF_SEQ, INF_READCOUNT, INF_LOC, "
							+ " INF_REG, INF_OPEN, INF_BOOK, INF_COVER) " 
							+ " values(" + max_sql + " , ?, ?, ?, " + max_sql 
							+ " 	   , ?, ?, ?, ? "
							+ "        , sysdate, ?, ?, ?)"; 
				
				
				String select_sql = "select max(inf_num) "
						          + "from infoboard";
				
				try (Connection con = ds.getConnection();
					 PreparedStatement pstmt = con.prepareStatement(sql);) {
						pstmt.setString(1, board.getM_id());
						pstmt.setString(2, board.getInf_subject());
						pstmt.setString(3, board.getInf_content());
			
						// 원문의 경우 BOARD_RE_LEV, BOARD_RE_SEQ 필드 값은 0입니다.
						pstmt.setInt(4, 0); // LEV
						pstmt.setInt(5, 0); // SEQ
						pstmt.setInt(6, 0); // READCOUNT
						pstmt.setString(7, board.getInf_loc()); // LOC
						pstmt.setInt(8, board.getInf_open());//OPEN
						pstmt.setString(9, board.getInf_book()); //BOOK
						pstmt.setString(10, board.getInf_cover()); //COVER URL
			
						pstmt.executeUpdate();
						
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
	
	public boolean boardinsertFile(int success, MultipartRequest multi, Boardfile boardfile) {
		boolean result = false;
		String sql = "INSERT INTO INFOATTACH " 
					+ "(INFA_NUM, INF_NUM, INFA_FILENAME, INFA_SERVERNAME)"
					+ " values(infa_seq.nextval, "+ success +", ?, ?)";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			con.setAutoCommit(false);
			
			for (int i=1; i<=5; i++) {
				String userfile = multi.getOriginalFileName("inf_file"+i);
				String serverfile = multi.getFilesystemName("inf_file"+i);
				if (userfile != null) {
					boardfile.setInfa_filename(userfile);
					boardfile.setInfa_servername(serverfile);
					pstmt.setString(1, boardfile.getInfa_filename());
					pstmt.setString(2, boardfile.getInfa_servername());
					if (pstmt.executeUpdate() == 1) {
						System.out.println("첨부파일 등록 성공");
						result = true;
					} else {
						continue;
					}
				} else {
					break;
				}
			}
			con.commit();
			con.setAutoCommit(true);
			
		} catch (Exception ex) {
			System.out.println("board_attach() 에러 : " + ex);
			ex.printStackTrace();
		}
		return result;
	} //boardinsertFile end


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
		String board_list_sql = "SELECT * "
				+ "FROM"
				+"    (SELECT rownum AS rnum, c.*,NVL(l.cnt, 0) AS like_cnt"
				+"    FROM"
				+"        (SELECT a.*,NVL(b.cnt, 0) AS comment_cnt"
				+"        FROM infoboard a LEFT OUTER JOIN"
				+"            (SELECT inf_num, COUNT(*) AS cnt"
				+"            FROM infocomm"
				+"            GROUP BY inf_num) b"
				+"        ON a.inf_num = b.inf_num"
				+"        ORDER BY inf_ref DESC,"
				+"                      inf_seq ASC) c"
				+"    LEFT OUTER JOIN"
				+"        (SELECT inf_num, COUNT(*) AS cnt"
				+"        FROM infolike"
				+"        GROUP BY inf_num) l"
				+"    ON c.inf_num = l.inf_num"
				+"    WHERE rownum <= ?) "
				+ "WHERE rnum >= ? AND rnum <= ?";

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
					board.setInf_readcount(rs.getInt("INF_READCOUNT"));
					board.setInf_book(rs.getString("INF_BOOK"));
					board.setInf_cover(rs.getString("INF_COVER"));
					board.setCnt(rs.getInt("comment_cnt"));
					board.setInfolikecnt(rs.getInt("like_cnt"));					

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
				//	board.setInf_ref(rs.getInt("INF_REF"));
				//	board.setInf_lev(rs.getInt("INF_LEV"));
				//	board.setInf_seq(rs.getInt("INF_SEQ"));
					board.setInf_readcount(rs.getInt("INF_READCOUNT"));
					board.setInf_loc(rs.getString("INF_LOC"));
					board.setInf_reg(rs.getString("INF_REG"));
					board.setInf_book(rs.getString("INF_BOOK"));
					board.setInf_cover(rs.getString("INF_COVER"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return board;
  }//getDetail end


	public ArrayList<Boardfile> getDetailAttach(int num) {
		ArrayList<Boardfile> list = new ArrayList<Boardfile>();
		Boardfile boardfile = null;
		String sql = "select * "
				   + "from infoattach "
				   + "where inf_num = ? "
				   + "order by infa_num";
		
		try (Connection con = ds.getConnection(); 
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					boardfile = new Boardfile();
					
					boardfile.setInfa_num(rs.getInt("infa_num"));
					boardfile.setInf_num(rs.getInt("inf_num"));
					boardfile.setInfa_filename(rs.getString("infa_filename"));
					boardfile.setInfa_servername(rs.getString("infa_servername"));
					
					list.add(boardfile);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러 : " + ex);
		}
		return list;
	}//getDetailAttach end


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
				 System.out.println("boardDelete()에러 : " + e);
			 }
		}catch (Exception ex) {
			 System.out.println("boardDelete()에러 : " + ex);
			 ex.printStackTrace();
		}
		return result_check;	 
		}


	public int boardReply(Board board) {
		int num = 0;
		 
		 try (Connection con = ds.getConnection();) {
			 //트랜잭션을 이용하기 위해서 setAutoCommit을 false로 설정합니다.
			 con.setAutoCommit(false);
			 
			 try { 
				 reply_update(con, board.getInf_ref(), board.getInf_seq());
				 num = reply_insert(con,board);
				 con.commit();
			 }
			 catch (SQLException e) {
				 e.printStackTrace();
				
				 if(con != null) {
					 try {
						 con.rollback();
					 } catch (SQLException ex) {
						 ex.printStackTrace();
					 }
				 }
			 }
			 con.setAutoCommit(true);
		 } catch (Exception ex) {
			 ex.printStackTrace();
			 System.out.println("boardReply()에러 : " + ex);
		 } 
		 return num;
	}
	
	public void reply_update(Connection con, int re_ref, int re_seq) throws SQLException {
		//BOARD_RE_REF,BOARD_RE_SEQ 값을 확인하여 원문 글에 답글이 달려있다면
		// 달린 답글들의 BOARD_RE_SEQ 값을 1씩 증가합니다.
		// 현재 글을 이미 달린 답글보다 앞에 출력되게 하기 위해서 입니다.
		
		String sql = "update infoboard "
				   + " set INF_SEQ = INF_SEQ + 1 "
				   + " where INF_REF = ?"
				   + " and INF_SEQ > ?";
		
		try (PreparedStatement pstmt = con.prepareStatement(sql);) { 
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();
		}
	}
	
	public int reply_insert(Connection con, Board board) throws SQLException {
		int num = 0;
		String  board_max_sql = "(select max(inf_num)+1 from infoboard)";
		try (PreparedStatement pstmt = con.prepareStatement(board_max_sql);) { 
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					num=rs.getInt(1);
				}
			}
		}
		
		String sql = "insert into infoboard "
				   + " (INF_NUM,M_ID,INF_SUBJECT,INF_CONTENT, "
				   + " INF_OPEN,INF_REF,INF_LEV,"
				   + " INF_SEQ,INF_READCOUNT,INF_LOC,INF_REG)"
				   + " values(?,?,?,?, "
				   + "	?,?,?,"
				   + "	?,?,?,sysdate)";
		
		try (PreparedStatement pstmt = con.prepareStatement(sql);) { 
			pstmt.setInt(1, num);
			pstmt.setString(2, board.getM_id());
			pstmt.setString(3, board.getInf_subject());
			pstmt.setString(4, board.getInf_content());
			pstmt.setInt(5, board.getInf_open()); //답변에는 파일을 업로드하지 않습니다.
			pstmt.setInt(6, board.getInf_ref()); //원문의 글번호
			pstmt.setInt(7, board.getInf_lev()+1);
			pstmt.setInt(8, board.getInf_seq()+1);
			pstmt.setInt(9, 0); //BOARD_READCOUNT(조회수)는 0
			pstmt.setString(10, board.getInf_loc()); 
			pstmt.executeUpdate();
		}
		return num; 
	}


	public boolean boardModify(Board board) {
		String sql = "update infoboard "
				   + "set inf_subject=?, inf_content=?, inf_open=?, inf_loc=?, inf_book=?, inf_cover=? "
				   + "where inf_num=?";
		try (Connection con = ds.getConnection();
		     PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, board.getInf_subject());
				pstmt.setString(2, board.getInf_content());
				pstmt.setInt(3, board.getInf_open());
				pstmt.setString(4, board.getInf_loc());
				pstmt.setString(5, board.getInf_book());
				pstmt.setString(6, board.getInf_cover());
				pstmt.setInt(7, board.getInf_num());
				
				int result = pstmt.executeUpdate();
				if (result == 1) {
					System.out.println("업데이트 성공");
					return true;
				}
		} catch (Exception ex) {
			System.out.println("boardModify() 에러 : " + ex);
		}
		return false;
	} //boardModify() end

/*
	public void boardfileReset(int inf_num) {
		int result = -1;
		String sql = "delete infoattach "
				   + "where inf_num = ?";
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setInt(1, inf_num);
				result = pstmt.executeUpdate();
				
				if (result != -1) {
					System.out.println("첨부파일 초기화 성공");
				}
		} catch (Exception ex) {
			System.out.println("boardfileReset() 에러 : " + ex);
		}
	} //boardfileReset() end
*/

	public boolean boardfileModify(int inf_num, Boardfile boardfile) {
		int result = -1;
		String sql = "insert into infoattach "
				   + "(infa_num, inf_num, infa_filename, infa_servername) "
				   + "values(infa_seq.nextval, ?, ?, ?) ";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, inf_num);
			pstmt.setString(2, boardfile.getInfa_filename());
			pstmt.setString(3, boardfile.getInfa_servername());
			result = pstmt.executeUpdate();
			
			if (result != -1) {
				System.out.println("boardfileModify() 성공 : 파일첨부 성공");
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("boardfileModify() 에러" + e);
		}
		return false;
	} //boardfileModify() end
	
	public boolean boardmodifyDelete(int inf_num, String origname) {
		int result = -1;
		String sql = "delete infoattach "
				   + "where inf_num = ? "
				   + "and infa_filename = ? ";
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, inf_num);
			pstmt.setString(2, origname);
			result = pstmt.executeUpdate();
			
			if (result != -1) {
				System.out.println("원래 있던 첨부파일 삭제 완료");
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("boardmodifyDelete()에러" + e);
		}
		return false;
	} //boardmodifyDelete() end

	
	public ArrayList<JsonObject> getpopularBook() {
		String sql = "select inf_book, inf_cover, count(*) "
				   + "from infoboard "
				   + "where inf_book != 'null' "
				   + "group by inf_book, inf_cover "
				   + "order by count(*) desc";
		
		ArrayList<JsonObject> list = new ArrayList<JsonObject>();
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			 try (ResultSet rs = pstmt.executeQuery();) {
				 while (rs.next()) {
					JsonObject object = new JsonObject();

					 object.addProperty("inf_book", rs.getString("inf_book"));
					 object.addProperty("inf_cover", rs.getString("inf_cover"));
					 object.addProperty("count", rs.getInt("count(*)"));
					 
					 list.add(object);
				 } 
			 } catch (SQLException ex) {
				 ex.printStackTrace();
				 System.out.println("getpopularBook() 에러 : " + ex);
			 }
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getpopularBook() 에러 : " + e);
		}
		return list;
	} //getpopularBook() end

	public ArrayList<JsonObject> getpopularComm() {
		String sql = "select count(*), a.comm_num, b.comm_content, b.m_id, b.comm_reg "
				   + "from infocommlike a, infocomm b "
				   + "where a.comm_num = b.comm_num "
				   + "group by a.comm_num, b.comm_content, b.m_id, b.comm_reg "
				   + "order by count(*) desc, comm_num desc ";
		
		ArrayList<JsonObject> list = new ArrayList<JsonObject>();
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					JsonObject object = new JsonObject();
					
					object.addProperty("count", rs.getInt("count(*)"));
					object.addProperty("content", rs.getString("comm_content"));
					object.addProperty("m_id", rs.getString("m_id"));
					object.addProperty("reg", rs.getString("comm_reg"));;
					
					list.add(object);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("getpopularComm() 에러 : " + e);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getpopularComm() 에러 : " + ex);
		}
		
		return list;
	}


	public ArrayList<JsonObject> getpopularPost() {
		ArrayList<JsonObject> list = new ArrayList<JsonObject>();
		String sql = 
			"	SELECT C.*, COUNT(infolike.inf_num) AS total_likes, M.m_profile "
		+	"	FROM ( "
		+	"	      SELECT a.inf_num, " 
		+	"	             a.m_id, " 
		+	"	             a.inf_subject, " 
		+	"	             a.inf_content, " 
		+	"	             a.inf_readcount, "
		+	"	             a.inf_reg, " 
		+	"	             a.inf_book, " 
		+	"	             a.inf_cover, "
		+	"	             COUNT(b.inf_num) as commcnt " 
		+	"	        FROM infoboard a " 
		+	"	        JOIN infocomm b ON a.inf_num = b.inf_num "
		+	"	        GROUP BY a.inf_num, " 
		+	"	                 a.m_id, "
		+	"	                 a.inf_subject, "
		+	"	                 a.inf_content, "
		+	"	                 a.inf_readcount, " 
		+	"	                 a.inf_reg, " 
		+	"	                 a.inf_book, " 
		+	"	                 a.inf_cover " 
		+	"	      ) C " 
		+	"	LEFT JOIN infolike ON C.inf_num = infolike.inf_num " 
		+	"	LEFT JOIN member M ON C.m_id = M.m_id "
		+	"	GROUP BY C.inf_num, " 
		+	"	         C.m_id, " 
		+	"	         C.inf_subject, " 
		+	"	         C.inf_content, " 
		+	"	         C.inf_readcount, " 
		+	"	         C.inf_reg, " 
		+	"	         C.inf_book, " 
		+	"	         C.inf_cover, " 
		+	"	         C.commcnt, "
		+	"	         M.m_profile "
		+	"	ORDER BY TOTAL_LIKES desc, COMMCNT desc";

		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery();) {
				while (rs.next()) {
					JsonObject object = new JsonObject();

					object.addProperty("inf_num", rs.getString("inf_num"));
					object.addProperty("m_id", rs.getString("m_id"));
					object.addProperty("inf_subject", rs.getString("inf_subject"));
					object.addProperty("inf_content", rs.getString("inf_content"));
					object.addProperty("inf_readcount", rs.getInt("inf_readcount"));
					object.addProperty("inf_reg", rs.getString("inf_reg"));
					object.addProperty("inf_book", rs.getString("inf_book"));
					object.addProperty("inf_cover", rs.getString("inf_cover"));
					object.addProperty("postcommcnt", rs.getInt("commcnt"));
					object.addProperty("postlikecnt", rs.getInt("total_likes"));
					object.addProperty("m_profile", rs.getString("m_profile"));

					list.add(object);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("getpopularPost() 에러 : " + e);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getpopularPost() 에러 : " + ex);
		}

		return list;
	}
	
}//class end