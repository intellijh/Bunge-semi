package common.login;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class loginProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		String m_id = request.getParameter("m_id");
		String m_pwd = request.getParameter("m_pwd");
		MemberDAO mdao = new MemberDAO();
		int result = mdao.loginid(m_id, m_pwd);
		System.out.println("결과 : " + result);
		
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("m_id",m_id);
			
			String IDStore = request.getParameter("checkid");
			Cookie cookie = new Cookie("m_id", m_id);
			
			//ID 기억하기를 체크한 경우
			if(IDStore != null && IDStore.equals("store")) {
				cookie.setMaxAge(2 * 60);
				response.addCookie(cookie);
			}else {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			
			forward.setRedirect(true);
			forward.setPath("index.jsp");
			return forward;
		
		} else {
			String message = "비밀번호가 일치하지 않습니다.";
			if(result == -1) 
				message = "아이디가 존재하지 않습니다.";
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('"+message+"');");
			out.print("location.href='login.com';");
			out.print("</script>");
			out.close();
		}		
		return null;
	}

}
