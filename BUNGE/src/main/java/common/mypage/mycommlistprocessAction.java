package common.mypage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import common.db.MypageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class mycommlistprocessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		
		MypageDAO mypagedao = new MypageDAO();
		JsonObject object = new JsonObject();
		ArrayList<JsonObject> list = new ArrayList<JsonObject>();
		HttpSession session = request.getSession();

		
		String m_id= (String)session.getAttribute("m_id");
		
		list = mypagedao.getCommList(m_id);
		
		JsonElement js = new Gson().toJsonTree(list);
		object.add("commlist", js);

		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(object);
		
		return null;
	}

}
