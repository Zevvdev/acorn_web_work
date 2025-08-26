<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//세션에 "userName"이라는 키값으로 저장된 값이 있는지 읽어와본다
	String userName=(String)session.getAttribute("userName");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="index" name="thisPage"/>
	</jsp:include>
	<div class="container">
		<h1>인덱스 페이지</h1>
		<ul>
			<li><a href="${pageContext.request.contextPath }/board/list.jsp">게시글 목록</a></li>	
			<li><a href="${pageContext.request.contextPath }/admin/index.jsp">관리자</a></li>	
			<li><a href="${pageContext.request.contextPath }/staff/index.jsp">직원</a></li>	
			<li><a href="${pageContext.request.contextPath }/test/file-form.jsp">파일 업로드 테스트</a></li>	
			<li><a href="${pageContext.request.contextPath }/jstl/hello.jsp">hello.jstl</a></li>	
			<li><a href="${pageContext.request.contextPath }/jstl/test01.jsp">test01.jstl</a></li>	
		</ul>
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="images/top01.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="images/top02.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="images/top03.jpg" class="d-block w-100" alt="...">
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>	
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
	
</body>
</html>