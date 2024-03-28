CREATE TABLE chat
(
    chat_id     NUMBER(10) PRIMARY KEY,
    seller_id   VARCHAR2(20) NOT NULL,
    buyer_id    VARCHAR2(20) NOT NULL,
    trade_id    NUMBER       NOT NULL,
    open_date   TIMESTAMP    NOT NULL,
    update_date TIMESTAMP,
    CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES member (m_id),
    CONSTRAINT fk_buyer_id FOREIGN KEY (buyer_id) REFERENCES member (m_id),
    CONSTRAINT fk_trade_id FOREIGN KEY (trade_id) REFERENCES trade (tradeid)
);

/* 적용 필요 */
CREATE SEQUENCE chat_seq
    INCREMENT BY 1
    START WITH 1;

CREATE TABLE chat_message
(
    message_id   NUMBER(20) PRIMARY KEY,
    chat_id      NUMBER(10)    NOT NULL,
    member_id    VARCHAR2(20)  NOT NULL,
    content      VARCHAR2(200) NOT NULL,
    send_date    TIMESTAMP     NOT NULL,
    content_type CHAR(1)       NOT NULL,
    CONSTRAINT fk_chat_id FOREIGN KEY (chat_id) REFERENCES chat (chat_id),
    CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES member (m_id)
);

CREATE TABLE notification
(
    notify_id   NUMBER(20) PRIMARY KEY,
    message_id  NUMBER(20)   NOT NULL,
    receiver_id VARCHAR2(20) NOT NULL,
    sender_id   VARCHAR2(20) NOT NULL,
    content     VARCHAR2(20) NOT NULL,
    CREATE_DATE TIMESTAMP    NOT NULL,
    STATUS      NUMBER(1)    NOT NULL,
    CONSTRAINT fk_message_id FOREIGN KEY (message_id) REFERENCES chat_message (message_id),
    CONSTRAINT fk_receiver_id FOREIGN KEY (receiver_id) REFERENCES member (m_id),
    CONSTRAINT fk_sender_id FOREIGN KEY (sender_id) REFERENCES member (m_id)
);

INSERT INTO chat
VALUES (1, 'A1234', 'B1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (2, 'A1234', 'C1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (3, 'B1234', 'C1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (4, 'C1234', 'A1234', 1, SYSDATE, null);
