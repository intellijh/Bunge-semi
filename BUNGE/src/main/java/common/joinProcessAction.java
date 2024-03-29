package common;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import common.action.Action;
import common.action.ActionForward;
import common.db.Member;
import common.db.MemberDAO;
import common.db.Memberimg;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class joinProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String m_id = request.getParameter("m_id");
		String m_pwd = request.getParameter("m_pwd");
		String m_name= request.getParameter("m_name");
		String m_nick = request.getParameter("m_nick");
		String m_gerder = request.getParameter("m_gerder");
		String m_zipcode = request.getParameter("m_zipcode");
		String m_addr1 = request.getParameter("m_addr1");
		String m_addr2 = request.getParameter("m_addr2");
		String m_phone = request.getParameter("m_phone");
		String m_email = request.getParameter("m_email");
		Date m_birthdate = Date.valueOf(request.getParameter("m_birthdate"));
		
		Member m = new Member();
		Memberimg mimg = new Memberimg();
		m.setM_id(m_id); m.setM_pwd(m_pwd); m.setM_name(m_name); m.setM_nick(m_nick);
		m.setM_gender(m_gerder); m.setM_zipcode(m_zipcode); m.setM_addr1(m_addr1);
		m.setM_addr2(m_addr2);m.setM_phone(m_phone); m.setM_email(m_email);
		m.setM_birthdate(m_birthdate);
		
		MemberDAO mdao = new MemberDAO();
		int result = mdao.joininsert(m);
		int result2 = mdao.imginsert(m,mimg);
		
		if(result == 0 ) { // 가입 실패
			System.out.println("회원가입에 실패했습니다.");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("mesage","회원가입 실패입니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('회원 가입을 축하합니다.');");
		out.print("location.href='login.com';");
		out.print("</script>");
		out.close();
		return null;
	}

}
