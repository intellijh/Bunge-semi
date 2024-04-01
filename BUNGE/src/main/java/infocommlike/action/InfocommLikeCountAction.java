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

public class InfocommLikeCountAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		
			BoardDAO boarddao = new BoardDAO();
		
			int comm_num = Integer.parseInt(request.getParameter("comm_num"));
			System.out.println("ajax를 통해 온 comm_num : " + comm_num);
			
			int commlikecount = boarddao.commlikecount(comm_num);
			PrintWriter out = response.getWriter();
			out.print(commlikecount);
		

		return null;
	}

}
