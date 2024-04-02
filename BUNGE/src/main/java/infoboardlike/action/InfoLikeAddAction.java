package infoboardlike.action;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import infoboardlike.db.InfoLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class InfoLikeAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		InfoLikeDAO infolikedao = new InfoLikeDAO();

		String m_id = request.getParameter("m_id");
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		System.out.println("m_id : " + m_id);
		System.out.println("inf_num : " + inf_num);
		
		int result = infolikedao.getInfoLikeInsert(inf_num,m_id);
			
		PrintWriter out = response.getWriter();
		out.print(result);

		return null;
	}
}
		
/*		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
		int infodata = infolikedao.getInfoLikeInsert(inf_num,m_id);
		PrintWriter out = response.getWriter();
		out.print(infodata);
	
		ActionForward forward = new ActionForward();
		//boarddata = null; //error 테스트를 위한 값 설정
		//DAO에서 글의 내용을 읽지 못했을 경우 null을 반환합니다.
		if(infodata < 0) {
			System.out.println("상세보기 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("상세보기 성공");
		
		//boarddata 객체를 request 객체에 저장합니다.
		request.setAttribute("infodata", infodata);
		System.out.println(infodata);
		forward.setRedirect(false);
		forward.setPath("Infoboard/InfoViewDetail.jsp"); //글 내용을 보기 페이지로 이동하기 위해 경로를 설정합니다.		*/

