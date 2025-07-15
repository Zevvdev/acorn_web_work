<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. form 전송되는 숫자를 읽어와서 실제 정수로 만듦
	
	//2. 해당 숫자가 짝수면 "전송한 숫자 x는 짝수이다." / 홀수
	//	콘솔창이 아닌 클라이언트 웹브라우저에 출력하는 프로그래밍 하기
	
	int num = Integer.parseInt(request.getParameter("inputNum"));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jsp/save.jsp</title>
</head>
<body>
	<h3>if/else문 이용</h3>
	<%if(num%2 == 0){  %>
	<p>전송한 숫자 <%=num %>는 짝수이다.</p>
	<%}else{ %>
	<p>전송한 숫자 <%=num %>는 홀수이다.</p>
	<%} %>
	
	
	<h3>3항 연산자 이용</h3>
	<p>전송한 숫자 <%=num %>은(는) <%=num%2==0 ? "짝수":"홀수" %>이다.</p>
</body>
</html>