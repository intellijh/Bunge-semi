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
			String[] origin = new String[5]; 
			String[] lastname = new String[5];
			String deleteitem;
			for (int k=1; k<=5; k++) {
				System.out.println("원래 첨부된 파일 이름 : " + multi.getParameter("originvalue"+k));
					origin[k-1] = multi.getParameter("originvalue"+k);
				System.out.println("수정 할 때 등록된 파일 이름 : " + multi.getParameter("filevalue"+k));
					lastname[k-1] = multi.getParameter("filevalue"+k);
			}
			
			for (String no : lastname) {
				System.out.println("lasntname[]수정할 때 등록된 파일 이름 : " + no);
			}
			
			for (String orig : origin) {
				System.out.println("origin[]원래 첨부된 파일 이름 : " + orig);
			}
			
			for (int i=1; i<=5; i++) {
				String fileorigin = multi.getOriginalFileName("boardfile"+i);
				System.out.println("fileorigin : " + multi.getOriginalFileName("boardfile"+i));
				String fileserver = multi.getFilesystemName("boardfile"+i);
				System.out.println("fileserver : " + multi.getFilesystemName("boardfile"+i));
				if (fileorigin != null) {
					//원래 첨부하지 않은 곳에 새롭게 첨부하는 경우
					if (origin[i-1].isEmpty()) {
						origin[i-1] = "0";
						boardfile = new Boardfile();
						boardfile.setInfa_filename(fileorigin);
						boardfile.setInfa_servername(fileserver);
						file_result = boarddao.boardnofileModify(inf_num, boardfile, origin[i-1]);
					//원래 첨부파일이 있떤 곳에 새롭게 첨부하는 경우
					} else {
						boardfile = new Boardfile();
						boardfile.setInfa_filename(fileorigin);
						boardfile.setInfa_servername(fileserver);
						file_result = boarddao.boardfileModify(inf_num, boardfile, origin[i-1]);
					}
					//원래 존재하던 첨부파일을 삭제하는 경우
				} else {
					if (!origin[i-1].equals(lastname[i-1]) && lastname[i-1].isEmpty()) {
						deleteitem = origin[i-1];
						file_result = boarddao.boardmodifyDelete(inf_num, deleteitem);
					}
				}
			}
			
			if (board_result) {
				System.out.println("게시판 수정 완료");
				forward.setRedirect(true);
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
