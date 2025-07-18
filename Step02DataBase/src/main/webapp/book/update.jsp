<%@page import="test.dao.BookDao"%>
<%@page import="test.dto.MemberDto"%>
<%@page import="test.dto.BookDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String author=request.getParameter("author");
	String publisher=request.getParameter("publisher");
	
	BookDto dto=new BookDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setAuthor(author);
	dto.setPublisher(publisher);
	boolean isSuccess=new BookDao().update(dto);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/book/update.jsp</title>
</head>
<body>
	<script>
	<%if(isSuccess){ %>
		alert("<%=title %> 도서 정보를 성공적으로 수정했습니다.");
		//javascript를 이용하여 페이지 이동 (redirect 효과 가능)
		location.href="list.jsp";
	<%} else { %>
		alert("수정 실패");
		//다시 수정폼으로 이동
		location.href="updateform.jsp?num=<%=num %>";
	<%} %>
	</script>
</body>
</html>