package chat.action;

import chat.db.Message;
import chat.db.MessageDao;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class MessageStoreAciton implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int chatId = Integer.parseInt(request.getParameter("chatId"));
        String memberId = (String) request.getSession().getAttribute("m_id");
        String content = request.getParameter("content");

        Message message = new Message(chatId, memberId, content);
        int result = new MessageDao().insertText(message);

        if (result == 1) {
            PrintWriter out = response.getWriter();
            out.print(result);
        }
        return null;
    }
}
