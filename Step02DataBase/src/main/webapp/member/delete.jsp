<%@page import="test.dto.MemberDto"%>
<%@page import="test.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//삭제할 회원정보 삭제
	String numstr=request.getParameter("num");
	

	//DB에 저장하기 위해 MemberDto 객체에 담는다
	
	try{
		int num=Integer.parseInt(numstr);
		MemberDao dao=new MemberDao();
		dao.deleteByNum(num);
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	
	//응답
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/delete</title>
</head>
<body>
	
	<%--javascript를 응답해서 알림창이 뜨고 "확인" 버튼을 누르면 다시 list로 이동 --%>
	<script>
		alert("삭제했습니다.");
		location.href="${pageContext.request.contextPath }/member/list.jsp";
	
	</script>
	
	
</body>
</html>