package common.login;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.Member;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class pwdresetAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 MemberDAO dao = new MemberDAO();
		 ActionForward forward = new ActionForward();
		 PrintWriter out = response.getWriter();
		 HttpSession session = request.getSession();
		
		 String m_id = (String) session.getAttribute("m_id"); 
		 String m_pwd = request.getParameter("m_pwd");
		 
		Member m = new Member();
		m.setM_pwd(m_pwd); 
		m.setM_id(m_id);
		
		int result = dao.pwdreset(m);
		

		if(result == 1) {
			session.setAttribute("m_id", m_id);
			forward.setRedirect(true);
			forward.setPath("/member/loginFrom.jsp");
			String message = "비밀번호가 수정되었습니다.";
			out.println("<script>");
			out.println("alert('"+message+"');");
			out.println("</script>");
			return forward;
		} else {
			response.setContentType("text/html; charset=utf-8");
			out.println("<script>");
			out.println("alert('비밀번호 수정 실패했습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
		}
		
	}

}
