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

public class MainPopularBookAciton implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		
		
			BoardDAO boarddao = new BoardDAO();
			JsonObject object = new JsonObject();
			ArrayList<JsonObject> popularbooklist = new ArrayList<JsonObject>();
			
			popularbooklist = boarddao.getpopularBook();
			
			JsonElement je = new Gson().toJsonTree(popularbooklist);
			object.add("popularbooklist", je);
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println("popularbooklist : "+ object.toString());
			
		return null;
	}
}
