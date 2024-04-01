package net.trade.action;

import common.action.Action;
import common.action.ActionForward;
import common.db.Member;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class TradeSubmitAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        try {
            HttpSession session = request.getSession();
            Member member = (Member) session.getAttribute("member");
            if (member == null) {
                // 로그인되어 있지 않으면 로그인 페이지로 이동
                forward.setPath("login.jsp");
                forward.setRedirect(true);
                return forward;
            }

            // 거래 정보 받아오기
            String title = request.getParameter("title");
            String description = request.getParameter("desc");
            String sellerID = member.getM_id();
            String category = request.getParameter("categoryID");
            String quality = request.getParameter("quality");
            String condition = request.getParameter("condition");
            String tradeMethod = request.getParameter("tradeMethod");

            // 이미지 업로드 및 경로 설정
            String imageID = uploadImage(request);

            // Trade 객체 생성 및 정보 설정
            Trade trade = new Trade();
            trade.setTitle(title);
            trade.setDescription(description);
            trade.setSellerID(sellerID);
            trade.setCategory(category);
            trade.setQuality(quality);
            trade.setCondition(condition);
            trade.setTradeMethod(tradeMethod);
            trade.setImageID(imageID);

            // TradeDAO를 사용하여 거래 정보 DB에 저장
            TradeDAO tradeDAO = new TradeDAO();
            int tradeID = tradeDAO.insertTrade(trade); // 새로 삽입된 거래의 ID 반환
            trade.setTradeID(tradeID);
            tradeDAO.close();

            // 업로드 성공 시 메인 페이지로 이동
            forward.setPath("main.jsp");
            forward.setRedirect(true);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 에러 페이지로 이동하도록 설정
            forward.setPath("error.jsp");
            forward.setRedirect(false);
        }

        return forward;
    }

    // 이미지 업로드 및 경로 설정 메서드
    private String uploadImage(HttpServletRequest request) {
        // 이미지 업로드 및 경로 설정 로직을 구현해야 함
        // 여기에서는 단순히 고정된 경로를 반환하도록 구현함
        return "trade/board/image/default_image.jpg"; // 임시로 기본 이미지 경로를 반환
    }
}
