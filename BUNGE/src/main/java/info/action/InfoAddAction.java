package info.action;

import java.io.IOException;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import info.db.Boardfile;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Board board = new Board();
		Boardfile boardfile = new Boardfile();
		BoardDAO dao = new BoardDAO();
		ActionForward forward = new ActionForward();
		boolean result = false;
		int success = 0;
		
		String realFolder ="";
		
		//webapp아래에 꼭 폴더 생성하세요
		String saveFolder = "boardupload";
		
		int fileSize = 5*1024*1024; //업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		
		try { 
			MultipartRequest multi = new MultipartRequest(
					request, 
					realFolder,
					fileSize,
					"utf-8",
					new DefaultFileRenamePolicy());
			board.setM_id(multi.getParameter("m_id"));
			board.setInf_subject(multi.getParameter("inf_subject"));
			board.setInf_content(multi.getParameter("inf_content"));
			board.setInf_open(Integer.parseInt(multi.getParameter("inf_open")));
			board.setInf_loc(multi.getParameter("inf_loc"));
			System.out.println("inf_loc :" + multi.getParameter("inf_loc"));
			board.setInf_reg(multi.getParameter("inf_reg"));
			board.setInf_book(multi.getParameter("inf_book"));
			board.setInf_cover(multi.getParameter("inf_cover"));
			board.setInf_author(multi.getParameter("inf_author"));
			board.setInf_category(multi.getParameter("inf_category"));
			board.setInf_pubdate(multi.getParameter("inf_pubdate"));

			success = dao.boardInsert(board);
			
			result = dao.boardinsertFile(success, multi, boardfile);
			
			if (result == false) {
				forward.setRedirect(false);
				forward.setPath("error/error.jsp");
			}
			
		} catch (IOException ex) {
			ex.printStackTrace();
			forward.setRedirect(false);
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("첨부파일 게시판 완전 등록 완료");
		forward.setRedirect(true);
		forward.setPath("InfoList.com");
		return forward;
	}
}