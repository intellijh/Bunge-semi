package common;

import java.io.IOException;

import chat.ChatListLoadAction;
import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import chat.ChatListAction;

@WebServlet("*.com")
public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest request,
                             HttpServletResponse response) throws ServletException, IOException {

        String RequestURI = request.getRequestURI();
        System.out.println("RequestURI = " + RequestURI);

        String contextPath = request.getContextPath();
        System.out.println("contextPath = " + contextPath);

        String command = RequestURI.substring(contextPath.length());
        System.out.println("command = " + command);

        ActionForward forward = null;
        Action action = null;

        switch (command) {
            //로그인
            case "/login.com" :
                action = new loginAction();
                break;
            case "/loginProess.com" :
                action = new loginProessAction();
                break;
            //로그아웃
            case "/logout.com" :
                action = new logoutAction();
                break;
            //게시판에 글 추가
            case "/InfoAdd.com" :
                action = new InfoAddAction();
                break;
            //글쓰기
            case "/Write.com" :
                action = new InfoWriteAction();
                break;
            case "/BoardList.com" :
                action = new BoardListAction();
                break;
            case "/BoardDetail.com" :
                action = new BoardDetailAction();
                break;
            //채팅 페이지 이동
            case "/chat.com":
                action = new ChatListAction();
                break;
            //채팅 리스트 불러오기
            case "/chatLoad.com":
                action = new ChatListLoadAction();
                break;
        } //switch (command)

        forward = action.execute(request, response);

        if (forward != null) {
            if (forward.isRedirect()) {
                response.sendRedirect(forward.getPath());
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
                dispatcher.forward(request, response);
            }
        }//if (forward != null)
    } //doProcess

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doProcess(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doProcess(request, response);
    }
}
