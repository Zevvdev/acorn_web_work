package com.example.spring08.controller;

import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.spring08.dto.BoardDto;
import com.example.spring08.dto.BoardListResponse;
import com.example.spring08.dto.CommentDto;
import com.example.spring08.service.BoardService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService service;
	
	
	
	@PostMapping("/board/comment-update")
	public String updateComment(CommentDto dto) {
		
		service.updateComment(dto);
		return "redirect:/board/view?num"+dto.getParentNum();
	}
	
	@GetMapping("/board/comment-delete")
	public String deleteComment(CommentDto dto) {
		//dto에는 삭제할 댓글의 글번호와 원글번호가 들어있다
		service.deleteComment(dto.getNum());
		
		return "redirect:/board/view?num="+dto.getParentNum();
	}

	@PostMapping("/board/save-comment")
	public String saveComment(CommentDto dto) {
		
		service.createComment(dto);
		//댓글을 작성한 원글 자세히 보기로 다시 리다일렉트 이동
		return "redirect:/board/view?num="+dto.getParentNum();
		
	}
	
	@PostMapping("/board/update")
	public String boardUpdate(BoardDto dto, RedirectAttributes ra) {
		//글 수정 반영하고
		service.updateContent(dto);
		//리다일렉트 이동해서 출력할 메시지도 담는다.
		ra.addFlashAttribute("message", "게시글을 성공적으로 수정했습니다");
		//글 자세히 보기로 리다일렉트
		return "redirect:/board/view?num="+dto.getNum();
	}
	
	@GetMapping("/board/edit")
	public String boardEdit(int num, Model model) {
		model.addAttribute("dto", service.getData(num));
		return "board/edit";
	}
	
	@GetMapping("/board/delete")
	public String boardDelete(int num) {
		
		service.deleteContent(num);
		return "board/delete";
	}
	
	
	@GetMapping("/board/view")
	public String boardView(BoardDto requestDto, Model model) {
		/*
		 * requestDto 에는 자세히 보여줄 글의
		 * num, search (검색조건), keyword(검색어)가 들어있을 수 있다.
		 * 검색어가 없을 경우 search와 keyword 는 null
		 */
		//서비스를 이용해서 응답에 필요한 데이터를 얻어내서
		BoardDto dto=service.getDetail(requestDto);
		
		String query="";
		if(dto.getKeyword() != null) {
			query="&search="+requestDto.getSearch()+"&keyword="+requestDto.getKeyword();
		}
		
		model.addAttribute("query", query);
		
		//댓글 목록은 원글의 글번호를 전달
		List<CommentDto> comments=service.getComments(requestDto.getNum());
		//모델 객체에 담고
		model.addAttribute("dto", dto);
		model.addAttribute("commentList", comments);
		//로그인된 userName 얻어내기
		//로그인을 안 했으면 "annonymousUser" 가 리턴된다
		String userName = SecurityContextHolder.getContext().getAuthentication().getName();
		System.out.println(userName);
		boolean isLogin = userName.equals("annonymousUser") ? false : true;
		//위의 추가 정보도 모델 객체에 담는다
		model.addAttribute("userName", userName);
		model.addAttribute("isLogin", isLogin);
		//타임리프 페이지에서 응답한다
		return "board/view";
	}
	
	/*
	 * @ModelAttribute 는 view page 에서 필요한 값을 대신 Model 객체에 담아준다
	 */
	@PostMapping("/board/save")
	public String boardSave(@ModelAttribute("dto") BoardDto dto) {
		//글작성자
		String userName=SecurityContextHolder.getContext().getAuthentication().getName();
		dto.setWriter(userName);
		//서비스 이용해서 글 저장하기
		service.createContent(dto);
		return "board/save";
	}
	
	@GetMapping("/board/new-form")
	public String newForm(){
		
		return "board/new-form";
		
	}
	
	/*
	 * @RequestParam 을 이용하면 요청 파라미터를 추출하면서 해당값이 없으면
	 * defaultValue를 설정할 수 있따
	 */
	
	
	@GetMapping("/board/list")
	public String list(Model model,
				@RequestParam(defaultValue = "1") int pageNum,
				BoardDto dto) {
		//Boarddto 객체에는 keyword와 search가 있을 수 있따
		
		BoardListResponse listResponse = service.getBoardList(pageNum, dto);
		    
	    // 모델에 'dto'라는 이름으로 BoardListResponse 객체를 추가합니다.
	    model.addAttribute("dto", listResponse);
	    
	    // "board/list" 템플릿으로 응답합니다.
	    return "board/list";
	}
}
