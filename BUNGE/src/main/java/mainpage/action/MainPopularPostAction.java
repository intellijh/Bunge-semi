package mainpage.action;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import info.db.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainPopularPostAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		
		BoardDAO boarddao = new BoardDAO();
		JsonObject object = new JsonObject();
		ArrayList<JsonObject> popularpostlist = new ArrayList<JsonObject>();
		
		popularpostlist = boarddao.getpopularPost();
		
		JsonElement je = new Gson().toJsonTree(popularpostlist);
		object.add("popularpostlist", je);
		
		response.getWriter().print(object);
		return null;
	}

}
