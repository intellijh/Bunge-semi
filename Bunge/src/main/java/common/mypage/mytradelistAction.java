package common.mypage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import common.action.Action;
import common.action.ActionForward;
import common.db.MypageDAO;
import common.db.Mytrade;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class mytradelistAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NamingException {
			ActionForward forward = new ActionForward();
			MypageDAO mypagedao = new MypageDAO();
			List<Mytrade> tradelist = new ArrayList<>();
			PrintWriter out = response.getWriter();
			HttpSession session =request.getSession();
			
			String m_id = (String)session.getAttribute("m_id");
			
			if(m_id != null) {
				
				tradelist = mypagedao.gettradeList(m_id);
				request.setAttribute("tradelist", tradelist);
				forward.setRedirect(false);
				forward.setPath("mypage/tradelike.jsp");
			}else {
				response.setContentType("text/html; charset=utf-8");
				String message = "로그인 후 이용 가능합니다.";
				out.print("<script>");
				out.print("alert('" + message + "');");
				out.print("location.href='login.com';");
				out.print("</script>");
				out.close();
			}
		return forward;
	}

}
