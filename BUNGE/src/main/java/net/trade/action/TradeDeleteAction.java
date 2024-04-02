package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.NamingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class TradeDeleteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {

        int num = Integer.parseInt(request.getParameter("id"));

        TradeDAO dao = new TradeDAO();
        boolean usercheck = dao.isBoardWriter(num, request.getParameter("password"));

        if (!usercheck) {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('비밀번호가 다릅니다');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
            return null;
        }

        boolean result = dao.deleteTrade(num);

        if (!result) {
            System.out.println("게시판 삭제 실패");
            ActionForward forward = new ActionForward();
            forward.setRedirect(false);
            request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
            forward.setPath("error/error.jsp");
            return forward;
        } else {
            System.out.println("게시판 삭제 성공");
            // 삭제 성공한 경우, 글 목록 보기 페이지로 리다이렉션
            response.sendRedirect("trade.net");
            return null;
        }
    }
}
