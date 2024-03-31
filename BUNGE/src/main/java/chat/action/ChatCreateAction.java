package chat.action;

import chat.db.Chat;
import chat.db.ChatDAO;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class ChatCreateAction implements Action {
    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Chat chat = new Chat();
        chat.setSellerId(request.getParameter("sellerId"));
        chat.setBuyerId((String) session.getAttribute("m_id"));
        chat.setTrade_id(Long.parseLong(request.getParameter("tradeId")));

        ChatDAO dao = new ChatDAO();
        long chatId = dao.hasChatExist(chat);
        if (chatId > 0) {
            //채팅방 존재할 때 해당 채팅방 입장 로직 구현 필요
        } else {
            int result = dao.createChat(chat);
            if (result == 0) {
                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("   alert('로그인 후 이용해주세요.');");
                out.println("   location.href = 'login.com';");
                out.println("</script>");
                out.close();
                return null;
            }
        }

        ActionForward forward = new ActionForward();
        forward.setRedirect(true);
        forward.setPath("/chat.com");
        return forward;
    }
}
