package comment.action;

import java.io.IOException;

import comment.db.Comment;
import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		
		Comment co = new Comment();
		co.setM_id(request.getParameter("m_id"));
		co.setComm_content(request.getParameter("comm_content"));
		co.setInf_num(Integer.parseInt(request.getParameter("num")));
		co.setComm_lev(Integer.parseInt(request.getParameter("comm_lev")));
		co.setComm_seq(Integer.parseInt(request.getParameter("comm_seq")));
		co.setComm_ref(Integer.parseInt(request.getParameter("comm_ref")));
		
		int ok = dao.commentsReply(co);
		response.getWriter().print(ok);
		
		return null;
	}

}
