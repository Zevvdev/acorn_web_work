package com.example.spring08.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring08.dto.BoardDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements BoardDao {

	//의존객체
	private final SqlSession session;

	@Override
	public List<BoardDto> selectPage(BoardDto dto) {
		/*
		 * 1. mapper's namespace : board
		 * 2. sql's id : selectPage
		 * 3. parameterType : BoardDto
		 * 4. resultType : BoardDto( select 된 row 하나를 어떤 type으로 받을지 결정)
		 */
		return session.selectList("board.selectPage",dto);
	}



	@Override
	public int getCount(BoardDto dto) {
		//resultType : int
		return session.selectOne("board.getCount", dto);
	}

	

	@Override
	public void insert(BoardDto dto) {
		//이 메소드를 호출하는 시점에 dto.num은 0이지만
		session.insert("board.insert", dto);
		//이 메소드가 리턴된 이후에는 dto.num에는 저장된 글번호가 들어있다.
		//(selectkey의 결과값이 들어있음)
	}

	@Override
	public BoardDto getByNum(int num) {
		
		return session.selectOne("board.getByNum", num);
	}
	

	
}
