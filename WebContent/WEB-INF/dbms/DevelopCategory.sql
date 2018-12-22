
[개발_카테고리]

1. 테이블 생성
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

2) 테이블 삭제
DROP TABLE devcategory;
 
3) 등록
INSERT INTO devcategory(title, seqno, visible, ids, cnt)
VALUES('블로그 개발', 1, 'Y', 'master', 0);

 
4) 목록

SELECT devcateno, title, seqno, visible, ids, cnt
FROM devcategory
ORDER BY devcateno ASC;
  
           
5) 조회
SELECT devcateno, title, seqno, visible, ids, cnt
FROM devcategory
WHERE devcateno = 1;

 
6) 수정
UPDATE devcategory
SET title = 'ABC', seqno=0, visible='Y', ids='guest'
WHERE devcateno=1;
 
-- 출력 변경
UPDATE devcategory
SET visible='Y'
WHERE devcateno=1;
 
-- 접근 계정 지정
UPDATE devcategory
SET ids='guest'
WHERE devcateno=1;
 
-- 등록된 글 수 증가
UPDATE devcategory
SET cnt = cnt + 1
WHERE devcateno=1;
 
-- 등록된 글 수 감소
UPDATE devcategory
SET cnt = cnt - 1
WHERE devcateno=1;
 
-- 출력순서의 증가
UPDATE devcategory
SET seqno = seqno + 1
WHERE devcateno=1;
 
-- 출력 순서의 감소
UPDATE devcategory
SET seqno = seqno - 1
WHERE devcateno=1;
 
-- 등록된 글수의 초기화
UPDATE devcategory
SET cnt=0
WHERE devcateno=9;
  
8) 삭제
-- 모두 삭제
DELETE FROM devcategory;
 
-- 특정 레코드 삭제
DELETE FROM devcategory
WHERE devcateno=1;
 
-- FK 테이블에서 사용안되는 레코의 삭제
DELETE FROM devcategory
WHERE devcateno=7;
            