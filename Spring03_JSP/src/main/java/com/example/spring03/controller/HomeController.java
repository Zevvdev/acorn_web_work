package com.example.spring03.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
/*
 * @Controller 어노테이션이 붙어있기 때문에 spring은 new HomeController()해서 객체를 생성한 다음
 * spring bean container에서 직접 관리한다.
 * 
 * 또한 @Controller 어노테이션이 붙은 객체는 클라이언트 요청을 처리하는 특별한 객체이기 때문에 
 * 해당 동작을 하기 위한 준비 작업도 이루어진다.
 */

@Controller
public class HomeController {
	
	/*
	 * http://localhost:9000/
	 * 위에처럼 이 서버의 최상위(root) 경로 요청이 왔을 때 요청을 처리할 컨트롤러 메소드
	 */
	
	@GetMapping("/")
	public String home(HttpServletRequest request) {
		// DB에서 읽어온 공지사항이라고 가정하자
		List<String> notice=List.of("Spring 프레임워크가 시작되었습니다.", "어쩌구", "저쩌구..");
		
		// 응답에 필요한 data를 HttpServletRequest 객체에 담아준다.
		request.setAttribute("notice", notice);
		
		/*
		 * @ResponseBody 어노테이션 없이 리턴해주는 문자열은 view page (jsp 페이지)의 위치를 의미한다.
		 * 
		 * "home"를 리턴하면 application.properties 파일에 설정한대로
		 * 접두어(prefix)에 "/WEB-INF/views/"가 붙고
		 * 접미어(suffix)에 ".jsp"가 자동으로 붙어서
		 * 결국 view page는 "/WEB-INF/views/home.jsp"를 가리킨다.
		 * 해당 jsp 페이지로 응답이 위임된다. (forward 이동)
		 */
		return "home";
	}
	
}
