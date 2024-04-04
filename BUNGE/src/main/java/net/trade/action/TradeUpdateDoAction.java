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
import java.io.File;

import javax.naming.NamingException;
import java.io.IOException;

public class TradeUpdateDoAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();

        String realFolder = "";
        String saveFolder = "image";

        ServletContext sc = request.getServletContext();
        realFolder = sc.getRealPath(saveFolder);
        System.out.println("realFolder= " + realFolder);
        // 파일 업로드를 위한 임시 저장 경로


        int fileSize = 5 * 1024 * 1024; // 업로드 할 파일의 최대 사이즈 입니다. 5MB

        // 실제 저장 경로를 지정합니다.


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

            trade.setTitle(multi.getParameter("title"));
            trade.setTradeID(Integer.parseInt(multi.getParameter("id")));
            trade.setCategory(multi.getParameter("category"));
            trade.setQuality(multi.getParameter("quality"));
            trade.setCondition(multi.getParameter("condition"));
            trade.setTradeMethod(multi.getParameter("tradeMethod"));
            trade.setDescription(multi.getParameter("desc"));
            String priceParameter = multi.getParameter("price");
            trade.setImageID(multi.getParameter("imageID"));
            trade.setPrice(Integer.parseInt(priceParameter));

            String existingImage = request.getParameter("existingImage");

            if (existingImage == null || existingImage.isEmpty() ) {
                trade.setImageID(multi.getFilesystemName("imageID"));
            } else {
                trade.setImageID(existingImage);
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
