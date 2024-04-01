package comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;

import comment.db.Comment;
import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		CommentDAO dao = new CommentDAO();
		
		Comment co = new Comment();
		
		co.setM_id(request.getParameter("m_id"));
		System.out.println("id : " + request.getParameter("m_id"));
		co.setComm_content(request.getParameter("comm_content"));
		System.out.println("comm_content = " + co.getComm_content());
		co.setInf_num(Integer.parseInt(request.getParameter("inf_num")));
		System.out.println("inf_num = " + request.getParameter("inf_num"));
		co.setComm_lev(Integer.parseInt(request.getParameter("comm_lev")));
		co.setComm_seq(Integer.parseInt(request.getParameter("comm_seq")));
		
		int ok = dao.commentsInsert(co);
		int comm_num = dao.commentsinsertedNum();
		
		JsonObject object = new JsonObject();
		object.addProperty("ok", ok);
		object.addProperty("comm_num", comm_num);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		
		return null;
	}
}
