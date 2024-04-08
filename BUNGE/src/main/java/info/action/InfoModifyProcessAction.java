package info.action;

import java.io.IOException;

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
		boolean board_result = false;
		
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
			board.setInf_book(multi.getParameter("inf_book"));
			board.setInf_cover(multi.getParameter("inf_cover"));
			board.setInf_author(multi.getParameter("inf_author"));
			board.setInf_category(multi.getParameter("inf_category"));
			board.setInf_pubdate(multi.getParameter("inf_pubdate"));
			
			board_result = boarddao.boardModify(board);
			
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
				String fileorigin = multi.getOriginalFileName("upfile"+i);
				System.out.println("fileorigin : " + multi.getOriginalFileName("upfile"+i));
				String fileserver = multi.getFilesystemName("upfile"+i);
				System.out.println("fileserver : " + multi.getFilesystemName("upfile"+i));
				if (fileorigin == null) {
					//원래 첨부한 파일을 삭제한 경우
					if (!lastname[i-1].equals(origin[i-1])) {
						if (lastname[i-1].isEmpty()) {
							deleteitem = origin[i-1];
							System.out.println("deleteitem : " + deleteitem);
							boarddao.boardmodifyDelete(inf_num, deleteitem);
						}
					}
					//원래 첨부파일이 있던 곳에 새롭게 첨부하는 경우
				} else {
						boardfile.setInfa_filename(fileorigin);
						boardfile.setInfa_servername(fileserver);
						boarddao.boardfileModify(inf_num, boardfile);
						System.out.println("성공");
					
						deleteitem = origin[i-1];
						System.out.println("deleteitem : "+deleteitem);
						boarddao.boardmodifyDelete(inf_num, deleteitem);
							
				}
			}
			
			
/*			
			for (int i=1; i<=5; i++) {
				String fileorigin = multi.getOriginalFileName("boardfile"+i);
				System.out.println("fileorigin : " + multi.getOriginalFileName("upfile"+i));
				String fileserver = multi.getFilesystemName("boardfile"+i);
				System.out.println("fileserver : " + multi.getFilesystemName("upfile"+i));
				if (fileorigin == null) {
					for (int k=1; i<=5; k++) {
						String origname = multi.getParameter("inf_file"+k);
						if (origname != null) {
							origfile_result = boarddao.boardmodifyDelete(inf_num, origname);
						}
					}
				} else {
					boardfile.setInfa_filename(fileorigin);
					boardfile.setInfa_servername(fileserver);
					newfile_result = boarddao.boardfileModify(inf_num, boardfile);
				}
			}
*/					
			
			if (board_result) {
				System.out.println("게시판 수정 완료");
				forward.setRedirect(true);
				forward.setPath("InfoDetail.com?inf_num=" + board.getInf_num());
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
