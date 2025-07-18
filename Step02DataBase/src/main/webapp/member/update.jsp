<%@page import="test.dao.MemberDao"%>
<%@page import="test.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int num=Integer.parseInt(request.getParameter("num"));
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");


	
	MemberDto dto = new MemberDto();
	dto.setNum(num);
	dto.setName(name);
	dto.setAddr(addr);
	boolean isSuccess=new MemberDao().update(dto);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(isSuccess){ %>
		<p>
			<strong><%=num %></strong> 번 회원의 정보를 수정했습니다.
			<a href="list.jsp">확인</a>
		</p>
	<%}else{ %>
		<p>
			수정실패! <a href="updateform.jsp">돌아가기</a>
		</p>
	<%} %>

</body>
</html>