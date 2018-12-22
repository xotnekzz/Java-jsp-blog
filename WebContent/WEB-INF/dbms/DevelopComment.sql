1) 테이블 생성

CREATE TABLE comment(
    cno INT NOT NULL AUTO_INCREMENT,
    cdate DATETIME NOT NULL,
    content VARCHAR(200) NOT NULL,
    email VARCHAR(30) NOT NULL,
    devdiaryno INT NOT NULL, 
    rname VARCHAR(10) NOT NULL,
    passwd VARCHAR(10) NOT NULL,
    good INT DEFAULT 0,
    PRIMARY KEY (cno),
    FOREIGN KEY (devdiaryno) REFERENCES devdiary(devdiaryno) ON DELETE CASCADE
);    

2) 테이블 삭제

DROP TABLE comment;

3) 댓글 등록

INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "첫 번째 댓글입니다.", "xotnekzz@naver.com", 4, "왕눈이", 1234);
  
INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "두 번째 댓글입니다.", "xotnekzz@naver.com", 4, "김태수", 1234);

INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "세 번째 댓글입니다.", "xotnekzz@naver.com", 4, "최예지", 1234);

4) 게시글 전체 댓글 조회

SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd
FROM comment
WHERE devdiaryno = 4 ;


SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd
FROM comment
WHERE cno = 23 ;

5) 공감수 증가

UPDATE comment
SET good = good + 1
WHERE devdiaryno = 4 AND cno = 1;


5) 댓글 갯수 구하기
  
 SELECT count(*) as cnt
 FROM comment
 WHERE devdiaryno=4;
