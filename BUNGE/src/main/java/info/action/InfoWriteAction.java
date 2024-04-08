package info.action;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String bookcover = request.getParameter("bookcover");
		String booktitle = request.getParameter("booktitle");
		String bookauthor = request.getParameter("bookauthor");
		String bookcategoryname = request.getParameter("bookcategoryname");
		String bookpubdate = request.getParameter("bookpubdate");
		System.out.println("bookcover : " + bookcover);
		System.out.println("booktitle : " + booktitle);
		
		request.setAttribute("bookcover", bookcover);
		request.setAttribute("booktitle", booktitle);
		request.setAttribute("bookauthor", bookauthor);
		request.setAttribute("bookcategoryname", bookcategoryname);
		request.setAttribute("bookpubdate", bookpubdate);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("Infoboard/InfoWrite.jsp");
		return forward;
	}
}
