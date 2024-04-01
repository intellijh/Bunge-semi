package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TradeUpdateCheckAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        try {
            // 요청에서 거래 ID와 비밀번호 가져오기
            int tradeID = Integer.parseInt(request.getParameter("tradeID"));
            String password = request.getParameter("password");

            // TradeDAO를 사용하여 비밀번호 확인
            TradeDAO tradeDAO = new TradeDAO();
            if (tradeDAO.passwordCheck(tradeID, password)) {
                // 비밀번호가 일치하는 경우 해당 거래 정보를 얻어와서 업데이트 페이지로 이동
                Trade trade = tradeDAO.selectOneTradeById(tradeID);
                tradeDAO.close();

                // 조회된 거래 정보를 request에 설정
                request.setAttribute("trade", trade);

                // 업데이트 페이지로 포워딩
                forward.setPath("update_check.jsp");
                forward.setRedirect(false);
            } else {
                // 비밀번호가 일치하지 않는 경우 에러 메시지 출력 후 이전 페이지로 이동
                tradeDAO.close();
                forward.setPath("error.jsp");
                forward.setRedirect(false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 에러 페이지로 이동하도록 설정
            forward.setPath("error.jsp");
            forward.setRedirect(false);
        }

        return forward;
    }
}
