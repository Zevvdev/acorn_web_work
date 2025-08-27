package com.example.spring08.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.spring08.dto.MemberDto;
import com.example.spring08.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService service;

    @PostMapping("/member/update")
    public String update(MemberDto dto) {
    	//수정할 회원의 정보가 MemberDto 객체에 담겨서 전달된다.
    	service.updateMember(dto);
    	return "member/update";
    }
	
	@GetMapping("/member/edit")
	public String edit(int num, Model model) {
		//수정할 회원 정보 얻어와서
		MemberDto dto=service.getMember(num);
		//Model 객체에 담고
		model.addAttribute("dto", dto);
		//view page로 forward 이동해서 응답
		return "member/edit";
	}
	
	@GetMapping("/member/delete")
	public String delete(int num) {
		/*
		 * 매개변수에 int num을 선언하면 요청 파라미터 중에서 num 이라는 파라미터명으로 전달되는
		 * 문자열을 자동추출해서 Integer.parseInt() 를 수행해서 실제 int값으로 바꾼 다음
		 * 해당값을 매개변수에 전달해준다.
		 * int 값으로 바꿀 수 없는 문자열이 넘어오면 에러가 발생한다.
		 */
		service.deleteMember(num);
		return "member/delete";
	}
	
	@PostMapping("/member/save")
	public String save(MemberDto dto) {
		/*
		 * 매개변수에 MemberDto를 선언하면 폼 전송되는 파라미터가 자동추출되어서
		 * MemberDto 객체에 담긴 채로 전달된다.
		 * 단 MemberDto 클래스의 필드명과 폼전송되는 파라미터명이 같아야 한다.
		 * private String name <=> input type="text" name="name">
		 * private String addr <=> input type="text" name="addr">
		 */
		service.addMember(dto);
		
		// 회원 목록 보기 "/member/list" 요청을 다시 하라는 redirect 응답하기
		// "redirect:리다일렉트 경로" 처럼 redirect: 으로 시작하는 문자열 리턴하면 된다
		return "redirect:/member/list";
	}
	
	@GetMapping("/member/new-form")
	public String newForm() {
		//현재 여기서 수행할 로직은 없고, view page의 위치만 리턴해준다
		return "member/new-form";
	}
	
	@GetMapping("/member/list")
	public String list(Model model) {
		// 회원 목록
		List<MemberDto> list = service.selectAll();
		// 응답에 필요한 객체를 Model 객체에 담는다.
		model.addAttribute("list", list);
		
		// "/WEB-INF/views/member/list.jsp" 에서 응답하기
		return "member/list";
	}
}
