package chat;

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
        String id = request.getParameter("loginId");
        System.out.println(id);

        JsonArray array = new ChatDAO().getChatList(id);
/*
        JsonArray array = new JsonArray();

        JsonObject object1 = new JsonObject();
        object1.addProperty("sellerId", "abc1");
        object1.addProperty("buyerId", "vvg2");
        object1.addProperty("openDate", "2024-03-27 11:57");

        JsonObject object2 = new JsonObject();
        object2.addProperty("sellerId", "abc2");
        object2.addProperty("buyerId", "vvg3");
        object2.addProperty("openDate", "2024-03-27 12:57");

        JsonObject object3 = new JsonObject();
        object3.addProperty("sellerId", "abc3");
        object3.addProperty("buyerId", "vvg4");
        object3.addProperty("openDate", "2024-03-27 13:57");

        array.add(object1);
        array.add(object2);
        array.add(object3);
*/

        JsonElement element = new Gson().toJsonTree(array);
        JsonObject object = new JsonObject();
        object.add("chat", element);

        PrintWriter out = response.getWriter();
        out.print(object);
        System.out.println(object);

        return null;
    }
}
