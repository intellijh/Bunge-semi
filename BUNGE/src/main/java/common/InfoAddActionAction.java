package common;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.action.Action;
import common.action.ActionForward;
import common.db.Board;
import common.db.BoardDAO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoAddActionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Board board = new Board();
		BoardDAO dao = new BoardDAO();
		ActionForward forward = new ActionForward();
		
		String realFolder ="";
		
		//webapp아래에 꼭 폴더 생성하세요
		String saveFolder = "boardupload";
		
		int fileSize = 5*1024*1024; //업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		boolean result = false;
		try { 
			MultipartRequest multi = new MultipartRequest(
					request, 
					realFolder,
					fileSize,
					"utf-8",
					new DefaultFileRenamePolicy());
			board.setM_id(multi.getParameter("m_id"));
			board.setInf_subject(multi.getParameter("inf_subject"));
			board.setInf_content(multi.getParameter("inf_content"));
					
			//시스템 상에 업로드된 실제 파일명을 얻어옵니다.
			String filename = multi.getFilesystemName("inf_file");
			board.setInf_file(filename);
			
			//글 등록 처리를 위해 DAO의 boardInsert()메서드를 호출합니다.
			//글 등록 폼에서 입력한 정보가 저장되어 있는 boarddata 객체를 전달합니다.
			result = dao.boardInsert(board);
			
			//글 등록에 실패할 경우 false를 반환합니다.
			if(result == false) {
				System.out.println("게시판 등록 실패");
				forward.setRedirect(false);
				return forward;
			}
			System.out.println("게시판 등록 왼료");
			forward.setRedirect(true);
			return forward;
		}catch(IOException ex) {
			ex.printStackTrace();
			forward.setRedirect(false);
			return forward;
		}
	}
}

