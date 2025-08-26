
CREATE TABLE gallery(
	num NUMBER PRIMARY KEY,
	title VARCHAR2(100) NOT NULL,
	writer VARCHAR2(20) NOT NULL,
	content CLOB,
	createdAt DATE DEFAULT SYSDATE
);
--gallery 테이블은 board_seq를 공유하기

CREATE TABLE gallery_image(
	num NUMBER PRIMARY KEY,
	galleryNum NUMBER REFERENCES gallery(num),
	saveFileName VARCHAR2(100) NOT NULL,
	createdAt DATE DEFAULT SYSDATE
);

CREATE SEQUENCE gallery_image_seq;


CREATE TABLE comments(
	num NUMBER PRIMARY KEY, -- 댓글 번호
	writer VARCHAR2(20) NOT NULL, -- 작성자
	content VARCHAR2(100) NOT NULL, -- 내용
	targetWriter VARCHAR2(20) NOT NULL, -- 누구에게 작성했는지
	groupNum NUMBER NOT NULL, -- 댓글의 그룹번호
	parentNum NUMBER NOT NULL, -- 부모가 되는 원글의 번호
	deleted CHAR(3) DEFAULT 'no', -- 댓글을 삭제했는지
	createdAt DATE DEFAULT SYSDATE -- 댓글 작성일
);

CREATE SEQUENCE comments_seq;


CREATE TABLE board(
	num NUMBER PRIMARY KEY, 
	writer VARCHAR2(20) NOT NULL,
	title VARCHAR2(50) NOT NULL,
	content CLOB,
	viewCount NUMBER DEFAULT 0,
	createdAt DATE DEFAULT SYSDATE
);

CREATE SEQUENCE board_seq;

CREATE TABLE users(
	num NUMBER PRIMARY KEY,
	userName VARCHAR2(20) UNIQUE,
	password VARCHAR2(100) NOT NULL,
	email VARCHAR2(50) UNIQUE,
	profileImage VARCHAR2(100), -- 프로필 이미지정보 (처음 가입시 null)
	role VARCHAR2(10) DEFAULT 'ROLE_USER',
	updatedAt DATE,
	createdAt DATE 
);

CREATE SEQUENCE users_seq;

CREATE TABLE member(
	num NUMBER PRIMARY KEY,
	name VARCHAR2(20),
	addr VARCHAR2(20)
);

CREATE SEQUENCE member_seq;

CREATE TABLE book(
	num NUMBER PRIMARY KEY,
	title VARCHAR(20),
	author VARCHAR(20),
	publisher VARCHAR(20)
);

CREATE SEQUENCE book_seq;


