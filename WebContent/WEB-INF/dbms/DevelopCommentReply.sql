1) ���̺� ����

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


2) ���̺� ����
 
DROP TABLE comment_reply;

3) ��� ���

INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "ù ��° ����� 2��° ����Դϴ�.", "xotnekzz@naver.com", 3, "�մ���", 1234);
  
INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "�� ��° ����Դϴ�.", "xotnekzz@naver.com", 4, "���¼�", 1234);

INSERT INTO comment_reply(cdate, content, email, cno, rname, passwd)
VALUES(now(), "�� ��° ����Դϴ�.", "xotnekzz@naver.com", 4, "�ֿ���", 1234);

4) �Խñ� ��ü ��� ��ȸ

SELECT crno, cdate, content, email, rname, cno, passwd
FROM comment_reply
WHERE crno = 4 ;


SELECT cno, cdate, content, email, rname, good, cno, passwd
FROM comment_reply
WHERE crno = 23 ;

5) ��� ���� ���ϱ�
  
 SELECT count(*) as cnt
 FROM comment_reply
 WHERE crno=4;
