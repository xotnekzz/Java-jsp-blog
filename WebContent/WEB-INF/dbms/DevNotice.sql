1. notice4 ���̺� ����
 
CREATE TABLE notice4(
  notice4no INT                NOT NULL AUTO_INCREMENT COMMENT '��ȣ',
  title       VARCHAR(100) NOT NULL COMMENT '����',
  rname    VARCHAR(15)  NOT NULL COMMENT '����',
  rdate     DATETIME       NOT NULL COMMENT '�����',
  PRIMARY KEY(notice4no)
);
 
2. ���̺� ����
DROP TABLE notice4;
 
3. ���
- PK �÷��� ������.
INSERT INTO notice4(title, rname, rdate)
VALUES('������ ���� ����', '�մ���', now());
 
INSERT INTO notice4(title, rname, rdate)
VALUES('4�� ���� ����', '�Ʒι�', now());
 
INSERT INTO notice4(title, rname, rdate)
VALUES('3�� �޿� �ȳ�', '�մ���', now());
 
4. ���
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no ASC;
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        1 ������ ���� ���� �մ���   2017-08-21 12:14:50.0
        2 4�� ���� ����  �Ʒι�   2017-08-21 12:15:28.0
        3 3�� �޿� �ȳ�  �մ���   2017-08-21 12:15:45.0
 
-- �ϳ��� �÷��� �ƴ϶� ���ڵ� ��ü�� ������ �̵���.        
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no DESC; 
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        3 3�� �޿� �ȳ�  �մ���   2017-08-21 12:15:45.0
        2 4�� ���� ����  �Ʒι�   2017-08-21 12:15:28.0
        1 ������ ���� ���� �մ���   2017-08-21 12:14:50.0
 
5. ��ȸ
SELECT notice4no, title, rname, rdate
FROM notice4
WHERE notice4no = 1;
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        1 ������ ���� ���� �մ���   2017-08-21 12:21:40.0
 
6. ����
1) ��� ���ڵ� ����(����)
UPDATE notice4
SET title='�ڹ� �ҽ�', rname = '����';
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        3 �ڹ� �ҽ� ����    2017-08-21 12:21:42.0
        2 �ڹ� �ҽ� ����    2017-08-21 12:21:41.0
        1 �ڹ� �ҽ� ����    2017-08-21 12:21:40.0
 
2) 1�� ���ڵ常 ����(����)
UPDATE notice4
SET title='�ʿ���', rname = '�Ʒι�'
WHERE notice4no = 1;
 
SELECT notice4no, title, rname, rdate
FROM notice4
WHERE notice4no = 1;
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        1 �ʿ���   �Ʒι�   2017-08-21 12:21:40.0
        
7. ����
1) �ϳ��� ���ڵ常 ����(����)
DELETE FROM notice4
WHERE notice4no = 1;
 
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no ASC;
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        2 �ڹ� �ҽ� ����    2017-08-21 12:21:41.0
        3 �ڹ� �ҽ� ����    2017-08-21 12:21:42.0
 
2) ��� ���ڵ� ����(����)        
DELETE FROM notice4;
 
3) ���ڵ� ����
SELECT COUNT(*) as cnt
FROM notice4;
 
 cnt
 ---
   0
 