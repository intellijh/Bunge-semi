package comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("comm_num"));
		
		CommentDAO dao = new CommentDAO();
		
		int result = dao.commentDelete(num);
		PrintWriter out = response.getWriter();
		out.print(result);
		
		return null;
	}
}
