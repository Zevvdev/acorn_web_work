package com.example.spring08.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor //모든 필드값을 전달받는 생성자(Builder 를 사용하려면 필요)
@NoArgsConstructor //빈생성자
@Data //setter, getter
public class BoardListResponse {

	//글 목록
	private List<BoardDto> list;
	private int startPageNum;
	private int endPageNum;
	private int totalPageCount;
	private int pageNum;
	private int totalRow;
	private String keyword;
	private String search; //검색조건
	private String query; //GET 방식 파라미터 "search=xxx&keyword=yyy" or ""
}
