package com.example.spring08.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.spring08.Exception.MemberException;
import com.example.spring08.dto.MemberDto;
import com.example.spring08.repository.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper;
	
	@Override
	public List<MemberDto> selectAll() {
		
		return mapper.selectAll();
	}

	@Override
	public MemberDto getMember(int num) {
		MemberDto dto=mapper.getByNum(num);
		//만일 select되는 회원정보 없다면?
		if(dto==null) {
			//예외 발생
			throw MemberException.notFound(num);
		}
		return dto;
	}

	@Override
	public void addMember(MemberDto dto) {

		mapper.insert(dto);
	}

	@Override
	public void updateMember(MemberDto dto) {
		int rowCount = mapper.update(dto);
		//만일 수정되지 않았다면
		if(rowCount == 0) {
			throw MemberException.updateFailed(dto.getNum());
		}
	}

	@Override
	public void deleteMember(int num) {
		int rowCount = mapper.deleteByNum(num);
		//만일 삭제되지 않았다면
		if(rowCount == 0) {
			throw MemberException.deleteFailed(num);
		}
	}

}
