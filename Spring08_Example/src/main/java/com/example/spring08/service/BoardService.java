package com.example.spring08.service;

import java.util.List;

import com.example.spring08.dto.BoardDto;
import com.example.spring08.dto.BoardListResponse;
import com.example.spring08.dto.CommentDto;

public interface BoardService {

	public BoardListResponse getBoardList(int pageNum, BoardDto dto);
	public void createContent(BoardDto dto);
	public void deleteContent(int num); //게시글 삭제
	public void updateContent(BoardDto dto); //게시글 수정	
	public BoardDto getData(int num); //수정할 글정보 보여주는 서비스 메소드
	public BoardDto getDetail(BoardDto dto);
	
	public List<CommentDto> getComments(int parentNum);
	public void createComment(CommentDto dto);
	public void updateComment(CommentDto dto);
	public void deleteComment(int num);
}
