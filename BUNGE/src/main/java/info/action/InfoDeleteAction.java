package info.action;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("inf_num"));
		
		BoardDAO boarddao = new BoardDAO();
		
		//모달창만 띄우고 바로 삭제
		boolean result = boarddao.boardDelete(num);
		
		//삭제 처리 실패한 경우
		if(!result) {
			System.out.println("게시판 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}else {
			//삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분입니다.
			System.out.println("게시판 삭제 성공");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 되었습니다.');");
			out.println("location.href='InfoList.com';");
			out.println("</script>");
			out.close();
			
			return null;
		}
	}

}
