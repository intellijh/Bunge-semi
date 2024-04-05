package chat.action;

import chat.db.Chat;
import chat.db.ChatDAO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ChatListLoadAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("m_id");
        System.out.println(id);

        Long chatId = (Long) session.getAttribute("chatId");
        System.out.println("ListLoadAction chatId = " + chatId);
        if (chatId != null) {
            if (chatId > 0) {
                session.setAttribute("chatId", 0L);
            }
        }

        List<Chat> list = new ChatDAO().getChatList(id);
        String data = new Gson().toJson(list);
        System.out.println("chatListLoadData = " + data);

        PrintWriter out = response.getWriter();
        out.print(data);

        return null;
    }
}
