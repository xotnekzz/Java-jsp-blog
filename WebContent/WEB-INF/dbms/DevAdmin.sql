1. 테이블 구조
1) 최초 가입시 Master로 가입, 이후부터 인증대기 모드로 진입하며
   Master계정이 인증을해야 로그인 가능.
 
2) act: 역활의 구분 
   M: 마스터, Y: 로그인 가능, N: 로그인 불가, H: 인증 대기, G: 손님
 
 
DROP TABLE admin4; 
 
CREATE TABLE admin4 (
  admin4no INT NOT NULL AUTO_INCREMENT, -- 관리자 번호, 레코드를 구분하는 컬럼 
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  email       VARCHAR(50)  UNIQUE NOT NULL, -- 한번 등록된 email은 중복 안됨   
  passwd    VARCHAR(40)  NOT NULL, -- 패스워드, 영숫자 조합 
  tel          VARCHAR(14)   NOT NULL, -- 전화번호
  auth         VARCHAR(20) NOT NULL, -- 가입키, ABC + 현재시간 13자
  act           CHAR(1)         DEFAULT 'N' NOT NULL, -- M: 마스터, Y: 로그인 가능, N: 로그인 불가, H: 인증 대기, G: 손님
  confirm    CHAR(1)         DEFAULT 'N' NOT NULL, -- 이메일 링크 클릭 여부, Y:클릭, N:클릭안함
  mdate      DATETIME       NOT NULL, -- 가입일
  PRIMARY KEY (admin4no)                
); 
 
 
※ 제약 조건 
- NOT NULL: INSERT SQL에서 컬럼의 값 필수 입력. 
- UNIQUE  : 컬럼에 중복된 값이 올 수 없음. 
- PRIMARY KEY (id): 기본적으로 UNIQUE의 성질을 포함하면서 
  레코드를 구분하는 기준 컬럼의 값. 
 
SELECT * FROM admin4;
 
2. INSERT, 기초 데이터 추가 
- Duplicate entry 'test1@mail.com' for key 'email': 이메일 중복 등록 불가능
 
1) 중복 이메일 검사 관련 SQL 
    -- 0: 중복 아님, 1: 중복  
    SELECT COUNT(email) as cnt
    FROM admin4
    WHERE email = 'test1@mail.com';
 
    cnt
    ---
     1
 
2) MASTER 계정의 조회
    SELECT COUNT(admin4no) as cnt
    FROM admin4
    WHERE act = 'M';
 
    cnt
    ---
    0
 
3) 관리자 등록
   -- Master 계정
   INSERT INTO admin4(mname, email, passwd,
   					  auth, act, confirm, mdate)   
   VALUES('왕눈이', 'test3@gmail.com', 1234, '010-0000-0000', 
   		  'AXD0123456789012', 'M', 'Y', now());
 
   INSERT INTO admin4(mname, email, passwd,
   					  auth, act, confirm, mdate)   
   VALUES('아로미', 'test2@gmail.com', '1234', '010-0000-0000',  
   		  'AXD0123456789012', 'N', 'Y', now());
   		   
   INSERT INTO admin4(email, passwd, auth, act, confirm, mdate)   
   VALUES('test2@gmail.com', '1234', 'AXD0123456789012', 'N', 'N', now());
   
   INSERT INTO admin4(email, passwd, auth, act, confirm, mdate)   
   VALUES('test3@gmail.com', '1234', 'AXD0123456789012', 'N', 'N', now());
 
4) 이메일 인증
  UPDATE admin4
  SET confirm = 'Y'
  WHERE email='test2@gmail.com' AND auth='AXD0123456789012';
 
    
3. 목록
SELECT * FROM admin4;
 
1) 회원 전체 목록 
   SELECT admin4no, email, passwd, auth, act, confirm, mdate
   FROM admin4
   ORDER BY email ASC;
 
 admin4no email                  passwd auth             act confirm mdate
 -------- ---------------------- ------ ---------------- --- ------- ---------------------
        4 testcell2012@gmail.com 1234   ECB1461122430077 M   Y       2016-04-20 12:20:30.0
        5 testcell2013@gmail.com 1234   YXT1461122564047 H   N       2016-04-20 12:22:44.0
 
        
2) 권한의 변경(admin4DAO: int updateAct(int admin4no, String act))
UPDATE admin4 
SET  act='Y'
WHERE admin4no=1;
 
 
4. 회원 정보 보기 
   SELECT admin4no, email, passwd, auth, act, confirm, mdate
   FROM admin4
   WHERE admin4no = 1;
   
 
5. 패스워드 변경
1) 기존 패스워드 검사
- DAO: public int countPasswd(int admin4no, String passwd){ ... }
SELECT count(*) as cnt
FROM admin4
WHERE admin4no = 1 AND passwd='123';
 
2) 패스워드 변경
- DAO: public int updatePasswd(int admin4no, String passwd){ ... }
UPDATE admin4
SET passwd=''
WHERE admin4no=1;
 
 
6.  회원 정보 수정 
 
UPDATE admin4
SET email=''
WHERE admin4no = 1;
 
 
7. 'admin4' 회원 삭제 
DELETE FROM admin4;
 
DELETE FROM admin4
WHERE admin4no = 6;
 
 
8. 로그인 관련 SQL 
- DAO: public int login(String email, String passwd){ ... }
 
- 로그인 체크
SELECT count(*) as cnt
FROM admin4
WHERE email = 'test1@gmail.com' AND passwd='1234';
 
- Email 정보를 이용한 조회
SELECT admin4no, email, passwd, auth, act, confirm, mdate
FROM admin4
WHERE email = 'test1@gmail.com';
 
     
9. 검색된 전체 레코드 수
   - LIKE    : 정확하게 일치하지 않아도 출력 
   - =(equal): 정확하게 일치해야 출력 
   - 검색을 하지 않는 경우, 전체 목록 출력 
 
      
10. 검색 목록(S:Search List)  
 
 
11. 페이징
   - 목록은 페이징 구현을 필수로 합니다.
    
 
-------------------------------------------------------------------------------------
 
 
 