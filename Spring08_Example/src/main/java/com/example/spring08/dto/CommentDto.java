package com.example.spring08.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor //모든 필드값을 전달받는 생성자(Builder 를 사용하려면 필요)
@NoArgsConstructor //빈생성자
@Data //setter, getter
public class CommentDto {

	private int num;
	private String writer;
	private String content;
	private String targetWriter;
	private int groupNum;
	private int parentNum;
	private String deleted;
	private String createdAt;
	//프로필 이미지를 출력하기 위한 필드 
	private String profileImage;
	//대댓글의 갯수를 저장하기 위한 필드
	private int replyCount;

}
