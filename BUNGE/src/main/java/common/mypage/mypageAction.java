package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
;

public class mypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		MemberDAO dao = new MemberDAO();
		PrintWriter out = response.getWriter();
		
		String m_id = request.getParameter("m_id");
		
		HttpSession session = request.getSession();
		session.setAttribute("m_id", m_id);
		if(m_id != null) {
			forward.setRedirect(false);
			forward.setPath("mypage/mypage.jsp");
			return forward;
		}else {
			
		}
		return forward;
		
	}

}
