package common;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class findpwdProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 MemberDAO mdao = new MemberDAO(); 
		    ActionForward forward = new ActionForward(); 
		    PrintWriter out = response.getWriter(); 

		    // 요청 파라미터에서 회원 아이디, 이름, 이메일을 받아옴
		    String m_id = request.getParameter("m_id");
		    String m_name = request.getParameter("m_name");
		    String m_email = request.getParameter("m_email");

		  
		    boolean m_pwd = mdao.findpwd(m_id, m_name, m_email);
		    System.out.println("결과 : " + m_pwd);

		    if (m_pwd) { // 비밀번호 찾기가 성공한 경우
		        forward.setRedirect(false); 
		        request.getSession().setAttribute("m_pwd", m_pwd);
		        forward.setPath("member/pwdreset.jsp");
		        String message = "비밀번호 찾기 성공하셨습니다.";
		        out.print("<script>"); 
		        out.print("alert('" + message + "');"); 
		        out.print("</script>"); 
		        return forward; 
		    } else { // 비밀번호 찾기가 실패한 경우
		        response.setContentType("text/html;charset=utf-8"); 
		        String message = "아이디, 이름, 비밀번호가 일치하지 않습니다.";
		        out.print("<script>");
		        out.print("alert('" + message + "');");
		        out.print("location.href='findpwd.com';"); 
		        out.print("</script>"); 
		        out.close(); 
		    }
		    return null; // 반환할 액션 포워드가 없음 (null 반환)
		}

}
