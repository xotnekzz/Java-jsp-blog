/** CONTENTS **/

[������]	       					

HOME ---- ������(ȸ��)
             +-- ���
                  +-- ���� �����ȣ �˻�
                  +-- ���� Ȯ�� ���� �߼�
             +-- ���
             +-- ��ȸ
             +-- ����
             +-- ����
             +-- �α���
             +-- �α׾ƿ�
             +-- ���� ����
             +-- �н����� ����

     ----- ����_ī�װ� 
	    			 +-- ī�װ� ���			
                  +-- �����    
	     			 +-- ī���ڸ� ���
	           +-- ī�װ� ��ȸ 
	           +-- ī�װ� ����
                  +-- ��¼��� ����
	      	   +-- ī�װ� ����

     ----- ����_����     
             +-- �������� ���
	                +-- �����
	                +-- �˻�
	                +-- ����¡
	           +-- �������� ��ȸ	
	           +-- �������� ���
 	                +-- ������
	                +-- file upload
                  +-- ���
	           +-- �������� ����


[�Խ�Ʈ]	       					

HOME ----- ����_����     
	           +-- �������� ���
	                +-- �����
	                +-- �˻�
	                +-- ����¡
		         +-- ���
	           +-- �������� ��ȸ

----------------------------------------------------------------------------------------------
[����_����]

1. ���̺� ���� 

/**********************************/
/* Table Name: devdiary */
/**********************************/
CREATE TABLE devdiary(
		devdiaryno INT NOT NULL AUTO_INCREMENT,
		devcateno INT NOT NULL,
		title_main VARCHAR(30) NOT NULL,
		title_sub VARCHAR(30),
		content TEXT NOT NULL,
		rname VARCHAR(15) NOT NULL,
		rdate DATETIME NOT NULL,
		file VARCHAR(20),
		fstor1 VARCHAR(20),
		thumb VARCHAR(20), 
		size1 VARCHAR(20),
		email VARCHAR(20) NOT NULL, 
		passwd VARCHAR(20) NOT NULL,
		cnt INT DEFAULT 0 NOT NULL,
		visible CHAR(1) DEFAULT 'Y',
  PRIMARY KEY (devdiaryno),
  FOREIGN KEY (devcateno) REFERENCES devcategory(devcateno)
);

2) ���̺� ����
DROP TABLE devdiary;
 
3) ���
INSERT INTO devdiary(title_main, title_sub, rname, content, rdate, email, passwd, devcateno, visible, file, fstor1, thumb, size1)
VALUES('��α� ���߿� ����', '��������', '�մ���', '����', now() , 'xotnekzz@naver.com', '1234' , 1 , 'Y', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000);


 
4) ���
SELECT devdiaryno, title_main, title_sub, content ,rdate, email, passwd, file, fstor1
FROM devdiary
ORDER BY devdiaryno ASC;

SELECT passwd
FROM devdiary
ORDER BY devdiaryno ASC;

-- ī�װ��� ���         
SELECT devdiaryno, devcateno, content, title_main, title_sub, email, 
          SUBSTRING(rdate, 1, 10) as rdate, visible
FROM devdiary
WHERE devcateno = 1
ORDER BY devdiaryno;
  	
           
5) ��ȸ
SELECT devdiaryno, title_main, title_sub, convert(content USING utf8), email, rdate, file, thumb, size1, visible, cnt, devcateno
FROM devdiary
WHERE devcateno = 1;

SELECT convert(content USING euc-kr)
FROM devdiary

SELECT content
FROM devdiary

SELECT *
FROM devdiary

5_1) ��ȸ�� ���� 
UPDATE devdiary
SET cnt = cnt + 1
WHERE devdiaryno=2;
 
5_2) 1���� �� ����(R:Read, PK ���) 
SELECT devdiaryno, title_main, title_sub, content, email, rdate, file, thumb, size1, visible, cnt
FROM devdiary
WHERE devdiaryno = 2;

5_3) �ֱٿ� �ö�� �� ��ȸ(5��)
SELECT devdiaryno, title_main, cnt, devcateno,
          (SELECT count(*)+1 FROM devdiary WHERE devdiaryno > t.devdiaryno ) AS rank 
FROM devdiary AS t 
ORDER BY rank limit 0, 5;

5_4) �α�� ��ȸ(5��)
SELECT devdiaryno, title_main, cnt, devcateno,
          (SELECT count(*)+1 FROM devdiary WHERE cnt > t.cnt ) AS rank 
FROM devdiary AS t 
ORDER BY rank limit 0, 5;
   


SELECT COUNT(*) as cnt 
FROM devdiary
WHERE devdiaryno=2 AND passwd='1234';
 
 cnt
 ---
   0

7) �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����.
UPDATE devdiary
SET title_main = '��α� �����̶�?', title_sub= 'jsp�� �����  ��αװ���', content='���̷�'
WHERE devdiaryno=2;
 
7_1) �۸� ���� 
UPDATE devdiary
SET title_main = '��α� �����̶�?', title_sub= 'jsp�� �����  ��αװ���', content='���̷�'
WHERE devdiaryno=2;
  
7_2) Visible ����
UPDATE devdiary
SET visible = 'Y'
WHERE devdiaryno=2;
 
7_3) ���� ����
UPDATE devdiary
SET file='', fstor1='', thumb='', size1=0
WHERE devdiaryno=2;
 
7_4) ���ο� ���� ���
UPDATE devdiary
SET file='test.jpg', fstor1='test.jpg', thumb='test_m.jpg', size1=123
WHERE devdiaryno=2;
 
7_5) ���� ��ü
UPDATE devdiary
SET file='new.jpg', fstor1='new.jpg', thumb='new_m.jpg', size1=123
WHERE devdiaryno=2;
  
 
8) �� ����(D:Delete) 
DELETE FROM devdiary
WHERE devdiaryno = 2;
 
DELETE FROM devdiary
WHERE devdiaryno <= 4;
 
DELETE FROM devdiary
WHERE devdiaryno >= 11;
 
 
8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - rname, title, content �÷� ���
 
8_1) ����: 
    - WHERE rname LIKE '�մ���'
       rname �÷��� ���� '�մ���'�� ���ڵ� ���� ���
 
    - WHERE rname LIKE '%�մ���%'
      rname �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���
 
    - WHERE rname LIKE '�մ���%'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
 
    - WHERE rname LIKE '%�մ���'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   
 
8_2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
ORDER BY devdiaryno DESC;
 
8_3) �̸� �˻�
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE rname LIKE '%�Ʒι�%'
ORDER BY devdiaryno DESC;
     
8_4) ���� �������� �˻�   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE title_main LIKE '%�н�����%'
ORDER BY devdiaryno DESC;

8_5) ���� �������� �˻�   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE title_sub LIKE '%�н�����%'
ORDER BY devdiaryno DESC;
    
 
9 ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
9_1) �˻��� ��ü ���ڵ� ��
SELECT COUNT(devdiaryno) as cnt 
FROM devdiary
WHERE rname LIKE '%�մ���%';
 
 cnt
 ---
   1
   
9_2) ����¡
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb, size1, visible 
FROM devdiary
WHERE rname LIKE '%�մ���%'
ORDER BY devdiaryno DESC
LIMIT 0, 5;
 
 pdsno rname email          title content passwd cnt rdate                 web                 file1     size1  thumb       visible
 ----- ----- -------------- ----- ------- ------ --- --------------------- ------------------- --------- ------ ----------- -------
     1 �մ���   mail1@mail.com ��     �� ����    123      2 2016-04-07 12:09:17.0 http://www.daum.net fun04.jpg 106346 fun04_t.jpg Y
 
     
------------------------------------------------------------------------------------------------------------------------------------------------

[���]

1) ���̺� ����
/**********************************/
/* Table Name: comment */
/**********************************/
CREATE TABLE comment(
		cno INT NOT NULL IDENTITY PRIMARY KEY,
		cdate DATETIME NOT NULL,
		content VARCHAR(100) NOT NULL,
		email VARCHAR(30) NOT NULL,
		devdiaryno INT NOT NULL,
  FOREIGN KEY (devdiaryno) REFERENCES devdiary (devdiaryno)
);

     
* �÷��� �߰�
ALTER TABLE devdiary
ADD COLUMN �߰��� �÷��� VARCHAR(100) AFTER visible;

DELETE FROM devdiary;

-------------------------------------------------------------------------------------------------------------------------------------
