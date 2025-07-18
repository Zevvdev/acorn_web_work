<%@page import="test.dto.BookDto"%>
<%@page import="test.dao.BookDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
List<BookDto> list = new BookDao().selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/book/list.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="index" name="thisPage"/>
	</jsp:include>
	<div class="container">

		<h1>도서목록</h1>
		<a href="insertform.jsp">도서등록</a>
		<table class="table table-bordered">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>저자</th>
					<th>출판사</th>
					<th>삭제</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>

				<%
				for (BookDto tmp : list) {
				%>
				<tr>
					<td><%=tmp.getNum()%></td>
					<td><%=tmp.getTitle()%></td>
					<td><%=tmp.getAuthor()%></td>
					<td><%=tmp.getPublisher()%></td>
					<td><a href="delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
					<td><a href="updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
				</tr>
				<%
				}
				%>

			</tbody>

		</table>
	</div>
	<script>
	document.queryselectorAll().
	</script>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
</html>