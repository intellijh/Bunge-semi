package info.action;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		
		//파라미터로 전달받은 수정할 글 번호를 num 변수에 저장합니다.
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		
		//글 내용을 불러와서 boarddata 객체에 저장합니다.
		Board boarddata = boarddao.getDetail(inf_num);
		
		//글 내용을 불러오기 실패한 경우입니다.
		if (boarddata == null) {
			System.out.println("글이 존재하지 않습니다.");
			request.setAttribute("message", "글이 존재하지 않습니다.");
			forward.setPath("error/error.jsp");
		} else {
			System.out.println("답변 페이지 이동 완료");
			
			//수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를
			// request 객체에 저장합니다.
			 request.setAttribute("boarddata", boarddata);
			 
			 //글 수정 폼 페에지로 이동하기 위해 경로를 설정합니다.
			 forward.setPath("Infoboard/InfoReply.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}
}
