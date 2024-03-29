package info.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.action.Action;
import common.action.ActionForward;
import info.db.Board;
import info.db.BoardDAO;
import info.db.Boardfile;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoModifyProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		BoardDAO boarddao = new BoardDAO();
		Board board = new Board();
		Boardfile boardfile = new Boardfile();
		ActionForward forward = new ActionForward();
		
		String saveFolder = "boardupload";
		int filesize = 10 * 1024 * 1024;
		ServletContext sc = request.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder="+realFolder);
		try {
			MultipartRequest multi =
					new MultipartRequest(request, realFolder, filesize, "utf-8",
										 new DefaultFileRenamePolicy());
			
			String id = multi.getParameter("m_id");
			int num = Integer.parseInt(multi.getParameter("inf_num"));
			
			board.setInf_num(num);
			board.setInf_subject(multi.getParameter("inf_subject"));
			board.setInf_content(multi.getParameter("inf_content"));
			
			String check
			
		}
		
		
	}

}
