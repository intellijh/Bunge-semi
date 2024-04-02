package infoboardlike.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;

import common.action.Action;
import common.action.ActionForward;
import infoboardlike.db.InfoLikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class InfoLikeDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		InfoLikeDAO infolikedao = new InfoLikeDAO();

		String m_id = request.getParameter("m_id");
		int inf_num = Integer.parseInt(request.getParameter("inf_num"));
		System.out.println("m_id : " + m_id);
		System.out.println("inf_num : " + inf_num);
		
		int del = infolikedao.InfoLikeDelete(inf_num,m_id);
		System.out.println("del : " + del);
		
		PrintWriter out = response.getWriter();
		out.print(del);

		return null;
	}
}