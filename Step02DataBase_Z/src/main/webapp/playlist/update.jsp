<%@page import="test.dao.MusicDao"%>
<%@page import="test.dto.MusicDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String artist=request.getParameter("artist");
	String genre=request.getParameter("genre");
	
	MusicDto dto=new MusicDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setArtist(artist);
	dto.setGenre(genre);
	boolean isSuccess=new MusicDao().update(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/playlist/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p><strong><%=title %></strong>의 정보를 수정했습니다.</p>
		<a href="playlist.jsp">확인</a>
	
	<%} else{ %>
		<p>업데이트 실패
			<a href="updateform.jsp">돌아가기</a>
		</p>
	<%} %>
	
</body>
</html>