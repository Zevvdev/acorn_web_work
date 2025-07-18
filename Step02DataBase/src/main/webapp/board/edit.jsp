<%@page import="test.dao.BoardDao"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num=Integer.parseInt(request.getParameter("num"));
	BoardDto dto=BoardDao.getInstance().getByNum(num);
	//글 수정 폼

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/edit.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<nav>
			 <ol class="breadcrumb">
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/">Home</a></li>
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/board/list.jsp">Board</a></li>
			   <li class="breadcrumb-item active" >Detail</li>
			 </ol>
		</nav>
		<h1>게시글 수정</h1>
		<form action="update.jsp" method="post">
			<div>
				<label class="form-lable" for="num">글 번호</label>
				<input class="form=control" type="text" name="num" id="num" value="<%=dto.getNum() %>" readonly />
			</div>
			<div>
				<label class="form-lable" for="writer">작성자</label>
				<input class="form=control" type="text" name="writer" id="writer" value="<%=dto.getWriter() %>" readonly />
			</div>
			<div>
				<label class="form-lable" for="title">제목</label>
				<input class="form=control" type="text" name="title" id="title" value="<%=dto.getTitle() %>" />
			</div>
			<div>
				<label class="form-lable" for="content">내용</label>
				<textarea class="form=control" name="content" id="content" rows="10"><%=dto.getContent() %></textarea>
			</div>
			<button class="btn btn=success btn-sm" type="submit">Edit</button>
		</form>
	
	</div>
</body>
</html>