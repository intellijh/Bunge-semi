DROP TABLE chat purge;
DROP TABLE chat_message purge;

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

-- 채팅 시퀀스 삭제
DROP SEQUENCE chat_seq;

-- 채팅 시퀀스 생성
CREATE SEQUENCE chat_seq
    INCREMENT BY 1
    START WITH 1;

-- 시퀀스 삭제
DROP SEQUENCE message_seq;

-- 메세지 시퀀스 생성 (적용 필요)
CREATE SEQUENCE message_seq
    INCREMENT BY 1
    START WITH 1;

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

-- 채팅 조회 쿼리
WITH a AS (SELECT c.chat_id,
                  c.seller_id,
                  c.buyer_id,
                  c.update_date,
                  m.send_date,
                  CASE WHEN m.chat_id IS NULL THEN NULL ELSE m.content END AS content
           FROM chat c
                    LEFT JOIN chat_message m ON c.chat_id = m.chat_id
           WHERE ? IN (c.seller_id, c.buyer_id))
SELECT *
FROM a
WHERE (send_date, chat_id) IN (SELECT MAX(a.send_date), chat_id
                               FROM a
                               GROUP BY chat_id)
   or content IS NULL;