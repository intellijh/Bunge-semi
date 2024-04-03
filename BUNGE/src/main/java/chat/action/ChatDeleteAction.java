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
        String chatId = request.getParameter("chatId");
        System.out.println("ChatDeleteAction chatId = " + chatId);
        int result = new ChatDAO().delete(chatId);

        if (result == 0) {
            ActionForward forward = new ActionForward();
            System.out.println("채팅 삭제 실패");
            request.setAttribute("message", "채팅 삭제를 실패했습니다.");
            forward.setPath("error/error.jsp");
            return forward;
        }

//        JsonObject data = new JsonObject();
//        data.addProperty("result", true);
        PrintWriter out = response.getWriter();
        out.print(result);

        return null;
    }
}
