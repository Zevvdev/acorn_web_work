package com.example.spring04.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.spring04.dto.BookDto;

@Repository
public class BookDaoImpl implements BookDao {
	
	private final SqlSession session;
	
	public BookDaoImpl(SqlSession session) {
		this.session=session;
	}
	
	@Override
	public List<BookDto> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void insert(BookDto dto) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public int update(BookDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int deleteByNum(int num) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public BookDto getByNum(int num) {
		// TODO Auto-generated method stub
		return null;
	}
}
