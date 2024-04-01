package net.trade.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletContext;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TradeSubmitAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        ActionForward forward = new ActionForward();

        String realFolder="";

        //webapp아래에 꼭 폴더 생성하세요
        String saveFolder="boardupload";

        int fileSize=5*1024*1024; // 업로드 할 파일의 최대 사이즈 입니다. 5MB

        // 실제 저장 경로를 지정합니다.
        ServletContext sc = request.getServletContext();
        realFolder = sc.getRealPath(saveFolder);
        System.out.println("realFolder= " + realFolder);
        boolean result = false;
        try {
            // 거래 정보 조회
            MultipartRequest multi = new MultipartRequest(
                    request,
                    realFolder,
                    fileSize,
                    "utf-8",
                    new DefaultFileRenamePolicy());

            // BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
            Trade trade = new Trade();
            trade.setTitle(multi.getParameter("title"));
            trade.setCategory(multi.getParameter("category"));
            trade.setQuality(multi.getParameter("quality"));
            trade.setCondition(multi.getParameter("condition"));
            trade.setTradeMethod(multi.getParameter("tradeMethod"));
            trade.setDescription(multi.getParameter("desc"));
            trade.setPassword(multi.getParameter("password"));
            trade.setPrice(Integer.parseInt(multi.getParameter("price")));
            trade.setImageID(multi.getFilesystemName("imageID"));


            TradeDAO tradeDAO = new TradeDAO();
            tradeDAO.insertTrade(trade);
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
