1) 테이블 생성

CREATE TABLE comment_reply(
    crno INT NOT NULL AUTO_INCREMENT,
    cdate DATETIME NOT NULL,
    content VARCHAR(200) NOT NULL,
    email VARCHAR(30) NOT NULL,
    cno INT NOT NULL, 
    rname VARCHAR(10) NOT NULL,
    passwd VARCHAR(10) NOT NULL,
    PRIMARY KEY (crno),
    FOREIGN KEY (cno) REFERENCES comment(cno) ON DELETE CASCADE
);     


2) 테이블 삭제
 
DROP TABLE comment_reply;

3) 댓글 등록

INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "첫 번째 댓글의 2번째 답글입니다.", "xotnekzz@naver.com", 3, "왕눈이", 1234);
  
INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "두 번째 댓글입니다.", "xotnekzz@naver.com", 4, "김태수", 1234);

INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "세 번째 댓글입니다.", "xotnekzz@naver.com", 4, "최예지", 1234);

4) 게시글 전체 댓글 조회

SELECT crno, cdate, content, email, rname, cno, passwd
FROM comment_reply
WHERE crno = 4 ;


SELECT cno, cdate, content, email, rname, good, cno, passwd
FROM comment_reply
WHERE crno = 23 ;

5) 댓글 갯수 구하기
  
 SELECT count(*) as cnt
 FROM comment_reply
 WHERE crno=4;
