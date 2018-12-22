1) ���̺� ����

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

2) ���̺� ����

DROP TABLE comment;

3) ��� ���

INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "ù ��° ����Դϴ�.", "xotnekzz@naver.com", 4, "�մ���", 1234);
  
INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "�� ��° ����Դϴ�.", "xotnekzz@naver.com", 4, "���¼�", 1234);

INSERT INTO comment(cdate, content, email, devdiaryno, rname, passwd)
VALUES(now(), "�� ��° ����Դϴ�.", "xotnekzz@naver.com", 4, "�ֿ���", 1234);

4) �Խñ� ��ü ��� ��ȸ

SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd
FROM comment
WHERE devdiaryno = 4 ;


SELECT cno, cdate, content, email, rname, good, devdiaryno, passwd
FROM comment
WHERE cno = 23 ;

5) ������ ����

UPDATE comment
SET good = good + 1
WHERE devdiaryno = 4 AND cno = 1;


5) ��� ���� ���ϱ�
  
 SELECT count(*) as cnt
 FROM comment
 WHERE devdiaryno=4;
