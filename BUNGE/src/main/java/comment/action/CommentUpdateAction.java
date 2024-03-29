package comment.action;

import java.io.IOException;

import comment.db.Comment;
import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException,IOException {
		CommentDAO dao = new CommentDAO();
		Comment co = new Comment();
		co.setComm_content(request.getParameter("comm_content"));
		System.out.println("comm_content = " + co.getComm_content());
		
		co.setComm_num(Integer.parseInt(request.getParameter("comm_num")));
		
		int ok = dao.commentsUpdate(co);
		response.getWriter().print(ok);
		
		return null;
	}
}
