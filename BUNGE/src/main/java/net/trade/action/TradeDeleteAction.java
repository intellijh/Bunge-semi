package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TradeDeleteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        try {
            // 요청에서 거래 ID와 비밀번호 가져오기
            int tradeID = Integer.parseInt(request.getParameter("tradeID"));
            String password = request.getParameter("password");

            // TradeDAO를 사용하여 비밀번호 확인 및 거래 삭제
            TradeDAO tradeDAO = new TradeDAO();
            if (tradeDAO.passwordCheck(tradeID, password)) {
                // 비밀번호가 일치하는 경우 해당 거래 삭제
                tradeDAO.deleteTrade(tradeID);
                tradeDAO.close();

                // 삭제 완료 메시지 출력 후 이전 페이지로 이동
                forward.setPath("trade.net"); // 이동할 페이지 지정
                forward.setRedirect(true); // 리다이렉트 설정
            } else {
                // 비밀번호가 일치하지 않는 경우 에러 메시지 출력 후 이전 페이지로 이동
                tradeDAO.close();
                // 에러 메시지 출력 및 이전 페이지로 리다이렉트
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
