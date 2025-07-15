<%@page import="test.dao.MusicDao"%>
<%@page import="test.dto.MusicDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title=request.getParameter("title");
	String artist=request.getParameter("artist");
	String genre=request.getParameter("genre");
	
	MusicDto dto = new MusicDto();
	dto.setTitle(title);
	dto.setArtist(artist);
	dto.setGenre(genre);
	
	MusicDao dao=new MusicDao();
	boolean isSuccess=dao.insert(dto);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/playlist/insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p>
		'<strong><%=title %></strong>'을 playlist에 추가했습니다.
		<a href="${pageContext.request.contextPath }/playlist/playlist.jsp">playlist</a>
		</p>
		<%}else{ %>
		<p>playlist에 저장 실패
		<a href="${pageContext.request.contextPath }/playlist/insertform">다시 추가하기</a>
		</p>
		<%} %>


</body>
</html>