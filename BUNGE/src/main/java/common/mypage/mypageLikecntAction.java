package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import common.db.Myboard;
import common.db.MypageDAO;
import infoboardlike.db.InfoLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class mypageLikecntAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
		InfoLikeDAO infolikedao = new InfoLikeDAO();
		MypageDAO mypagedao = new MypageDAO();
		HttpSession session = request.getSession();
		List<Myboard> boardlist = new ArrayList<>();
		
		// 글 번호 파라미터 값을 num변수에 저장합니다.
		 String m_id= (String)session.getAttribute("m_id");
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		
		System.out.println("m_id : " + m_id);
		System.out.println("inf_num : " + inf_num);
	
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
//		int infodata = infolikedao.getInfoLikeInsert(inf_num,m_id);
		int cnt = infolikedao.Infolikecnt(inf_num);
		
		 boardlist = mypagedao.getBoardList(m_id);
         request.setAttribute("boardlist", boardlist);
         
		System.out.println("cnt : " + cnt);
		
		JsonObject object = new JsonObject();
		object.addProperty("cnt", cnt);
		
		JsonElement je = new Gson().toJsonTree(boardlist);
		System.out.println("boardlist = " + je.toString());
		object.add("boardlist", je);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		
		return null;
	}

}
