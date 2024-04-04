package comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		  
		//{"comment_board_num" : $("#comment_board_num").val(),state:state}, //state값이 1=>등록순, 2=> 최신순
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		System.out.println(inf_num);
		int state = Integer.parseInt(request.getParameter("state"));
//		String m_id = request.getParameter("inf_num");
		
		int listcount = dao.getListCount(inf_num);
		
		JsonObject object = new JsonObject();
		object.addProperty("listcount", listcount);
		
		JsonArray jarray = dao.getCommentList(inf_num,state);
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("commentlist", je);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
	}
}
