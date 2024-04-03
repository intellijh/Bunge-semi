package infocommlike.action;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.JsonObject;
import comment.db.CommentDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfocommLikeCntAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CommentDAO commentdao = new CommentDAO();

		// 글 번호 파라미터 값을 num변수에 저장합니다.
		String m_id = request.getParameter("m_id");
		int comm_num = Integer.parseInt(request.getParameter("comm_num"));
		System.out.println("m_id : " + m_id);
		System.out.println("comm_num : " + comm_num);
		
		int cnt = commentdao.InfocommLikeCnt(comm_num);
		int check = commentdao.InfocommLikeCheck(comm_num,m_id);
		System.out.println("cnt : " + cnt);
		System.out.println("check : " + check);
		
		JsonObject object = new JsonObject();
		object.addProperty("cnt", cnt);
		object.addProperty("check", check);
		object.addProperty("this_comm_num", comm_num);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		
		return null;
	}
}
