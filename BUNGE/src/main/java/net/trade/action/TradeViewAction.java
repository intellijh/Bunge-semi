package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TradeViewAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        try {
            // 거래 정보 조회
            int tradeID = Integer.parseInt(request.getParameter("tradeID"));
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

        return forward;
    }
}
