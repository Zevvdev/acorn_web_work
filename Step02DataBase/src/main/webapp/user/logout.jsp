<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//세션에 저장된 값 삭제 => 로그아웃
	//"userName" 이라는 키값으로 저장된 값 삭제
	session.removeAttribute("userName");
	
	//응답
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/logout.jsp</title>
</head>
<body>
	<script>
		alert("로그아웃되었습니다");
		location.href="${pageContext.request.contextPath }";
	</script>
</body>
</html>