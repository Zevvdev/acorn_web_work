<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="test.dto.PostDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	PostDto dto=new PostDto();
	List<PostDto> list=(List<PostDto>)request.getAttribute("list");
	



%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/post/list.jsp</title>
<style>
</style>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="board" name="thisPage"/>	
	</jsp:include>
	
	<div class="container">
		
		<h4>JOURNAL</h4>
		<a class="btn btn-sm" href="new-form.jsp" >
		post
		<i class="bi bi-pencil-square"></i>
		</a>
		
		<!-- 카드 형태 리스트 -->
		<div class="container py-4">
			<div class="row">
				<% for(PostDto tmp : list){ %>
					<div class="card">
					
						<img src="" alt="" />
						<div class="card-body">
							<h6><%=tmp.getPost_num() %></h6>
							<h3><%=tmp.getPost_title() %></h3>
							<a href="postview.jsp?num=<%=tmp.getPost_num() %>" class="btn">read more</a>
					
						</div>
					
					</div> <!-- card -->
				<%} %>
			</div> <!-- row -->
		</div>

	</div> <!-- container -->
	
</body>
</html>