package common.login;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class loginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		String m_id = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("m_id")) {
					m_id=cookies[i].getValue();
				}
			}
		}
		request.setAttribute("cookie_id", m_id);
		forward.setPath("member/loginForm.jsp");		
		forward.setRedirect(false);
		return forward;
	}

}
