package chat;

import chat.configurator.ChatConfigurator;
import chat.db.Chat;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint(value = "/chat", configurator = ChatConfigurator.class)
public class ChatEndPoint {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

    private HttpSession hSession;

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        this.hSession = (HttpSession) config.getUserProperties().get("hSession"); // 넣어놨던 HTTP Session을 꺼낸다.
        clients.add(session);
        System.out.println("ChatEndPoint onOpne() id: " + hSession.getAttribute("m_id")); // 세션 안의 키를 통해 값을 꺼낸다.
        System.out.println("ChatEndPoint onOpne() session: " + session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println(message);

        synchronized(clients) {
            String loginID = (String) hSession.getAttribute("m_id");
            System.out.println("loginID = " + loginID);

            try {
                for (Session client : clients) {
                    LocalTime time = LocalTime.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
                    String nowTime = time.format(formatter);

                    JsonObject data = new JsonObject();
                    data.addProperty("sender", loginID);
                    data.addProperty("msg", message);
                    data.addProperty("time", nowTime);

                    JsonArray arr = new JsonArray();
                    arr.add(data);

                    if (!client.equals(session)) {
                        client.getBasicRemote().sendText(arr.toString());
                    }
                }
            } catch (Exception e) {
                System.out.println("Exception in: " + e.getStackTrace()[0]);
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
    }
}
