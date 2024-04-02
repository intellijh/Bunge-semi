package chat.db;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import oracle.sql.TIMESTAMP;

import java.io.IOException;

public class Message {

    private long chatId;
    private String memberId;
    private String content;
    private String sendDate;
    private char contentType;

    public Message(long chatId, String memberId, String content) {
        this.chatId = chatId;
        this.memberId = memberId;
        this.content = content;
    }

    public Message(long chatId, String memberId, String content, String sendDate, char contentType) {
        this.chatId = chatId;
        this.memberId = memberId;
        this.content = content;
        this.sendDate = sendDate.substring(0, 16);
        this.contentType = contentType;
    }

    public long getChatId() {
        return chatId;
    }

    public String getMemberId() {
        return memberId;
    }

    public String getContent() {
        return content;
    }

    public String getSendDate() {
        return sendDate;
    }

    public char getContentType() {
        return contentType;
    }
}
