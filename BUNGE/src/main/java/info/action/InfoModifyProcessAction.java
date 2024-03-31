package info.action;

import java.io.IOException;
import java.util.StringTokenizer;

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
		Boardfile boardfile;
		ActionForward forward = new ActionForward();
		boolean board_result = false;
		boolean file_result = false;
		
		String saveFolder = "boardupload";
		int filesize = 10 * 1024 * 1024;
		ServletContext sc = request.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		
		try {
			MultipartRequest multi =
			new MultipartRequest(request, realFolder, filesize, "utf-8",
								 new DefaultFileRenamePolicy());
			
			int inf_num = Integer.parseInt(multi.getParameter("inf_num"));
			
			board.setInf_num(inf_num);
			board.setInf_subject(multi.getParameter("inf_subject"));
			board.setInf_content(multi.getParameter("inf_content"));
			board.setInf_open(Integer.parseInt(multi.getParameter("inf_open")));
			board.setInf_loc(multi.getParameter("inf_loc"));
			
			board_result = boarddao.boardModify(board);
			
		//	boarddao.boardfileReset(inf_num);
			String[] origin = multi.getParameter("originvalue").split(",");
			String[] nochange = new String[5];
			for (int k=1; k<=5; k++) {
				System.out.println("원래 첨부된 파일 이름 : " + multi.getParameter("originvalue"));
				System.out.println("수정없는 파일 이름 : " + multi.getParameter("filevalue"+k));
					nochange[k-1] = multi.getParameter("filevalue"+k);
			}
			
			for (String item : nochange) {
				System.out.println("item : " + item);
			}
			
		//	boarddao.boardmodifyDelete(inf_num, nochange);
			
		//	for (int k=1; k<=5; k++) {
		//		System.out.println("수정이 없는 파일 이름 : " + multi.getParameter("filevalue"+k));
		//	}
			
			
			for (int i=1; i<=5; i++) {
				String fileorigin = multi.getOriginalFileName("boardfile"+i);
				System.out.println("boardfile1_original : " + multi.getOriginalFileName("boardfile"+i));
				String fileserver = multi.getFilesystemName("boardfile"+i);
				System.out.println("boardfile1_file : " + multi.getFilesystemName("boardfile"+i));
				if (fileorigin != null) {
				boardfile = new Boardfile();
					boardfile.setInfa_filename(fileorigin);
					boardfile.setInfa_servername(fileserver);
					file_result = boarddao.boardfileModify(inf_num, boardfile);
				}
			}
			
			if (board_result && file_result) {
				System.out.println("게시판 수정 완료");
				forward.setPath("InfoDetail.com?num=" + board.getInf_num());
			} else {
				System.out.println("게시판 수정 실패");
				forward.setRedirect(false);
				forward.setPath("error/error.jsp");
			}
			
			return forward;
			
	} catch (IOException e) {
		e.printStackTrace();
		forward.setPath("error/error.jsp");
		request.setAttribute("message", "게시판 업로드 중 실패입니다.");
		forward.setRedirect(false);
		return forward;
	}

	}
}
