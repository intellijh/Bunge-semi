package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class myinfoboardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		int page = 1;//보여줄 페이지
		int limit = 10;//한 페이지에 보여줄 게시판 목록의 수
		
		
		return null;
	}

}
