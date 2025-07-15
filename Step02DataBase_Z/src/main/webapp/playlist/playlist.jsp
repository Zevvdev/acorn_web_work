<%@page import="test.dto.MusicDto"%>
<%@page import="test.dao.MusicDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<MusicDto> list=new MusicDao().selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Playlist</title>
<link rel="stylesheet" href="playlist.css" />
</head>
<body>
	<div class="container">
		<h1>PlayList</h1>
		<a href="${pageContext.request.contextPath }/playlist/insertform.jsp">add</a>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>아티스트</th>
				<th>장르</th>
				<th>삭제</th>
				<th>수정</th>
			</tr>
		</thead>
		<tbody>
		<%for(MusicDto tmp:list){ %>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getTitle() %></td>
				<td><%=tmp.getArtist() %></td>
				<td><%=tmp.getGenre() %></td>
				<td><a href="${pageContext.request.contextPath }/playlist/delete.jsp?num=<%=tmp.getNum()%>">delete</a></td>
				<td><a href="${pageContext.request.contextPath }/playlist/updateform.jsp?num=<%=tmp.getNum()%>">update</a></td>
			</tr>
		<%} %>
			 
		</tbody>
	
	
	
	</table>
	</div>
	

</body>
</html>