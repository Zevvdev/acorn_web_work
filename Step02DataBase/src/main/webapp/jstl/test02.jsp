<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jstl/test02.jsp</title>
</head>
<body>
	<c:if test="true">
		<p>출력 됨?</p>
	</c:if>
	<c:if test="false">
		<p>안됨?</p>
	</c:if>
	<%-- el을 이용하여 연산 결과를 jstl이 응답하도록 --%>
	<c:if test="${10%2 == 0 }">
		<p>10 은 짝수 입니다.</p>
	</c:if>
	<c:if test="${10%2 eq 0 }"> <%-- 비교 연산자 eq는 == 와 같다 --%>
		<p>10 은 짝수라고</p>
	</c:if>
	<c:if test="${20>10}"> <%-- 비교연산자 gt 는 > 와 같다 --%>
		<p>20은 10보다 큼</p>
	</c:if>
	<c:if test="${20 ge 10}"> <%-- 비교연산자 ge 는 >= 와 같다 --%>
		<p>20은 10보다 큼 ${20 ge 10 }</p>
	</c:if>
	<c:if test="${20 != 10}"> <%-- ne는 != 와 같다 --%>
		<p>20은 10과 다름 ${20 ne 10 }</p>
	</c:if>
	<c:if test="${'kim' ne 'lee' }">
		<p>kim 과 lee 는 다르다</p>
	</c:if>
</body>
</html>