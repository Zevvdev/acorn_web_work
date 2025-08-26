<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 	// request 객체에 특정 key 값으로 담긴 정보 추출
 	String orgFileName=(String)request.getAttribute("orgFileName");
 	String saveFileName=(String)request.getAttribute("saveFileName");
 	long fileSize=(long)request.getAttribute("fileSize");
 
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/kkk.jsp</title>
</head>
<body>
	<div class="container">
		<p>윤제가 응답한다</p>
		<p>원본파일명 : <%=orgFileName %></p>
		<p>저장파일명 : <%=saveFileName %></p>
		<p>파일크기 : <%=fileSize %></p>
		
		<%-- el을 이용하면 casting 필요없이 바로 추출 가능 --%>
		<p>원본파일명 : ${requestScope.orgFileName }</p>
		<p>저장파일명 : ${requestScope.saveFileName }</p>
		
		<%-- requestScope.은 생략가능 --%>
		<p>파일크기 : ${fileSize }</p>
		
		<a href="${pageContext.request.contextPath }/test/download?orgFileName=${orgFileName}&${saveFileName}&${fileSize}">다운로드</a>
	</div>

</body>
</html>