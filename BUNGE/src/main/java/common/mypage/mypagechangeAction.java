package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.action.Action;
import common.action.ActionForward;
import common.db.Mypage;
import common.db.MypageDAO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class mypagechangeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		String m_id = (String) session.getAttribute("m_id"); 
		
		if(m_id != null) {
			
			String realFolder = "";
			String saveFolder = "memberupload";
			
			int fileSize=5 * 1024 * 1024;
			
			ServletContext sc = request.getServletContext();
			realFolder = sc.getRealPath(saveFolder);
			System.out.println("realFoder=[" + realFolder);
			try {
				MultipartRequest multi = new MultipartRequest(request, realFolder, fileSize, "utf-8" ,
						new DefaultFileRenamePolicy());
				
				String m_pwd = multi.getParameter("m_pwd");
				String m_nick = multi.getParameter("m_nick");
				String m_zipcode = multi.getParameter("m_zipcode");
				String m_addr1 = multi.getParameter("m_addr1");
				String m_addr2 = multi.getParameter("m_addr2");
				String m_phone = multi.getParameter("m_phone");
				String m_email = multi.getParameter("m_email");
				String check = multi.getParameter("check");
				
				Mypage m = new Mypage();
				
				if (multi.getFilesystemName("m_profile") == null) {
					m.getMember().setM_profile(check);
				} else {
					m.getMember().setM_profile(multi.getFilesystemName("m_profile"));
				}
				
				m.getMember().setM_pwd(m_pwd);	m.getMember().setM_nick(m_nick);
				m.getMember().setM_zipcode(m_zipcode);	m.getMember().setM_addr1(m_addr1);
				m.getMember().setM_addr2(m_addr2);		m.getMember().setM_phone(m_phone);
				m.getMember().setM_email(m_email);
				m.getMember().setM_id(m_id);
				

				
				MypageDAO mdao = new MypageDAO();
				Boolean result = mdao.mypagechange(m);
				
				System.out.println(result);
				
				response.setContentType("text/html; charset=utf-8");
				
				out.println("<script>");
				if(result == true) {
					out.println("alert('수정되었습니다.');");
					out.println("location.href='mypage.com'");	
				}else {
					out.println("alert('회원 정보 수정에 실패했습니다.')");
					out.println("history.back()");
				}
				out.println("</script>");
				out.close();

 			}catch (IOException ex) {
 				ex.printStackTrace();
 				forward.setPath("error/error.jsp");
 				request.setAttribute("message", "프로필 사진 업로드 실패입니다.");
 				forward.setRedirect(false);
 				return forward;
 				}//catch end
		}//if m_id end
		return null;
	}
}