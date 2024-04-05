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
        String loginId = (String) session.getAttribute("m_id");
        if (loginId == null) {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("   alert('로그인 후 이용해주세요.');");
            out.println("   location.href = 'login.com';");
            out.println("</script>");
            out.close();
            return null;
        }

        String sellerId = request.getParameter("sellerId");
        if (sellerId.equals(loginId)) {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("   alert('본인과 대화할 수 없습니다.');");
            out.println("   history.back();");
            out.println("</script>");
            out.close();
            return null;
        }

        Chat chat = new Chat();
        chat.setSellerId(request.getParameter("sellerId"));
        chat.setBuyerId(loginId);
        chat.setTrade_id(Long.parseLong(request.getParameter("tradeId")));

        long tradeId = chat.getTrade_id();
        String buyerId = chat.getBuyerId();
        System.out.println("create sellerId = " + sellerId);
        System.out.println("create buyerId = " + buyerId);
        System.out.println("create tradeId = " + tradeId);

        ChatDAO dao = new ChatDAO();
        long chatId = dao.hasChatExist(chat);
        System.out.println("create chatId = " + chatId);
        chatId = (chatId == 0) ? dao.createChat(chat) : chatId;

        chat.setChatId(chatId);
        session.setAttribute("chatId", chatId);

        ActionForward forward = new ActionForward();
        forward.setRedirect(true);
        forward.setPath("/chat.com");
        return forward;
    }
}
