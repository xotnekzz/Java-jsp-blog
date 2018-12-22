/**********************************/
CREATE TABLE 개발카테고리(
		devcateno INT NOT NULL IDENTITY,
		title VARCHAR(20) NOT NULL,
		ids VARCHAR_IGNORECASE(15) NOT NULL,
		visible CHAR(1) DEFAULT Y NOT NULL,
		seqno INT NOT NULL,
		cnt INT DEFAULT 0 NOT NULL
);

/**********************************/
/* Table Name: devdiary */
/**********************************/
CREATE TABLE 개발일지(
		devdiaryno INT NOT NULL IDENTITY,
		title_main VARCHAR(30) NOT NULL,
		title_sub VARCHAR(30),
		content VARCHAR(5000) NOT NULL,
		rdate DATETIME NOT NULL,
		file VARCHAR(20),
		fstor1 VARCHAR(20),
		thumb VARCHAR(20),
		size1 VARCHAR(20),
		email VARCHAR(20) NOT NULL,
		passwd VARCHAR(20) NOT NULL,
		devcateno INT NOT NULL,
		cnt INT DEFAULT 0 NOT NULL,
		visible CHAR(1) DEFAULT Y
);

/**********************************/
/* Table Name: comment */
/**********************************/
CREATE TABLE 댓글(
		cno INT NOT NULL IDENTITY,
		cdate DATETIME NOT NULL,
		content VARCHAR(100) NOT NULL,
		email VARCHAR(30) NOT NULL,
		devdiaryno INT NOT NULL,
		rname VARCHAR(10) NOT NULL,
		good INT DEFAULT 0
);

/**********************************/
/* Table Name: admin4 */
/**********************************/
CREATE TABLE 관리자계정(
		admin4no INT NOT NULL IDENTITY,
		mname VARCHAR(20) NOT NULL,
		email VARCHAR(50) NOT NULL,
		passwd VARCHAR(40) NOT NULL,
		tel VARCHAR(14) NOT NULL,
		auth VARCHAR(20),
		act CHAR(1) DEFAULT N NOT NULL,
		confirm CHAR(1) DEFAULT N NOT NULL,
		mdate DATETIME NOT NULL
);

/**********************************/
/* Table Name: notice4 */
/**********************************/
CREATE TABLE 공지사항(
		notice4no INT NOT NULL IDENTITY,
		title VARCHAR(100) NOT NULL,
		rname VARCHAR(15) NOT NULL,
		rdate DATETIME NOT NULL
);

/**********************************/
/* Table Name: comment_reply */
/**********************************/
CREATE TABLE 댓글 답변(
		crno INT NOT NULL IDENTITY, 
		cdate DATETIME NOT NULL,
		content VARCHAR(100) NOT NULL,
		email VARCHAR(30) NOT NULL,
		rname VARCHAR(10) NOT NULL,
		cno INT
);


ALTER TABLE 개발카테고리 ADD CONSTRAINT IDX_개발카테고리_PK PRIMARY KEY (devcateno);

ALTER TABLE 개발일지 ADD CONSTRAINT IDX_개발일지_PK PRIMARY KEY (devdiaryno);
ALTER TABLE 개발일지 ADD CONSTRAINT IDX_개발일지_FK0 FOREIGN KEY (devcateno) REFERENCES 개발카테고리 (devcateno);

ALTER TABLE 댓글 ADD CONSTRAINT IDX_댓글_PK PRIMARY KEY (cno);
ALTER TABLE 댓글 ADD CONSTRAINT IDX_댓글_FK0 FOREIGN KEY (devdiaryno) REFERENCES 개발일지 (devdiaryno);

ALTER TABLE 관리자계정 ADD CONSTRAINT IDX_관리자계정_PK PRIMARY KEY (admin4no);

ALTER TABLE 공지사항 ADD CONSTRAINT IDX_공지사항_PK PRIMARY KEY (notice4no);

ALTER TABLE 댓글 답변 ADD CONSTRAINT IDX_댓글 답변_PK PRIMARY KEY (crno);
ALTER TABLE 댓글 답변 ADD CONSTRAINT IDX_댓글 답변_FK0 FOREIGN KEY (cno) REFERENCES 댓글 (cno);

