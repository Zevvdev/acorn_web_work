
<%@page import="java.sql.Connection"%>
<%@page import="test.dao.MemberDao"%>
<%@page import="test.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="test.util.DbcpBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 회원 목록을 MemberDao 객체를 이용해서 얻어냄
	List<MemberDto> list=new MemberDao().selectAll();
	//2. 응답


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/list.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="member" name="thisPage"/>	
	</jsp:include>
	<div class="container">
	<h1>회원목록</h1>
	<table class="table table-bordered">
		<thead class="table-dark">
			<tr>
				<th>번 호</th>
				<th>이 름</th>
				<th>주 소</th>
				<th>수 정</th>
				<th>삭 제</th>
			</tr>
		</thead>
		<tbody>
		<%for(MemberDto tmp:list){%>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getName() %></td>
				<td><%=tmp.getAddr() %></td>
				<td><a href="${pageContext.request.contextPath }/member/updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
				<td><a href="javascript:" class="deleteLink" data-num="<%=tmp.getNum()%>">삭제</a></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	
	<a href="${pageContext.request.contextPath }/member/insertform.jsp">입력</a>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
	<script>
		document.querySelectorAll(".deleteLink").forEach(item=>{
			item.addEventListener("click", (e)=>{
				//e.target : 이벤트가 발생한 요소의 참조값
				//"click" 이벤트가 발생한 a 요소에 data-num 속성의 value 를 읽어오기
				const num=e.target.getAttribute("data-num");
				const isDelete=confirm(num+"번 회원을 삭제하시겠습니까?");
				if(isDelete){
					//delete.jsp 페이지로 이동하게 하면서 삭제할 회원의 번호도 같이 전달되도록 한다
					location.href="${pageContext.request.contextPath }/member/delete.jsp?num="+num;
				}
			});
		});
	</script>
</body>
</html>