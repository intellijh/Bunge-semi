package chat.action;

import chat.db.ChatDAO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.NamingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class ChatDeleteAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NamingException {
        Long chatId = Long.valueOf(request.getParameter("chatId"));
        System.out.println("ChatDeleteAction chatId = " + chatId);
        String loginId = (String) request.getSession().getAttribute("m_id");
        String sellerId = (String) request.getParameter("sellerId");

        int result = new ChatDAO().delete(chatId, loginId, sellerId);
        if (result == 0) {
            ActionForward forward = new ActionForward();
            System.out.println("채팅 삭제 실패");
            request.setAttribute("message", "채팅 삭제를 실패했습니다.");
            forward.setPath("error/error.jsp");
            return forward;
        }

        PrintWriter out = response.getWriter();
        out.print(result);
        return null;
    }
}
