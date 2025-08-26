package com.example.spring05;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder //빌더 형식으로 필드에 값 대입한 객체를 얻어낼 수 있도록 한다(객체생성과 필드에 값 넣기를 1줄코딩 가능하
@NoArgsConstructor //디폴트 생성자를 자동으로 만들어준다.
@AllArgsConstructor //필드의 모든 값을 전달받아서 저장하는 생성자를 만들어준다.
@Data // setter, getter 메소드 + toString() 메소드를 자동으로 만들어준다.
public class MemberDto {
	private int num;
	private String name;
	private String addr;
}
