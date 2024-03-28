package common;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.action.Action;
import common.action.ActionForward;
import common.db.Board;
import common.db.BoardDAO;
import common.db.Boardfile;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Board board = new Board();
		Boardfile boardfile = new Boardfile();
		BoardDAO dao = new BoardDAO();
		ActionForward forward = new ActionForward();
		boolean result = false;
		int success = 0;
		
		String realFolder ="";
		
		//webapp아래에 꼭 폴더 생성하세요
		String saveFolder = "boardupload";
		
		int fileSize = 5*1024*1024; //업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		
		try { 
			MultipartRequest multi = new MultipartRequest(
					request, 
					realFolder,
					fileSize,
					"utf-8",
					new DefaultFileRenamePolicy());
			board.setM_id(multi.getParameter("m_id"));
			board.setInf_open(Integer.parseInt(multi.getParameter("inf_open")));
			board.setInf_subject(multi.getParameter("inf_subject"));
			board.setInf_content(multi.getParameter("inf_content"));
			board.setInf_reg(multi.getParameter("inf_reg"));
			System.out.println("inf_open : "+ board.getInf_open());
			//시스템 상에 업로드된 실제 파일명을 얻어옵니다.
			System.out.println("사용자가 저장할 파일 이름 : " + multi.getOriginalFileName("inf_file"));
			
			System.out.println("서버에 저장될 파일이름"+multi.getFilesystemName("inf_file"));
			
			if(multi.getFilesystemName("inf_file") != null) {
				boardfile.setInfa_filename(multi.getFilesystemName("inf_file"));
				System.out.println("inf_file :"+ multi.getFilesystemName("inf_file"));
				//글 등록 처리를 위해 DAO의 boardInsert()메서드를 호출합니다.
				//글 등록 폼에서 입력한 정보가 저장되어 있는 boarddata 객체를 전달합니다.
				success = dao.boardInsert(board);
				result = dao.boardinsertFile(success, boardfile);
			} else {
				success = dao.boardInsert(board);
			}
			
			if (result == true) {
				if (success != 0) {
					System.out.println("첨부파일게시판 등록 왼료");
					forward.setRedirect(true);
					forward.setPath("BoardList.com");
					return forward;
				} else {
					System.out.println("첨부파일게시판 등록 실패");
					forward.setRedirect(false); 
					forward.setPath("error/error.jsp");
					return forward;
				}
			} else {
				if (success != 0) {
					System.out.println("게시판 등록 왼료");
					forward.setRedirect(true);
					forward.setPath("BoardList.com");
					return forward;
				} else {
					System.out.println("게시판 등록 실패");
					forward.setRedirect(false); 
					forward.setPath("error/error.jsp");
					return forward;
				}
			}
		} catch (IOException ex) {
			ex.printStackTrace();
			forward.setRedirect(false);
			forward.setPath("error/error.jsp");
			return forward;
		}
	}
}

