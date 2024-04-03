package info.action;

import java.io.IOException;
import java.sql.SQLException;

import javax.naming.NamingException;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfobooksearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("Infoboard/Infobooksearch.jsp");
		return forward;
	}

}
