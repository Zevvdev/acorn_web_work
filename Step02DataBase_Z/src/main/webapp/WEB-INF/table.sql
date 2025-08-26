CREATE TABLE posts(
	post_num NUMBER PRIMARY KEY, -- 게시글 번호
	post_writer_num NUMBER NOT NULL, -- 게시글 작성자
	post_title VARCHAR2(50) NOT NULL, -- 게시글 제목
	post_content CLOB, -- 게시글 내용
	post_views NUMBER DEFAULT 0, -- 게시글 조회수
	post_stay_num NUMBER, -- 게시글 관련 스테이
	post_created_at DATE DEFAULT SYSDATE, -- 게시글 작성일
	post_updated_at DATE DEFAULT SYSDATE, -- 게시글 수정일
	post_deleted CHAR(3) DEFAULT 'no', -- 게시글 논리삭제
	post_type NUMBER DEFAULT 0 -- 게시글 타입 (일반 0 / 공지 1)
);

CREATE SEQUENCE posts_seq;



