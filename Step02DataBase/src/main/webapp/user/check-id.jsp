<%@page import="test.dao.UserDao"%>
<%@page import="test.dto.UserDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//get 방식 파라미터로 넘어오는 입력한 id를 읽어온다.
	String inputId=request.getParameter("inputId");
	//dao를 이용해서 해당 정보 있는지 select
	UserDto dto=UserDao.getInstance().getByUserName("userName");
	//아이디 존재x : 사용가능
	boolean canUse = dto == null ? true : false;
	
	// 문서 위 contentType html->application/json 으로 변경
	// json으로 {"canUse":true} 혹은 {"canUse":false}로 응답
%>


{"canUse":<%=canUse %>} 