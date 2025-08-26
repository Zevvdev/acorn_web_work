package com.example.spring04.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring04.dto.MemberDto;

// Dao에는 보통 @Repository 어노테이션을 붙여서 bean을 만든다.(내부적으로 추가기능을 제공해준다)
@Repository
public class MemberDaoImpl implements MemberDao{
	// MyBatis 를 사용할 때 필요한 핵심 객체
	// 방법1. @Autowired
	// private SqlSession session;
	
	// 방법2. 생성자를 이용해서 의존 객체를 주입 받는 것이 더 일반적이다.(lombok의 기능을 이용하면 생략가능)
	// @Autowired //생성자가 오직 1개인 경우에는 생략 가능하다.
	private final SqlSession session;
	
	public MemberDaoImpl(SqlSession session) {
		this.session=session;
	}
 
	@Override
	public List<MemberDto> selectAll() {
		/*
		 * 	.selectList() 를 호출하면 리턴 type은 무조건 List<T>이다.
		 * 	List 의 generic type T는 그떄그때 다르다
		 * 	resultType 이 바로 List 의 generic type 으로 설정된다.
		 */
		List<MemberDto> list = session.selectList("member.selectAll");
		return list;
	}

	@Override
	public void insert(MemberDto dto) {
		session.insert("member.insert", dto);
		
	}

	@Override
	public int update(MemberDto dto) {
		//update를 실행하고 update 된 row의 갯수 바로 리턴하기
		return session.update("member.update", dto);
	}

	@Override
	public int deleteByNum(int num) {
		return session.delete("member.delete", num);
	}

	/*
	 * select 되는 row가 1개면 session.selectOne() 메소드 사용
	 * select 되는 row가 여러개일 가능성 있으면 session.selectLis() 메소드를 사용해서
	 * select 한다.
	 */
	@Override
	public MemberDto getByNum(int num) {
		MemberDto dto=session.selectOne("member.getByNum", num);
		return dto;
	}
	
}
