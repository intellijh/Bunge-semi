package chat.action;

import chat.db.Message;
import chat.db.MessageDao;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class MessageLoadAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int chatId = Integer.parseInt(request.getParameter("chatId"));

        List<Message> list = new MessageDao().getMessage(chatId);

        ActionForward forward = new ActionForward();
        if (list == null) {
            request.setAttribute("message", "메세지 불러오기에 실패했습니다.");
            forward.setPath("error/error.jsp");
            return forward;
        }

        System.out.println("테스트");
        Gson gson = new Gson();
        String json = gson.toJson(list);
        System.out.println("json = " + json);
        PrintWriter out = response.getWriter();
        out.print(json);

        return null;
    }
}
