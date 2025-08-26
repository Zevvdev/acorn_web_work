package com.example.spring08.Exception;
/*
 * 비밀번호 수정시 입력한 비밀번호가 DB에 저장된 비밀번호와 일치하지 않을 때 발생시키는 Exception type
 */
public class PasswordException extends RuntimeException {
	//생성자
	public PasswordException(String message) {
		super(message); //생성자의 매개변수에 전달된 예외 메시지를 부모 생성자에 전달하면
		//이 객체의 .getMessage() 메소드를 호출하면 해당 메시지가 리턴된다.
	}
}
