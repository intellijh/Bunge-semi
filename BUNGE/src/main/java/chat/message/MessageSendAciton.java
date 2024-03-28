package chat.message;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class MessageSendAciton implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return null;
    }
}
