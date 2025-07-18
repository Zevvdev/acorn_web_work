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


