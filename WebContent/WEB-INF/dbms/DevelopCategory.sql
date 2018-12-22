
[����_ī�װ�]

1. ���̺� ����
/**********************************/
/* Table Name: devcategory */
/**********************************/
CREATE TABLE devcategory(
    devcateno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(20) NOT NULL,
    ids VARCHAR(30) NOT NULL,
    visible CHAR(1) DEFAULT 'Y' NOT NULL,
    seqno INT NOT NULL,
    cnt INT DEFAULT 0 NOT NULL
);

2) ���̺� ����
DROP TABLE devcategory;
 
3) ���
INSERT INTO devcategory(title, seqno, visible, ids, cnt)
VALUES('��α� ����', 1, 'Y', 'master', 0);

 
4) ���

SELECT devcateno, title, seqno, visible, ids, cnt
FROM devcategory
ORDER BY devcateno ASC;
  
           
5) ��ȸ
SELECT devcateno, title, seqno, visible, ids, cnt
FROM devcategory
WHERE devcateno = 1;

 
6) ����
UPDATE devcategory
SET title = 'ABC', seqno=0, visible='Y', ids='guest'
WHERE devcateno=1;
 
-- ��� ����
UPDATE devcategory
SET visible='Y'
WHERE devcateno=1;
 
-- ���� ���� ����
UPDATE devcategory
SET ids='guest'
WHERE devcateno=1;
 
-- ��ϵ� �� �� ����
UPDATE devcategory
SET cnt = cnt + 1
WHERE devcateno=1;
 
-- ��ϵ� �� �� ����
UPDATE devcategory
SET cnt = cnt - 1
WHERE devcateno=1;
 
-- ��¼����� ����
UPDATE devcategory
SET seqno = seqno + 1
WHERE devcateno=1;
 
-- ��� ������ ����
UPDATE devcategory
SET seqno = seqno - 1
WHERE devcateno=1;
 
-- ��ϵ� �ۼ��� �ʱ�ȭ
UPDATE devcategory
SET cnt=0
WHERE devcateno=9;
  
8) ����
-- ��� ����
DELETE FROM devcategory;
 
-- Ư�� ���ڵ� ����
DELETE FROM devcategory
WHERE devcateno=1;
 
-- FK ���̺��� ���ȵǴ� ������ ����
DELETE FROM devcategory
WHERE devcateno=7;
            