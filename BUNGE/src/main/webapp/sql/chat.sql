CREATE TABLE chat
(
    chat_id     NUMBER(10) PRIMARY KEY,
    seller_id   VARCHAR2(20),
    buyer_id    VARCHAR2(20),
    trade_id    NUMBER    NOT NULL,
    open_date   TIMESTAMP NOT NULL,
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

-- 더미데이터
INSERT INTO chat
VALUES (1, 'A1234', 'B1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (2, 'A1234', 'C1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (3, 'B1234', 'C1234', 1, SYSDATE, null);
INSERT INTO chat
VALUES (4, 'C1234', 'A1234', 1, SYSDATE, null);

-- 채팅 중복 확인
SELECT *
FROM chat
WHERE seller_id = 'B1234'
  AND buyer_id = 'A1234'
  AND trade_id = 1;

-- 채팅 id max값 추출
SELECT MAX(NVL(chat_id, 0)) + 1
FROM chat;

-- 채팅방 생성
INSERT INTO chat
VALUES (7, 'C1234', 'A1234', 6, SYSTIMESTAMP, SYSTIMESTAMP);

-- 메세지 시퀀스 생성 (적용 필요)
CREATE SEQUENCE message_seq
    INCREMENT BY 1
    START WITH 1;

-- 채팅 메세지 삽입
INSERT INTO chat_message
VALUES (1, 1, 'A1234', '하이', SYSTIMESTAMP, 'N');

-- 채팅 정보 (최근 메세지 포함) 가져오기
SELECT c.chat_id, c.seller_id, c.buyer_id, c.update_date, m.content
FROM chat c
         JOIN chat_message m ON c.chat_id = m.chat_id
WHERE (c.seller_id = ? OR c.buyer_id = ?)
  AND m.send_date = (SELECT MAX(send_date)
                     FROM chat_message
                     WHERE chat_id = c.chat_id)
ORDER BY c.update_date DESC;

SELECT c.chat_id,
       c.seller_id,
       c.buyer_id,
       c.update_date,
       CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
FROM chat c
         LEFT JOIN chat_message m ON c.chat_id = m.chat_id
WHERE (c.seller_id = ? OR c.buyer_id = ?)
  AND m.send_date = (SELECT MAX(send_date)
                     FROM chat_message
                     WHERE chat_id = c.chat_id)
ORDER BY c.update_date DESC;

SELECT chat_id,
       seller_id,
       buyer_id,
       update_date,
       (SELECT content
        FROM (SELECT ROWNUM, chat_id, member_id, content, send_date
              FROM (SELECT *
                    FROM chat_message
                    ORDER BY send_date DESC))
        WHERE ROWNUM = 1)
FROM chat
WHERE seller_id = ?
   OR buyer_id = ?
    AND chat_id
ORDER BY update_date DESC;


SELECT *
FROM (SELECT ROWNUM, chat_id, member_id, content, send_date
      FROM (SELECT *
            FROM chat_message
            WHERE chat_id = ?
            ORDER BY send_date DESC))
WHERE ROWNUM = 1;


SELECT c.chat_id,
       c.seller_id,
       c.buyer_id,
       c.update_date,
       CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
FROM chat c
         LEFT JOIN chat_message m ON c.chat_id = m.chat_id
WHERE ? IN (c.seller_id, c.BUYER_ID);

SELECT update_date, content
FROM (SELECT c.chat_id,
             c.seller_id,
             c.buyer_id,
             c.update_date,
             CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
      FROM chat c
               LEFT JOIN chat_message m ON c.chat_id = m.chat_id
      WHERE ? IN (c.seller_id, c.BUYER_ID)) b
WHERE update_date IN (SELECT MAX(b.update_date)
                      FROM b);

WITH b AS (SELECT c.chat_id,
                  c.seller_id,
                  c.buyer_id,
                  c.update_date,
                  m.send_date,
                  CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
           FROM chat c
                    LEFT JOIN chat_message m ON c.chat_id = m.chat_id
           WHERE ? IN (c.seller_id, c.BUYER_ID))
SELECT send_date, content, chat_id
FROM b
WHERE (send_date, chat_id) IN (SELECT NVL(MAX(b.send_date), MAX(update_date)), chat_id
                               FROM b
                               GROUP BY chat_id);

WITH b AS (SELECT c.chat_id,
                  c.seller_id,
                  c.buyer_id,
                  c.update_date,
                  m.send_date,
                  CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
           FROM chat c
                    LEFT JOIN chat_message m ON c.chat_id = m.chat_id
           WHERE ? IN (c.seller_id, c.BUYER_ID))
SELECT NVL(MAX(b.send_date), MAX(update_date)), chat_id
FROM b
GROUP BY chat_id;


SELECT NVL(MAX(update_date), '2024-04-05'), content
FROM (SELECT c.chat_id,
             c.seller_id,
             c.buyer_id,
             c.update_date,
             CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
      FROM chat c
               LEFT JOIN chat_message m ON c.chat_id = m.chat_id
      WHERE ? IN (c.seller_id, c.BUYER_ID)
      ORDER BY c.update_date DESC)
GROUP BY chat_id, content;

-- 채팅 조회 쿼리 (문제)
SELECT c.chat_id,
       c.seller_id,
       c.buyer_id,
       c.update_date,
       m.content
FROM chat c
         LEFT OUTER JOIN chat_message m
                         ON c.chat_id = m.chat_id
WHERE (? IN (c.seller_id, c.buyer_id)
    AND m.send_date = (SELECT MAX(mm.send_date)
                       FROM chat_message mm
                       WHERE mm.chat_id = c.chat_id)
    )
   OR m.chat_id IS NULL;

SELECT c.chat_id,
       c.seller_id,
       c.buyer_id,
       c.update_date,
       m.content
FROM chat c,
     chat_message m
WHERE (c.chat_id = m.chat_id
    AND ? IN (c.seller_id, c.buyer_id)
    AND m.send_date = (SELECT MAX(mm.send_date)
                       FROM chat_message mm
                       WHERE mm.chat_id = c.chat_id)
          );
SELECT c.chat_id,
       c.seller_id,
       c.buyer_id,
       c.update_date,
       m.content
FROM chat c
         LEFT OUTER JOIN chat_message m
                         ON c.chat_id = m.chat_id
WHERE m.chat_id IS NULL;


-- 채팅 조회 쿼리
WITH b AS (SELECT c.chat_id,
                  c.seller_id,
                  c.buyer_id,
                  c.update_date,
                  m.send_date,
                  CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
           FROM chat c
                    LEFT JOIN chat_message m ON c.chat_id = m.chat_id
           WHERE 'A1234' IN (c.seller_id, c.BUYER_ID))
SELECT *
FROM b
WHERE (send_date, chat_id) IN (SELECT MAX(b.send_date), chat_id
                               FROM b
                               GROUP BY chat_id)
   or content is null;