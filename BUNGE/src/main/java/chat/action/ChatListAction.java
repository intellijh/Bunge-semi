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

import java.io.IOException;

public class ChatListAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("id", "A1234"); //나중에 session으로 사용자 확인
        ActionForward forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/chat/chat.jsp");
        return forward;
    }
}
