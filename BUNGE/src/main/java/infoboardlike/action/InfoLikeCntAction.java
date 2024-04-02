package infoboardlike.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import infoboardlike.db.InfoLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class InfoLikeCntAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		InfoLikeDAO infolikedao = new InfoLikeDAO();

		// 글 번호 파라미터 값을 num변수에 저장합니다.
		String m_id = request.getParameter("m_id");
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		System.out.println("m_id : " + m_id);
		System.out.println("inf_num : " + inf_num);
	
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
//		int infodata = infolikedao.getInfoLikeInsert(inf_num,m_id);
		int cnt = infolikedao.Infolikecnt(inf_num);
		int check = infolikedao.Infolikecheck(inf_num,m_id);
		System.out.println("cnt : " + cnt);
		System.out.println("check : " + check);
		
		JsonObject object = new JsonObject();
		object.addProperty("cnt", cnt);
		object.addProperty("check", check);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		
		return null;
	}
}
