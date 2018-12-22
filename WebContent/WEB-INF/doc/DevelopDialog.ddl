/**********************************/
CREATE TABLE ����ī�װ�(
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
CREATE TABLE ��������(
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
CREATE TABLE ���(
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
CREATE TABLE �����ڰ���(
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
CREATE TABLE ��������(
		notice4no INT NOT NULL IDENTITY,
		title VARCHAR(100) NOT NULL,
		rname VARCHAR(15) NOT NULL,
		rdate DATETIME NOT NULL
);

/**********************************/
/* Table Name: comment_reply */
/**********************************/
CREATE TABLE ��� �亯(
		crno INT NOT NULL IDENTITY, 
		cdate DATETIME NOT NULL,
		content VARCHAR(100) NOT NULL,
		email VARCHAR(30) NOT NULL,
		rname VARCHAR(10) NOT NULL,
		cno INT
);


ALTER TABLE ����ī�װ� ADD CONSTRAINT IDX_����ī�װ�_PK PRIMARY KEY (devcateno);

ALTER TABLE �������� ADD CONSTRAINT IDX_��������_PK PRIMARY KEY (devdiaryno);
ALTER TABLE �������� ADD CONSTRAINT IDX_��������_FK0 FOREIGN KEY (devcateno) REFERENCES ����ī�װ� (devcateno);

ALTER TABLE ��� ADD CONSTRAINT IDX_���_PK PRIMARY KEY (cno);
ALTER TABLE ��� ADD CONSTRAINT IDX_���_FK0 FOREIGN KEY (devdiaryno) REFERENCES �������� (devdiaryno);

ALTER TABLE �����ڰ��� ADD CONSTRAINT IDX_�����ڰ���_PK PRIMARY KEY (admin4no);

ALTER TABLE �������� ADD CONSTRAINT IDX_��������_PK PRIMARY KEY (notice4no);

ALTER TABLE ��� �亯 ADD CONSTRAINT IDX_��� �亯_PK PRIMARY KEY (crno);
ALTER TABLE ��� �亯 ADD CONSTRAINT IDX_��� �亯_FK0 FOREIGN KEY (cno) REFERENCES ��� (cno);

