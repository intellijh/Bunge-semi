package net.trade.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import javax.naming.NamingException;
import java.io.IOException;

public class TradeUpdateDoAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        String realFolder = "/Users/songjaehyeog/Desktop/Bunge/BUNGE/src/main/webapp/trade/board/image";

        // 파일 업로드를 위한 임시 저장 경로
        String saveFolder = "image";

        int fileSize = 5 * 1024 * 1024; // 업로드 할 파일의 최대 사이즈 입니다. 5MB

        // 실제 저장 경로를 지정합니다.
        ServletContext sc = request.getServletContext();
        realFolder = sc.getRealPath(saveFolder);
        System.out.println("realFolder= " + realFolder);

        try {

            // 거래 정보 조회
            MultipartRequest multi = new MultipartRequest(
                    request,
                    realFolder,
                    fileSize,
                    "utf-8",
                    new DefaultFileRenamePolicy());

            // 수정된 거래 정보를 받아옴
            Trade trade = new Trade();
            trade.setTitle(request.getParameter("title"));
            trade.setCategory(request.getParameter("category"));
            trade.setQuality(request.getParameter("quality"));
            trade.setCondition(request.getParameter("condition"));
            trade.setTradeMethod(request.getParameter("tradeMethod"));
            trade.setDescription(request.getParameter("desc"));
            trade.setImageID(request.getParameter("imageID"));
            String priceParameter = request.getParameter("price");
            if (priceParameter != null && !priceParameter.isEmpty()) {
                trade.setPrice(Integer.parseInt(priceParameter));
            } else {
                // 가격이 입력되지 않은 경우에 대한 처리
            }


            // TradeDAO를 통해 거래 정보 업데이트
            TradeDAO tradeDAO = new TradeDAO();
            tradeDAO.updateTrade(trade);
            tradeDAO.close();

            // 수정이 성공하면 리스트 페이지로 리다이렉트
            forward.setRedirect(true);
            forward.setPath("/trade.net");
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 에러 페이지로 이동하도록 설정
            forward.setPath("error/error.jsp");
            forward.setRedirect(false);
        }
        return forward;
    }
}
