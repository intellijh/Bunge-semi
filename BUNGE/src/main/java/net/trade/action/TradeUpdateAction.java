package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.NamingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class TradeUpdateAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {
        // 요청으로부터 필요한 파라미터들을 추출합니다.
        int num = Integer.parseInt(request.getParameter("id"));

        // TradeDAO 객체를 생성하여 데이터베이스에 업데이트를 요청합니다.
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

        ActionForward forward = new ActionForward();

        try {
            // 거래 정보 조회
            int tradeID = Integer.parseInt(request.getParameter("id"));
            TradeDAO tradeDAO = new TradeDAO();
            Trade trade = tradeDAO.selectOneTradeById(tradeID);
            tradeDAO.close();

            // 조회된 거래 정보를 request에 설정
            request.setAttribute("trade", trade);

            forward.setPath("trade/board/view.jsp");
            forward.setRedirect(false);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 에러 페이지로 이동하도록 설정
            forward.setPath("error/error.jsp");
            forward.setRedirect(false);
        }

        forward.setRedirect(false);
        forward.setPath("/trade/board/update.jsp");
        return forward;


    }
}