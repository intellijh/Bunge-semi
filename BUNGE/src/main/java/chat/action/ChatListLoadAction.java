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

import java.io.IOException;
import java.io.PrintWriter;

public class ChatListLoadAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = (String) request.getSession().getAttribute("m_id");
        System.out.println(id);

        JsonArray array = new ChatDAO().getChatList(id);
        JsonElement element = new Gson().toJsonTree(array);
        JsonObject object = new JsonObject();
        object.add("chatList", element);

        PrintWriter out = response.getWriter();
        out.print(object);
        System.out.println(object);

        return null;
    }
}
