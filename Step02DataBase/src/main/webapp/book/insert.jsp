<%@page import="test.dao.BookDao"%>
<%@page import="test.dto.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//1. 폼 전송되는 도서 정보 추출
	String title=request.getParameter("title");
	String author=request.getParameter("author");
	String publisher=request.getParameter("publisher");
	
	//2. 도서 정보를 dto에 담고
	BookDto dto=new BookDto();
	dto.setTitle(title);
	dto.setAuthor(author);
	dto.setPublisher(publisher);
	
	//3. dap 객체를 이용하여 DB에 저장
	boolean isSuccess=new BookDao().insert(dto);
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/book/insert.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>
	<div class="container">
		<%if(isSuccess){ %>
			<p class="alert alert-success mt-5">
				<i class="bi bi-check-circle-fill"></i>
				<strong><%=title %></strong> 도서를 새로 등록했습니다.
				
				<a class="alert-link" href="list.jsp">목록보기</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger mt-5">
				<i class="bi bi-x-circle-fill"></i>
				도서 등록 실패!
				<a class="alert-link" href="insertform.jsp">다시 시도</a>
			</p>
		
		<%} %>
	
	</div>

</body>
</html>