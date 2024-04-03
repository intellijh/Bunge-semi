package infocommlike.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.naming.NamingException;

import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfocommLikeAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
			
		CommentDAO commentdao = new CommentDAO();
		
		int comm_num = Integer.parseInt(request.getParameter("comm_num"));
		String m_id = request.getParameter("m_id");
		
		int add = commentdao.CommLikeInsert(m_id, comm_num);
		
		PrintWriter out = response.getWriter();
		out.print(add);

		return null;
	}

}
