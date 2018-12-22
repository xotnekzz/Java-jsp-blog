/** CONTENTS **/

[관리자]	       					

HOME ---- 관리자(회원)
             +-- 등록
                  +-- 다음 우편번호 검색
                  +-- 가입 확인 메일 발송
             +-- 목록
             +-- 조회
             +-- 수정
             +-- 삭제
             +-- 로그인
             +-- 로그아웃
             +-- 권한 변경
             +-- 패스워드 변경

     ----- 개발_카테고리 
	    			 +-- 카테고리 목록			
                  +-- 목록형    
	     			 +-- 카테코리 등록
	           +-- 카테고리 조회 
	           +-- 카테고리 수정
                  +-- 출력순서 변경
	      	   +-- 카테고리 삭제

     ----- 개발_일지     
             +-- 개발일지 목록
	                +-- 목록형
	                +-- 검색
	                +-- 페이징
	           +-- 개발일지 조회	
	           +-- 개발일지 등록
 	                +-- 편집기
	                +-- file upload
                  +-- 댓글
	           +-- 개발일지 삭제


[게스트]	       					

HOME ----- 개발_일지     
	           +-- 개발일지 목록
	                +-- 목록형
	                +-- 검색
	                +-- 페이징
		         +-- 댓글
	           +-- 개발일지 조회

----------------------------------------------------------------------------------------------
[개발_일지]

1. 테이블 생성 

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

2) 테이블 삭제
DROP TABLE devdiary;
 
3) 등록
INSERT INTO devdiary(title_main, title_sub, rname, content, rdate, email, passwd, devcateno, visible, file, fstor1, thumb, size1)
VALUES('블로그 개발에 들어가며', '서브제목', '왕눈이', '내용', now() , 'xotnekzz@naver.com', '1234' , 1 , 'Y', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000);


 
4) 목록
SELECT devdiaryno, title_main, title_sub, content ,rdate, email, passwd, file, fstor1
FROM devdiary
ORDER BY devdiaryno ASC;

SELECT passwd
FROM devdiary
ORDER BY devdiaryno ASC;

-- 카테고리별 목록         
SELECT devdiaryno, devcateno, content, title_main, title_sub, email, 
          SUBSTRING(rdate, 1, 10) as rdate, visible
FROM devdiary
WHERE devcateno = 1
ORDER BY devdiaryno;
  	
           
5) 조회
SELECT devdiaryno, title_main, title_sub, convert(content USING utf8), email, rdate, file, thumb, size1, visible, cnt, devcateno
FROM devdiary
WHERE devcateno = 1;

SELECT convert(content USING euc-kr)
FROM devdiary

SELECT content
FROM devdiary

SELECT *
FROM devdiary

5_1) 조회수 증가 
UPDATE devdiary
SET cnt = cnt + 1
WHERE devdiaryno=2;
 
5_2) 1건의 글 보기(R:Read, PK 사용) 
SELECT devdiaryno, title_main, title_sub, content, email, rdate, file, thumb, size1, visible, cnt
FROM devdiary
WHERE devdiaryno = 2;

5_3) 최근에 올라온 글 조회(5건)
SELECT devdiaryno, title_main, cnt, devcateno,
          (SELECT count(*)+1 FROM devdiary WHERE devdiaryno > t.devdiaryno ) AS rank 
FROM devdiary AS t 
ORDER BY rank limit 0, 5;

5_4) 인기글 조회(5건)
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

7) 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음.
UPDATE devdiary
SET title_main = '블로그 개발이란?', title_sub= 'jsp를 사용한  블로그개발', content='하이루'
WHERE devdiaryno=2;
 
7_1) 글만 수정 
UPDATE devdiary
SET title_main = '블로그 개발이란?', title_sub= 'jsp를 사용한  블로그개발', content='하이루'
WHERE devdiaryno=2;
  
7_2) Visible 수정
UPDATE devdiary
SET visible = 'Y'
WHERE devdiaryno=2;
 
7_3) 파일 삭제
UPDATE devdiary
SET file='', fstor1='', thumb='', size1=0
WHERE devdiaryno=2;
 
7_4) 새로운 파일 등록
UPDATE devdiary
SET file='test.jpg', fstor1='test.jpg', thumb='test_m.jpg', size1=123
WHERE devdiaryno=2;
 
7_5) 파일 교체
UPDATE devdiary
SET file='new.jpg', fstor1='new.jpg', thumb='new_m.jpg', size1=123
WHERE devdiaryno=2;
  
 
8) 글 삭제(D:Delete) 
DELETE FROM devdiary
WHERE devdiaryno = 2;
 
DELETE FROM devdiary
WHERE devdiaryno <= 4;
 
DELETE FROM devdiary
WHERE devdiaryno >= 11;
 
 
8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rname, title, content 컬럼 대상
 
8_1) 선언: 
    - WHERE rname LIKE '왕눈이'
       rname 컬럼의 값이 '왕눈이'인 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이%'
      rname 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력
 
    - WHERE rname LIKE '왕눈이%'
      rname 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이'
      rname 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   
 
8_2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
ORDER BY devdiaryno DESC;
 
8_3) 이름 검색
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE rname LIKE '%아로미%'
ORDER BY devdiaryno DESC;
     
8_4) 메인 제목으로 검색   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE title_main LIKE '%패신저스%'
ORDER BY devdiaryno DESC;

8_5) 서브 제목으로 검색   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM devdiary
WHERE title_sub LIKE '%패신저스%'
ORDER BY devdiaryno DESC;
    
 
9 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
9_1) 검색된 전체 레코드 수
SELECT COUNT(devdiaryno) as cnt 
FROM devdiary
WHERE rname LIKE '%왕눈이%';
 
 cnt
 ---
   1
   
9_2) 페이징
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb, size1, visible 
FROM devdiary
WHERE rname LIKE '%왕눈이%'
ORDER BY devdiaryno DESC
LIMIT 0, 5;
 
 pdsno rname email          title content passwd cnt rdate                 web                 file1     size1  thumb       visible
 ----- ----- -------------- ----- ------- ------ --- --------------------- ------------------- --------- ------ ----------- -------
     1 왕눈이   mail1@mail.com 봄     봄 여행    123      2 2016-04-07 12:09:17.0 http://www.daum.net fun04.jpg 106346 fun04_t.jpg Y
 
     
------------------------------------------------------------------------------------------------------------------------------------------------

[댓글]

1) 테이블 생성
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

     
* 컬럼의 추가
ALTER TABLE devdiary
ADD COLUMN 추가할 컬럼명 VARCHAR(100) AFTER visible;

DELETE FROM devdiary;

-------------------------------------------------------------------------------------------------------------------------------------
