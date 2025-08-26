<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/file-form.jsp</title>
</head>
<body>
	<div class="container">
		<h1>파일업로드테스트	</h1>
		<form action="${pageContext.request.contextPath }/test/fileup" method="post"
			enctype="multipart/form-data">
			<input type="text" name="caption" placeholder="설명입력.." />
			<input type="file" name="myFile" />
			<button type="submit">업로드</button>
		</form>
	</div>
</body>
</html>