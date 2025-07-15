<%@page import="test.dao.MusicDao"%>
<%@page import="test.dto.MusicDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int num=Integer.parseInt(request.getParameter("num"));
	MusicDto dto=new MusicDao().getbyNum(num);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/updateform.jsp</title>
</head>
<body>
	<div class="container">
		<h1>곡 정보 수정하기</h1>
		<form action="${pageContext.request.contextPath }/playlist/update.jsp" method="post">
			<div>
				<label for="name">번호</label>
				<input type="text" name="num" id="num" value="<%=dto.getNum() %>" readonly/>
			</div>
			<div>
				<label for="name">제목</label>
				<input type="text" name="title" id="title" value="<%=dto.getTitle() %>" />
			</div>
			<div>
				<label for="name">아티스트</label>
				<input type="text" name="artist" id="artist" value="<%=dto.getArtist() %>" />
			</div>
			<div>
				<label for="name">장르</label>
				<input type="text" name="genre" id="genre" value="<%=dto.getGenre() %>" />
			</div>
			<button type="submit">update</button>
			<button type="reset">cancel</button>
		</form>
	</div>

</body>
</html>