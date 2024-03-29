package info.action;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		Board board = boarddao.getDetail(num);
		
		if (board == null) {
			System.out.println("(수정)상세보기 실패");
			request.setAttribute("message", "게시판 수정 상세보기 실패");
			forward.setPath("error/error.jsp");
		} else {
			System.out.println("(수정)상세보기 성공");
			request.setAttribute("board", board);
			forward.setPath("Infoboard/InfoboardModify.jsp");
		}
		
		forward.setRedirect(false);
		return forward;
	}

}
