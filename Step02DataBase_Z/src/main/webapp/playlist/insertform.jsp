<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/insertform.jsp</title>
</head>
<body>
	<div class="container">
		<h1>Playlist에 추가하기</h1>
		<form action="${pageContext.request.contextPath }/playlist/insert.jsp" method="post">
			<div>
				<label for="name">제목</label>
				<input type="text" name="title" id="title"/>
			</div>
			<div>
				<label for="name">아티스트</label>
				<input type="text" name="artist" id="artist"/>
			</div>
			<div>
				<label for="name">장르</label>
				<input type="text" name="genre" id="genre"/>
			</div>
			<button type="submit">add</button>
		</form>
	</div>

</body>
</html>