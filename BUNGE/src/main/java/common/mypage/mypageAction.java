package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import common.action.Action;
import common.action.ActionForward;
import common.db.Member;
import common.db.MemberDAO;
import common.db.Memberimg;
import common.db.MypageDAO;
import common.db.mypage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
;

public class mypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		String m_id = (String) session.getAttribute("m_id"); 
		
		if(m_id != null) {
			forward.setRedirect(false); 
			MypageDAO mypage = mypage.mypage_info(m_id);
			forward.setPath("mypage/mypage.jsp");
			request.setAttribute("pageinfo", mypage);
			return forward;
		}else {
			response.setContentType("text/html; charset=utf-8");
			String message= "로그인이후 이용 가능합니다.";
			out.print("<script>");
			out.print("alert('"+message+"');");
			out.print("location.href='login.com';");
			out.print("</script>");
			out.close();
		}
		return null;
	}

}
