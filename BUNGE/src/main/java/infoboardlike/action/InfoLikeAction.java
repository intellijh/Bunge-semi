package infoboardlike.action;

import java.io.IOException;
import java.util.ArrayList;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import info.db.Boardfile;
import infoboardlike.db.InfoLike;
import infoboardlike.db.InfoLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class InfoLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		InfoLikeDAO boarddao = new InfoLikeDAO();

		// 글 번호 파라미터 값을 num변수에 저장합니다.
		String m_id = (String)session.getAttribute("m_id");
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("m_id : " + m_id);
		System.out.println("num : " + num);
		
		//특정 주소로부터의 이동을 확인하는데 사용할 수 있는 정보는 요청 헤더인 "Referer"에 있습니다.
		String referer = request.getHeader("Referer");
		if(referer != null  && referer.contains("InfoLike.com")) {
			//내용을 확인할 글의 조회수를 증가시킵니다.
			System.out.println("referer= " + referer);
			boarddao.setNoUpdate(m_id);
		}
		
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
		InfoLike infolike = boarddao.getDetail(num);
	
		ActionForward forward = new ActionForward();
		//boarddata = null; //error 테스트를 위한 값 설정
		//DAO에서 글의 내용을 읽지 못했을 경우 null을 반환합니다.
		if(infolike == null) {
			System.out.println("상세보기 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("상세보기 성공");
		
		//boarddata 객체를 request 객체에 저장합니다.
		request.setAttribute("boarddata", infolike);
		System.out.println(infolike);
		forward.setRedirect(false);
		forward.setPath("Infoboard/InfoViewDetail.jsp"); //글 내용을 보기 페이지로 이동하기 위해 경로를 설정합니다.
		return forward;
	}
}
