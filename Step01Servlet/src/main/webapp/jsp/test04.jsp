<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// context path를 HTTPServletRequest 객체의 메소드를 이용해서 얻어내기
	String cPath=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test04.jsp</title>
</head>
<body>
	<h1>context path 얻어내서 사용가기</h1>
	<a href="/Step01Servlet/index.html">인덱스</a>
	<a href="<%=cPath%>/index.html">인덱스</a>
	<h1>Expression Language 를 활용 ${pageContext.request.contextPath }</h1>
	<p>
		EL은 jsp 페이지에서 특별히 해석되는 언어
		\${ 이 안에 작성하는 언어가 EL }
	</p>
	
	${pageContext.request.contextPath }
	<a href="${pageContext.request.contextPath }/index.html">index</a>
	<br />
	<img src="${pageContext.request.contextPath }/images/Spain.png" alt="" />
	
	<script>
		//javascript 에서 backtic 안에 \${}를 사용할 일이 있다.
		function printMsg(msg){
			const result = `매개변수에 전달된 내용:\${msg}`;
			console.log(result);
			
		}
	
	
	</script>
</body>
</html>