package com.example.spring06.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileDto {
	private String title;
	// <input type="file" name="myFile">에서 name 속성 값 == 필드명을 일치 시켜야 함
	private MultipartFile myFile;
	//이외의 다른 필드도 있다고 가정
}
