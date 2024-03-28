package common;

import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
	        case "/join.com" :
	        	action = new joinAction();
	        	break;
	       case "/joinProcess.com" :
	    	   action = new joinProessAction();
	    	   break;
	    	   //아이디 중복 검사
	       case "/idcheck.com" :
	    	   action = new idcheckAction();
	    	   break;
	    	   //닉네임 중복 검사
	       case"/nickcheck.com" :
	    	   action = new nickcheckAction();
	    	   break;
	    	   //아이디 찾기
	       case "/findid.com" :
	    	   action = new findidAction();
	    	   break;
	       case"/findidProcess.com" :
	    	   action = new findidProcessAction();
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
