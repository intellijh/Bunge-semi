package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.trade.db.TradeDAO;
import net.trade.db.Trade;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class TradeBoardAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {

        // TradeDAO 객체 생성
        TradeDAO tradeDAO = new TradeDAO();

        // 키워드 및 검색 결과를 저장할 변수 선언
        ArrayList<Trade> tradeList = null;
        String keyword = request.getParameter("keyword");
        String mode = request.getParameter("mode"); // 검색 모드 가져오기

        try {
            // 키워드가 없는 경우 모든 거래 조회
            if (keyword == null ) {
                tradeList = tradeDAO.getTradeList();
            } else {
                // 키워드 존재 시 검색결과 조회
                if (mode != null && mode.equals("제목")) {
                    tradeList = tradeDAO.searchTradeByTitle(keyword);
                } else if (mode != null && mode.equals("내용")) {
                    tradeList = tradeDAO.searchTradeByDesc(keyword);
                }
            }

            // DAO 연결 종료
            tradeDAO.close();

            // 검색 결과를 request 속성에 저장
            request.setAttribute("tradeList", tradeList);

            // 적절한 페이지로 이동하기 위한 ActionForward 객체 생성
            ActionForward forward = new ActionForward();
            forward.setRedirect(false);
            forward.setPath("trade/board/newtradeindex.jsp");
            return forward;
        } catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
            throw e;
        } finally {
            // 반드시 DAO 연결 종료
            if (tradeDAO != null) {
                tradeDAO.close();
            }
        }
    }
}
