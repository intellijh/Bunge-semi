package common;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class findidProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDAO mdao = new MemberDAO();
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
			
		String m_name = request.getParameter("m_name");
		String m_email = request.getParameter("m_email");
		String m_id = mdao.findid(m_name, m_email);
		System.out.println("결과 : " + m_id );
		
		if(m_id != null) {
			forward.setRedirect(false);
			request.getSession().setAttribute("m_id", m_id);
			forward.setPath("member/idcompleteForm.jsp");
			String message = "아이디 찾기에 성공하셨습니다.";
			out.print("<script>");
			out.print("alert('"+message+"');");
			out.print("</script>");
			return forward;
			}else {
				response.setContentType("text/html;charset=utf-8");
				String message = "이름과 이메일 정보가 일치하지 않습니다.";
				out.print("<script>");
				out.print("alert('"+message+"');");
				out.print("location.href='findid.com';");
				out.print("</script>");
				out.close();
		}
		return null;
	}

}
