package com.example.spring08.controller;

import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.spring08.dto.PwdChangeRequest;
import com.example.spring08.dto.UserDto;
import com.example.spring08.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final TestController testController;
	
	private final UserService service;
	
	@PostMapping("/user/update")
	public String update(UserDto dto) {
		//서비스를 이용해서 개인정보 수정
		service.updateUser(dto);
		//개인정보 자세히 보기로 리다일렉트 이동
		return "redirect:/user/info";
	}
	
	@GetMapping("/user/edit")
	public String userEdit(Model model) {
		//로그인된 userName
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		
		UserDto dto = service.getUser(userName);
		//응답에 필요한 정보를 Model 객체에 담기
		model.addAttribute("dto", dto);
		//타임리프 view page에서 회원정보 수정 폼을 응답
		return "user/edit";
	}
	
	//사용가능한 아이디인지 여부를 json 문자열로 리턴하는 메소드
	@GetMapping("/user/check-id")
	@ResponseBody
	public Map<String, Object> checkId(String inputId){
		
		return service.canUseId(inputId);
	}
	
	//비밀번호 수정반영 요청처리
	@PostMapping("/user/update-password")
	public String updatePassword(PwdChangeRequest pcr, HttpSession session,
				HttpServletRequest req, HttpServletResponse res) {
		//pcr 객체에는 기존 비밀번호와 새 비밀번호가 들어있다
		service.updatePassword(pcr);
		//세션을 초기화해서 로그아웃처리한다
		session.invalidate();
		
		//Security Logout Handler 객체를 이용해서 강제 로그아웃
		new SecurityContextLogoutHandler()
			.logout(req, res, SecurityContextHolder.getContext().getAuthentication());
		return "user/update-password";
	}
	
	//비밀번호 수정폼 요청 처리
	@GetMapping("/user/edit-password")
	public String editPassword() {
		
		return "user/edit-password";
	}
	
	@GetMapping("/user/info")
	public String userInfo(Model model) {
		//로그인된 userName
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		//서비스 객체를 이용해서 사용자 정보 얻어와서
		UserDto dto=service.getUser(userName);
		//Model 객체에 담고
		model.addAttribute("dto", dto);
		//타임리프 템플릿 페이지에서 응답한다
		return "user/info";
	}
	
	//회원가입 요청처리
	@PostMapping("/user/signup")
	public String signup(UserDto dto) {
		//UserService 객체를 이용해서 사용자 정보를 추가한다.
		service.createUser(dto);
		return "user/signup";
	}
	
	//회원가입 폼 요청처리
	@GetMapping("/user/signup-form")
	public String signupForm() {
		return "user/signup-form";
	}
	
	//권한 부족시 or 403인 경우
	@RequestMapping("/user/denied") // GET, POST 등 모두 가능
	public String userDenied() {
		return "user/denied";
	}
	
	

	@GetMapping("/user/loginform")
	public String loginform() {
		//templates/user/loginform.html 페이지로 forward 이동해서 응답
		return "user/loginform";
		
	}
	 
	//로그인이 필요한 요청경로를 로그인 하지 않은 상태로 요청하면 리다일렉트 되는 요청경로
	@GetMapping("/user/required-loginform")
	public String required_loginform() {
		//templates/user/loginform.html 페이지로 forward 이동해서 응답
		return "user/required-loginform";
	}
	
	//POST방식 /user/login 요청 후 로그인 성공인 경우 forward 이동될 url
	@PostMapping("/user/login-success")
	public String loginSuccess() {
		return "user/login-success";
	}
	
	//로그인 폼을 제출(post) 한 로그인 프로세스 중에 forward 되는 경로이기 떄문에 @PostMapping 임에 주의!
	@PostMapping("/user/login-fail")
	public String loginFail() {
		//로그인 실패임을 알릴 페이지
		return "user/login-fail";
	}
}
