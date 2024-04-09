package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

//import com.google.gson.Gson;
//import com.google.gson.JsonElement;
//import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import info.db.BoardDAO;
import info.db.Board;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class mypageReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
//		InfoLikeDAO infolikedao = new InfoLikeDAO();
//		MypageDAO mypagedao = new MypageDAO();
//		List<Myboard> boardlist = new ArrayList<>();

		BoardDAO boarddao = new BoardDAO();
		HttpSession session = request.getSession();
		ArrayList<Board> boardlist = new ArrayList<Board>();
		PrintWriter out = response.getWriter();

		String m_id= (String)session.getAttribute("m_id");
		System.out.println("m_id : " + m_id);

		if(m_id != null ) {  
			boardlist = boarddao.getmyPost(m_id);
			request.setAttribute("boardlist", boardlist);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("mypage/reviewlist.jsp");
			
			return forward;
	            
	            
        } else {
        	response.setContentType("text/html; charset=utf-8");
            String message = "로그인 후 이용 가능합니다.";
            out.print("<script>");
            out.print("alert('" + message + "');");
            out.print("location.href='login.com';");
            out.print("</script>");
            out.close();
            
            return null;
        }
	}
}
		
//		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		
//		System.out.println("inf_num : " + inf_num);
	
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
//		int infodata = infolikedao.getInfoLikeInsert(inf_num,m_id);
//		int cnt = infolikedao.Infolikecnt(inf_num);
		
		
         
//		System.out.println("cnt : " + cnt);
//		JsonObject object = new JsonObject();
//		object.addProperty("cnt", cnt);
//		JsonElement je = new Gson().toJsonTree(boardlist);
//		System.out.println("boardlist = " + je.toString());
//		object.add("boardlist", je);
//		response.setContentType("application/json;charset=utf-8");
//		PrintWriter out = response.getWriter();
//		out.print(object.toString());
//		return null;
        
	

