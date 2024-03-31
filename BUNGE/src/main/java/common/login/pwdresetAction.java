package common.login;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.Member;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class pwdresetAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    MemberDAO dao = new MemberDAO();
	    ActionForward forward = new ActionForward();
	    PrintWriter out = response.getWriter();
	    HttpSession session = request.getSession();

	    String find_m_id = (String) session.getAttribute("find_m_id"); 
	    String m_pwd = request.getParameter("m_pwd");

	    Member m = new Member();
	    m.setM_id(find_m_id);
	    m.setM_pwd(m_pwd); 

	    boolean result = dao.pwdreset(m);
	    System.out.println(result);
	    
	    System.out.println("id="+find_m_id);
		System.out.println("password="+m_pwd);
		
	    response.setContentType("text/html; charset=utf-8");
	    if(result == true) {
	        // 비밀번호가 성공적으로 변경되었을 때
			forward.setRedirect(false);
			session.removeAttribute("find_m_id");
			out.println("<script>");
			out.println("alert('비밀번호 수정이 성공했습니다.');");
			out.println("location.href='login.com';");
			out.println("</script>");

	    }else {
	    	out.println("<script>");
			out.println("alert('비밀번호 수정이 실패했습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
	    }	    
	    return null;
	}
}
