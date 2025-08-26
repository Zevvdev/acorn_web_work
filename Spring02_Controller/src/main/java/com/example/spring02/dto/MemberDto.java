package com.example.spring02.dto;

import lombok.Getter;
import lombok.Setter;

// lombok 의 기증 이용해서 setter & getter 메소드 만든다.
@Setter
@Getter
public class MemberDto {
	private int num;
	private String name;
	private String addr;
}
