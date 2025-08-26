package com.example.spring08.service;

import java.io.File;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.spring08.Exception.PasswordException;
import com.example.spring08.dto.PwdChangeRequest;
import com.example.spring08.dto.UserDto;
import com.example.spring08.repository.UserDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final CustomUserDetailsService customUserDetailsService;

	private final UserDao dao;
	
	//비밀번호 암호화 하기위한 객체도 spring bean container로부터 주입받는다
	private final PasswordEncoder encoder;
	
	//업로드된 이미지를 저장하기 위한 필드
	@Value("${file.location}")
	private String fileLocation;
	
	//사용자를 추가하는 메소드
	@Override
	public void createUser(UserDto dto) {
		//날것의 비번 암호화
		String encodedPwd = encoder.encode(dto.getPassword());
		//dto에 담기
		dto.setPassword(encodedPwd);
		//DB에 저장
		dao.insert(dto);
		
	}

	@Override
	public UserDto getUser(String userName) {		
		
		return dao.getByUserName(userName);
	}

	@Override
	public void updatePassword(PwdChangeRequest pcr) {
		//로그인된 userName
		String userName=SecurityContextHolder.getContext().getAuthentication().getName();
		//DB에 저장된 암호화된 비밀번호 읽어온다.
		UserDto dto=dao.getByUserName(userName);
		String encodedPwd=dto.getPassword();
		//암호화된 비밀번호와 입력한 비밀번호를 비교해서 일치하는지 확인한다
		boolean isValid=BCrypt.checkpw(pcr.getPassword(), encodedPwd);
		//일치하지 않으면 예외발생
		if(!isValid) {
			throw new PasswordException("기존 비밀번호가 일치하지 않습니다.");
		}
		//일치하면 새 비번을 암호화해서 pcr 객체에 담고 DB에 수정
		dto.setPassword(encoder.encode(pcr.getNewPassword()));
		dao.updatePassword(dto);
	}

	@Override
	public Map<String, Object> canUseId(String id) {
		//id를 이용해서 DB에 해당 아이디로 가입된 정보가 있는지 읽어와본다.(없으면 null)
		UserDto dto=dao.getByUserName(id);
		//id가 사용가능한지 여부 (dto가 null이면 사용가능한 아이디이다)
		boolean canUse = dto == null ? true : false;
		//Map 에 담아서 리턴
		return Map.of("canUse", canUse);
	}

	@Override
	public void updateUser(UserDto dto) {
		//업로드된 이미지가 있는지 읽어와본다
		MultipartFile image=dto.getProfileFile();
		//만일 업로드된 이미지가 있다면
		if(!image.isEmpty()) {
			//원본파일명
			String orgFileName = image.getOriginalFilename();
			//이미지 확장자 유지하기 위해 뒤에 원본파일명 추가
			String saveFileName=UUID.randomUUID().toString()+orgFileName;
			//저장할 파일 전체경로
			String filePath=fileLocation + File.separator + saveFileName;
			try {
				//업로드된 파일을 저장할 파일 객체 생성
				File saveFile=new File(filePath);
				image.transferTo(saveFile);
			}catch(Exception e) {
				e.printStackTrace();
				
			}
			//UserDto에 저장된 이미지의 이름 넣어주기
			dto.setProfileImage(saveFileName);
		}
		//UserDao 객체를 이용해서 수정 반영하기 ( dto 의 profileImage 는 null 일수도 있다)
		dao.update(dto);
	}
	
}
