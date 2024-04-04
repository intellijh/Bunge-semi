package chat.db;

import java.sql.Timestamp;

public class Chat {

    private long chatId;
    private String sellerId;
    private String buyerId;
    private long trade_id;
    private String openDate;
    private String updateDate;
    private String latestContent;

    public Chat() {
    }

    public Chat(String buyerId, long trade_id) {
        this.buyerId = buyerId;
        this.trade_id = trade_id;
    }

    public long getChatId() {
        return chatId;
    }

    public void setChatId(long chatId) {
        this.chatId = chatId;
    }

    public String getSellerId() {
        return sellerId;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }

    public String getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }

    public long getTrade_id() {
        return trade_id;
    }

    public void setTrade_id(long trade_id) {
        this.trade_id = trade_id;
    }

    public String getOpenDate() {
        return openDate;
    }

    public void setOpenDate(String openDate) {
        this.openDate = openDate.substring(0, 16);
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate.substring(0, 16);
    }

    public String getLatestContent() {
        return latestContent;
    }

    public void setLatestContent(String latestContent) {
        this.latestContent = latestContent;
    }
}
