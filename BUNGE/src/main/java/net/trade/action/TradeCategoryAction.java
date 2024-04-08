package net.trade.action;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import common.action.Action;
import common.action.ActionForward;
import net.trade.db.Trade;
import net.trade.db.TradeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import com.google.gson.Gson;

import javax.naming.NamingException;

public class TradeCategoryAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NamingException {


        String category = request.getParameter("category");

        TradeDAO tradeDAO = new TradeDAO();
        ArrayList<Trade> tradeList = null; // 변수 초기화

        try {
            // 카테고리에 따른 거래 조회
            tradeList = tradeDAO.searchTradeByCategory(category);

            tradeDAO.close();

            JsonObject object = new JsonObject();
            JsonElement je = new Gson().toJsonTree(tradeList);
            object.add("tradeList", je);

            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(object);
            System.out.println(object.toString());
            return null;




        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 에러 응답을 JSON 형태로 전송합니다.
            response.getWriter().write("{\"error\": \"오류가 발생했습니다.\"}");
        }

        return null; // ActionForward를 반환할 필요가 없으므로 null을 반환합니다.
    }

}
