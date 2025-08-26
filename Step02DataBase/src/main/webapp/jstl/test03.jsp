<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	// el, jstl을 테스트하기 위한 숫자 "jumsu"라른 키값 담기
	request.setAttribute("jumsu", 90);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jstl/test03.jsp</title>
</head>
<body>
	<p>
		<strong>${sessionScope.userName }</strong> 님이
		획득한 점수는 <strong>${jumsu }점</strong> 입니다.
		<br />
		점수는
		<c:if test="${jumsu%2 eq 0 }">짝수</c:if>
		<c:if test="${jumsu%2 eq 1 }">홀수</c:if>입니다.
		<br />
		점수는
		<c:choose>
			<c:when test="${jumsu%2 eq 0 }">
				짝수입니다.
			</c:when>
			<c:otherwise>
				홀수입니다.
			</c:otherwise>
		</c:choose>
		<br />
		따라서 이번학기 학점은
		<c:choose>
			<c:when test="${jumsu ge 90 }">A</c:when>
			<c:when test="${jumsu >= 80 }">B</c:when>
			<c:when test="${jumsu >= 70 }">C</c:when>
			<c:when test="${jumsu >= 59 }">D</c:when> <%-- >=는 ge와 같다 --%>
			<c:otherwise>F</c:otherwise>
		</c:choose>
		입니다.
	</p>
</body>
</html>