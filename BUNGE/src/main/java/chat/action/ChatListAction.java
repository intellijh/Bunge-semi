package chat.action;

import chat.db.Chat;
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

public class ChatListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        ActionForward forward = new ActionForward();
        if (session.getAttribute("m_id") == null) {
            forward.setRedirect(true);
            forward.setPath("/login.com");
        } else {
            forward.setRedirect(false);
            forward.setPath("/chat/chat.jsp");
        }
        return forward;
    }
}
