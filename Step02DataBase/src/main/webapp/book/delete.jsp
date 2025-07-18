<%@page import="test.dao.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//삭제할 도서번호
	int num=Integer.parseInt(request.getParameter("num"));
	//DB에서 삭제
	new BookDao().deleteByNum(num);
	//새로운 경로로 요청을 다시하라고 응답
	String cPath=request.getContextPath();
	// HTTPServletResponse 객체의 메소드 이용하여 도서목록 페이지를 다시 요청 (페이지 refresh 효과)
	response.sendRedirect(cPath+"/book/list.jsp");

%>
