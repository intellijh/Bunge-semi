package infocommlike.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.naming.NamingException;

import common.action.Action;
import common.action.ActionForward;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfocommLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		
		BoardDAO boarddao = new BoardDAO();
		boolean result = false;
		
		int comm_num = Integer.parseInt(request.getParameter("comm_num"));
		String m_id = request.getParameter("m_id");
		
		result = boarddao.commLike(m_id, comm_num);
		PrintWriter out = response.getWriter();
		out.print(result);

		return null;
	}

}
