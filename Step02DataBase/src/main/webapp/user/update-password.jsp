<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="test.dao.UserDao"%>
<%@page import="test.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//1. 폼 전송되는 기존 비밀번호와 새 비밀번호 읽어오기
	String password=request.getParameter("password");
	String newPassword=request.getParameter("newPassword");
	
	//2. 세션에 저장된 userName 을 이용해서 가입정보를 DB에서 불러온다.
	String userName=(String)session.getAttribute("userName");
	UserDto dto=UserDao.getInstance().getByUserName(userName);
	
	//3. 기존 비번과 DB에 저장된 비번이 일치하는지 확인
	boolean isValid=BCrypt.checkpw(password, dto.getPassword());
	
	//4. 일치->새 비번을 DB에 수정반영 후 로그아웃
	if(isValid){
		//새 비밀번호를 암호화한다.
		String encodedPwd=BCrypt.hashpw(newPassword, BCrypt.gensalt());
		//dto 에 담기
		dto.setPassword(encodedPwd);
		//DB에 수정반영
		UserDao.getInstance().updatePassword(dto);
		//로그아웃
		session.removeAttribute("userName");
	}
	//5. 불일치->에러정보 응답 후 다시 입력할 수 있도록
	//화이팅 ^^

%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/update-password.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isValid){ %>
			<p>
				<strong><%=userName %></strong> 님의 비밀번호가 수정되고 로그아웃됩니다.
				<a href="loginform.jsp?url=${pageContext.request.contextPath }/user/info.jsp">다시 로그인하기</a>
			</p>
		<%}else{ %>
			<p>
				기존 비밀번호가 일치하지 않습니다. 다시 입력하세요.
				<a href="edit-password.jsp">확인</a>
			</p>
		<%} %>
		
		
		
		
	</div>
</body>
</html>