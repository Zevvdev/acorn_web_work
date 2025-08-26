<%@page import="java.net.URLEncoder"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="test.dto.UserDto"%>
<%@page import="test.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 아이디와 비밀번호 추출하기
	String userName=request.getParameter("userName");
	String password=request.getParameter("password");
	//로그인 후에 가야할 목적지
	String url=request.getParameter("url");
	//로그인 실패를 대비해서 목적지 정보를 인코딩한 결과도 준비한다.
	String encodedUrl=URLEncoder.encode(url, "UTF-8");
	
	//아이디 비번이 유효한지
	boolean isValid=false;
	
	//DB에서 userName을 이용해서 select되는 정보가 있는지 select 해본다.
	UserDto dto=UserDao.getInstance().getByUserName(userName);
	if(dto!=null){
		//raw 비밀번호와 DB에 저장된 암호화된 비밀번호를 비교해서 일치하는지 확인한다.
		//Bcrypt.checkpw(입력한비번, 암호화된비번)
		isValid=BCrypt.checkpw(password, dto.getPassword());
		
	}
	/*
		만일 입력아이디와 비번이 유효하다면 로그인 처리
		jsp에서 기본제공하는 HTTPSession 객체에 userName 저장
		HTTPSession객체에 저장하면 응답 후 다음 요청에서 HTTPSession 객체에 저장된 정보 읽어올 수 있다
		세션 객체에 담긴 정보는 어떤 요청도 하지 않고 일정 시간이 흐르면 자동 삭제됨
		필요시 (로그아웃 요청) 강제로 세션 객체에 담긴 정보 삭제
		세션객체에 담긴 로그인 정보를 삭제 = `로그아웃`
		세션객체에 로그인정보(userName)을 저장하는 것 = `로그인`
	*/
	if(isValid){
		//HTTPSession 객체에 "userName"이라는 키값으로 userName을 저장
		session.setAttribute("userName", userName);
		//
		session.setAttribute("role", dto.getRole());
		//세션 유지시간 설정(초 단위)
		session.setMaxInactiveInterval(180*60); //기본값: 30분
	}
		
	// 체크박스 체크 상태로 버튼 누르면 null이 아님 (체크 X = null)
	String isSave=request.getParameter("isSave");
	if(isSave != null){
		// 입력한 아이디 비밀번호를 쿠키로 응답하고 1주일동안 유지
		Cookie cook1=new Cookie("saveUserName", userName);
		Cookie cook2=new Cookie("saveUserPassword", password);
		// 쿠키 유지시간 초 단위 설정
		cook1.setMaxAge(60*60*24*7);
		cook2.setMaxAge(60*60*24*7);
		// 쿠키 경로
		//cook1.setPath("/"); // 모든 경로에서 사용할 수 있는 쿠키
		//cook1.setPath("/user/"); // user 경로에서만 사용할 수 있는 쿠키
		// 설정하지 않으면 현재 경로에서만 사용할 수 있음
		
		//HttpServletResponse 객체에 Cookie 객체를 담으면 응답할 떄 알아서 쿠키가 응답
		response.addCookie(cook1);
		response.addCookie(cook2);
	}else{ // 체크박스 체크 X -> 쿠키 삭제
		// 특정 키값으로 저장된 쿠키값 삭제 (value 에는 아무 값이나 넣어도 상관없음)
		Cookie cook1=new Cookie("savedUserName", "");
		Cookie cook2=new Cookie("savedUserPassword", null);
		// 쿠키 유저시간을 0으로 설정해서 응답하면 쿠키가 삭제됨
		cook1.setMaxAge(0);
		cook2.setMaxAge(0);
		response.addCookie(cook1);
		response.addCookie(cook2);
	}
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/login.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isValid){ %>
			<p>
				<strong><%=userName %></strong> 회원님 로그인 성공!
				<a href="<%=url%>">확인</a>
				<a href="${pageContext.request.contextPath }/">인덱스 페이지로</a>
			</p>
		 
		
		<%}else{ %>
			<p>
				아이디 혹은 비밀번호가 틀렸습니다..
				<a href="loginform.jsp?url=<%=encodedUrl %>">다시 로그인하기</a>
			
			</p>
		<%} %>
	</div>
</body>
</html>