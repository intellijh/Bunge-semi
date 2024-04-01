package net.trade.action;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class TradeWriteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("trade/board/write.jsp");
        return forward;
    }
}
