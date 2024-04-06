package header.action;

import java.io.IOException;
import java.sql.SQLException;

import javax.naming.NamingException;


import common.action.Action;
import common.action.ActionForward;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HeaderProfileAciton implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
			String m_id = request.getParameter("m_id");
		 	
		 	MemberDAO memberdao = new MemberDAO();
			String headerprof = memberdao.getProfile(m_id);
			
			response.getWriter().print(headerprof);
			
		return null;
	}
}
