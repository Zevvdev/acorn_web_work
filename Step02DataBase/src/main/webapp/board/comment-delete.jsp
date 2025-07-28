<%@page import="test.dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 삭제할 댓글
	int num=Integer.parseInt(request.getParameter("num"));
	// 리다일렉트 이동할 때 필요한 원글
	String parentNum=request.getParameter("parentNum");
	// 삭제 - dao 이용
	CommentDao.getInstance().delete(num);
	// 리다일렉트 이동
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/board/view.jsp?num="+parentNum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/comment-deletd.jsp</title>
</head>
<body>

</body>
</html>