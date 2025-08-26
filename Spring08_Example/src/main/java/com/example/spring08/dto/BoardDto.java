package com.example.spring08.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor //모든 필드값을 전달받는 생성자(Builder 를 사용하려면 필요)
@NoArgsConstructor //빈생성자
@Data //setter, getter
public class BoardDto {

	private int num;
	private String writer;
	private String title;
	private String content;
	private int viewCount;
	private String createdAt;
	//페이징 처리를 위한 필드
	private int startRowNum;
	private int endRowNum;
	//프로필 이미지 출력을 위한 필드
	private String profileImage;	
	//이전글 다음글 처리를 위한 필드
	private int prevNum;
	private int nextNum;
	private String keyword;	//검색 키워드
	private String search; //검색조건
	
}
