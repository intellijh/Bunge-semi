package info.action;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoReplyProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward  forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		int result = 0;
		
		//파라미터로 넘어온 값들을 boarddata 객체에 저장합니다.
		 Board boarddata = new Board();
		 boarddata.setM_id(request.getParameter("m_id"));
		 boarddata.setInf_subject(request.getParameter("inf_subject"));
		 boarddata.setInf_content(request.getParameter("inf_content"));
		 boarddata.setInf_ref(Integer.parseInt(request.getParameter("inf_ref")));
		 boarddata.setInf_lev(Integer.parseInt(request.getParameter("inf_lev")));
		 boarddata.setInf_seq(Integer.parseInt(request.getParameter("inf_seq")));
	
		 // 답변을 DB에 저장하기 위해 boarddata 객체를 파라미터로 전달하고
		 //DAO의 메서드를 boardReply를 호출합니다.
		 result = boarddao.boardReply(boarddata);
		 
		 //답변 저장에 실패한 경우
		 if (result == 0) {
			 System.out.println("답장 저장 실패");
			 forward.setRedirect(false);
			 request.setAttribute("message", "답장 저장 실패입니다.");
			 forward.setPath("error/error.jsp");
		 } else {
			 //답변 저장이 제대로 된 경우
			 System.out.println("답장 완료");
			 forward.setRedirect(true);
			 
			 System.out.println("result= " + result);
			 
			 //답변 글 내용을 확인하기 위해 글 내용 보기 페이지를 경로로 설정합니다.
			 forward.setPath("InfoDetail.com?num=" + result);
		 }
		 return forward;
	}
}
