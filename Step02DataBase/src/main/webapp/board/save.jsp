<%@page import="test.dao.BoardDao"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 폼 전송되는 title과 content
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	//글 작성자는 세션 객체로부터 얻기
	String writer=(String)session.getAttribute("userName");
	//DB 저장
	BoardDto dto=new BoardDto();
	dto.setTitle(title);
	dto.setWriter(writer);
	dto.setContent(content);
	//글 번호 미리 얻어내기
	int num=BoardDao.getInstance().getSequence();
	//글 번호를 dto에 담기
	dto.setNum(num);
	boolean isSuccess=BoardDao.getInstance().insert(dto);
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/save.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isSuccess){ %>
			<script>
				alert("저장했습니다");
				location.href="view.jsp?num=<%=num %> ";
			</script>
		<%}else{ %>
			<p>
				글 저장실패
				<a href="new-form.jsp">다시 작성</a>
			</p>		
		<%} %>
	</div>
</body>
</html>