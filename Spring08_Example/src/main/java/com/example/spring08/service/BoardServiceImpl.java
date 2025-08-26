package com.example.spring08.service;

import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.spring08.dto.BoardDto;
import com.example.spring08.dto.BoardListResponse;
import com.example.spring08.dto.CommentDto;
import com.example.spring08.repository.BoardDao;
import com.example.spring08.repository.CommentDao;

import ch.qos.logback.core.util.StringUtil;
import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

		private final BoardDao boardDao;
		private final CommentDao commentDao;
		//pageNum 또는 keyword에 해당하는 글목록과 추가정보를 
		//BoardListResponse 객체에 담아서 리턴하는 메소드
		@Override
		public BoardListResponse getBoardList(int pageNum, BoardDto dto) {
			//한 페이지에 몇개씩 표시할 건지
			final int PAGE_ROW_COUNT=3;
			
			//하단 페이지를 몇개 표시할건지
			final int PAGE_DISPLAY_COUNT=5;

			//보여줄 페이지의 시작 ROWNUM
			int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT; //공차수열
			//보여줄 페이지의 끝 ROWNUM
			int endRowNum=pageNum*PAGE_ROW_COUNT; //등비수열
			
			//하단 시작 페이지 번호 (소수점이 버려진 정수)를 이용
			int startPageNum = 1+ ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
			//하단 끝 페이지 번호
			int endPageNum = startPageNum+PAGE_DISPLAY_COUNT-1;
			

			//전체글의 갯수
			int totalRow = boardDao.getCount(dto);
			//전체 페이지의 갯수 구하기
			int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
			//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
			if(endPageNum > totalPageCount){
				endPageNum=totalPageCount; //보정해 준다. 
			}
			
			//startRowNum 과 endRowNum 을 BoardDto 객체에 담아서
			dto.setStartRowNum(startRowNum);
			dto.setEndRowNum(endRowNum);
			
			//글 목록 (검색 키워드가 있다면 그 목록)
			List<BoardDto> list=boardDao.selectPage(dto);

			String query="";
			if(dto.getKeyword() != null) {
				query="search="+dto.getSearch()+"&keyword="+dto.getKeyword();
			}
			
			//한줄  coding  으로 BoardListResponse 객체를 만들어서 리턴하기
			return BoardListResponse.builder()
					.list(list)
					.pageNum(pageNum)
					.keyword(dto.getKeyword())
					.search(dto.getSearch())
					.query(query)
					.startPageNum(startPageNum)
					.endPageNum(endPageNum)
					.totalPageCount(totalPageCount)
					.totalRow(totalRow)
					.build();
		}
		
		@Override
		public void createContent(BoardDto dto) {
			
			boardDao.insert(dto);
		}
		
		@Override
		public BoardDto getDetail(int num) {
			
			return boardDao.getByNum(num);
		}
		
		@Override
		public List<CommentDto> getComments(int parentNum) {

			return commentDao.selectList(parentNum);
		}
		@Override
		public void createComment(CommentDto dto) {

			//댓글 그룹번호가 넘어오지 않으면 dto.getGroupNum()은 0을 리턴
			
			//저장할 댓글의 pk를 미리 얻어낸다
			int num=commentDao.getSequence();
			dto.setNum(num);
			
			//만일 원글의 댓글이라면
			if(dto.getGroupNum() == 0) {
				dto.setGroupNum(num); //원글의 댓글을 자신의 글번호가 댓글의 그룹번호이고
			}
			//작성자 dto에 담기
			String userName = SecurityContextHolder.getContext().getAuthentication().getName();
			dto.setWriter(userName);
			
			//대댓글이면 이미 dto에 댓글의 그룹번호가 들어있다.
			commentDao.insert(dto);
			
		}
		@Override
		public void updateComment(CommentDto dto) {
			String writer = commentDao.getByNum(dto.getNum()).getWriter();
			String userName = SecurityContextHolder.getContext().getAuthentication().getName();
			if(writer.equals(userName)) {
				throw new RuntimeException("작성자만 수정할 수 있습니다!");
			}
			commentDao.update(dto);
			
		}
		@Override
		public void deleteComment(int num) {
			//글 작성자와 로그인된 userName이 동일한지 비교, 다르면 예외발생
			String writer = commentDao.getByNum(num).getWriter();
			String userName = SecurityContextHolder.getContext().getAuthentication().getName();
			if (!writer.equals(userName)) {
				throw new RuntimeException("작성자만 삭제할 수 있습니다!");
			}
			
			commentDao.delete(num);
		
		}
	
		
}
