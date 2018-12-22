1. notice4 테이블 생성
 
CREATE TABLE notice4(
  notice4no INT                NOT NULL AUTO_INCREMENT COMMENT '번호',
  title       VARCHAR(100) NOT NULL COMMENT '내용',
  rname    VARCHAR(15)  NOT NULL COMMENT '성명',
  rdate     DATETIME       NOT NULL COMMENT '등록일',
  PRIMARY KEY(notice4no)
);
 
2. 테이블 삭제
DROP TABLE notice4;
 
3. 등록
- PK 컬럼은 생략함.
INSERT INTO notice4(title, rname, rdate)
VALUES('내일은 구름 조금', '왕눈이', now());
 
INSERT INTO notice4(title, rname, rdate)
VALUES('4월 개발 일정', '아로미', now());
 
INSERT INTO notice4(title, rname, rdate)
VALUES('3월 급여 안내', '왕눈이', now());
 
4. 목록
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no ASC;
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        1 내일은 구름 조금 왕눈이   2017-08-21 12:14:50.0
        2 4월 개발 일정  아로미   2017-08-21 12:15:28.0
        3 3월 급여 안내  왕눈이   2017-08-21 12:15:45.0
 
-- 하나의 컬럼이 아니라 레코드 전체의 순서가 이동됨.        
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no DESC; 
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        3 3월 급여 안내  왕눈이   2017-08-21 12:15:45.0
        2 4월 개발 일정  아로미   2017-08-21 12:15:28.0
        1 내일은 구름 조금 왕눈이   2017-08-21 12:14:50.0
 
5. 조회
SELECT notice4no, title, rname, rdate
FROM notice4
WHERE notice4no = 1;
 
 notice4no title     rname rdate
 -------- --------- ----- ---------------------
        1 내일은 구름 조금 왕눈이   2017-08-21 12:21:40.0
 
6. 수정
1) 모든 레코드 수정(주의)
UPDATE notice4
SET title='자바 소식', rname = '투투';
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        3 자바 소식 투투    2017-08-21 12:21:42.0
        2 자바 소식 투투    2017-08-21 12:21:41.0
        1 자바 소식 투투    2017-08-21 12:21:40.0
 
2) 1번 레코드만 수정(권장)
UPDATE notice4
SET title='늦여름', rname = '아로미'
WHERE notice4no = 1;
 
SELECT notice4no, title, rname, rdate
FROM notice4
WHERE notice4no = 1;
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        1 늦여름   아로미   2017-08-21 12:21:40.0
        
7. 삭제
1) 하나의 레코드만 삭제(권장)
DELETE FROM notice4
WHERE notice4no = 1;
 
SELECT notice4no, title, rname, rdate
FROM notice4
ORDER BY notice4no ASC;
 
 notice4no title rname rdate
 -------- ----- ----- ---------------------
        2 자바 소식 투투    2017-08-21 12:21:41.0
        3 자바 소식 투투    2017-08-21 12:21:42.0
 
2) 모든 레코드 삭제(주의)        
DELETE FROM notice4;
 
3) 레코드 갯수
SELECT COUNT(*) as cnt
FROM notice4;
 
 cnt
 ---
   0
 