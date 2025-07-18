<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="test.dao.BoardDao"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//get 방식 파라미터로 전달되는 글번호 얻기
	int num=Integer.parseInt(request.getParameter("num"));
	//DB에서 해당 글 정보 얻기
	BoardDto dto=BoardDao.getInstance().getByNum(num);
	//로그인된 userName (null일 수도)
	String userName=(String)session.getAttribute("userName");
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/view.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="view" name="thisPage"/>	
	</jsp:include>
	<div class="container pt-2">
		<nav>
			 <ol class="breadcrumb">
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/">Home</a></li>
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/board/list.jsp">Board</a></li>
			   <li class="breadcrumb-item active"  >Detail</li>
			 </ol>
		</nav>	
		<h1>게시물 상세보기</h1>
		<table class="table table-striped">
			<colgroup>
				<col class="col-2" />
				<col class="col" />
			</colgroup>
			<tr>
				<th>글번호</th>
				<td><%=num %></td>			
			</tr>
			<tr>
				<th>작성자</th>
				<th><%=dto.getWriter() %></th>
			</tr>
			<tr>
				<th>제목</th>
				<th><%=StringEscapeUtils.escapeHtml4(dto.getTitle())%></th>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
		</table>
		<%--
			클라이언트가 작성한 글 제목이나 내용을 그대로 클라이언트에게 출력하는 것은 javascript 주입 공격 받을 수 있음
			따라서 해당 문자열은 escape해서 출력하는 것이 안전함
		 --%>
		 <div><pre><%=StringEscapeUtils.escapeHtml4(dto.getContent()) %></pre></div>
		<div class="card mt-4">
		  <div class="card-header bg-light">
		    <strong>본문 내용</strong>
		  </div>
		  <div class="card-body p-1">
		    <pre class="mb-0" style="background-color: #f8f9fa; border-radius: 5px; padding: 1rem; white-space: pre-wrap; font-family: '맑은 고딕', 'Consolas', monospace;"><%= dto.getContent() %></pre>
		  </div>
		</div>
		<%if(dto.getWriter().equals(userName)){ %>
			<div class="text-end pt-2">
				<a class="btn btn-warning btn-sm" href="edit.jsp?num=<%=dto.getNum()%>">Edit</a>
				<a class="btn btn-danger btn-sm" href="delete.jsp?num=<%=dto.getNum()%>">Delete</a>
			</div>
		<%} %>
	</div><!-- .container -->
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
	
</body>
</html>