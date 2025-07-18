<%@page import="test.dao.BoardDao"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼전송되는 내용 읽어오기
	int num=Integer.parseInt(request.getParameter("num"));

	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	
	String writer=BoardDao.getInstance().getByNum(num).getWriter();
	String userName=(String)session.getAttribute("userName");
	
	// 만일 작성자 != userName
	if(!writer.equals(userName)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "남의 글 수정하지 마라!");
		return;
	}
	//DB에 수정반영
	BoardDto dto=new BoardDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	BoardDao.getInstance().update(dto);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/update.jsp</title>
</head>
<body>
	<script>
		alert("수정 완료!");
		location.href="${pageContext.request.contextPath }/board/view.jsp?num=<%=num%>";
	</script>
	
</body>
</html>