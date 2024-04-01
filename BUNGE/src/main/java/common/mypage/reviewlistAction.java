package common.mypage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import common.db.MypageDAO;
import common.db.mypage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class reviewlistAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
			ActionForward forward = new ActionForward();
			MypageDAO mypagedao = new MypageDAO();
			List<mypage> boardlist =new ArrayList<>();
			HttpSession session= request.getSession();
			
			String m_id= (String)session.getAttribute("m_id");
			
			if(m_id != null ) {
				int page = 1;
				int limit= 10;
				if(request.getParameter("page") != null) {
					page = Integer.parseInt(request.getParameter("page"));
				}
				
				//추가
				if(request.getParameter("limit") != null) {
					limit = Integer.parseInt(request.getParameter("limit"));
				}
				
				int listcount = mypagedao.getList();
				
				boardlist = mypagedao.getBoardList(m_id,page, limit);
				
				int maxpage = (listcount + limit -1)/limit;
				
				int startpage = ((page -1)/10)*10 -1;
				System.out.println("현재 페이지에 보여줄 시작 페이지 수 : " + startpage);
				
				int endpage = startpage + 10 -1;
				System.out.println("현재 페이지에 보여줄 마지막 페이지 수 :" + endpage);
				
				if(endpage > maxpage)
					endpage=maxpage;
				
				String state = request.getParameter("state");
				
				if(state == null) {
					System.out.println("state==null");
					request.setAttribute("page", page);
					request.setAttribute("maxpage", maxpage);
					
					request.setAttribute("endpage", endpage);
					
					request.setAttribute("listcount", listcount);
					
					request.setAttribute("boardlist", boardlist);
					
					request.setAttribute("limit", limit);
					forward.setRedirect(false);
					forward.setPath("mypage/reviewlist.jsp");
					return forward;			
				}else {
					System.out.println("state=ajax");
					
					JsonObject object = new JsonObject();
					object.addProperty("page", page);
					object.addProperty("maxpage", maxpage);
					object.addProperty("startpage", startpage);
					object.addProperty("endpage", endpage);
					object.addProperty("limit", limit);
					
					JsonElement je = new Gson().toJsonTree(boardlist);
					System.out.println("boardlist=" +je.toString());
					object.add("boardlist", je);
					
					response.setContentType("application/json;charset=utf-8");
					response.getWriter().print(object);
					System.out.println(object.toString());
					
				}
			}
			return null;
	}
}
