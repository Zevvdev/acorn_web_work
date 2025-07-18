<%@page import="test.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//Get 방식 파라미터로 전달되는 글번호를 읽어와서
	int num=Integer.parseInt(request.getParameter("num"));

	//글 작성자와 로그인된 userName이 동일한지 비교해서 동일하지 않으면 ->에러
	String writer=BoardDao.getInstance().getByNum(num).getWriter(); //작성자
	String userName=(String)session.getAttribute("userName");
	//만일 글작성자와 userName이 다르면
	if(!writer.equals(userName)){
		//에러 페이지 응답
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "남의 글 막 지우면 혼난당!");
		return; //메소드 여기서 종료
	}
	
	
	//DB에서 해당글 삭제
	BoardDao.getInstance().deleteByNum(num);
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/delete.jsp</title>
</head>
<body>
	<script>
		alert("삭제되었습니다.");
		location.href="${pageContext.request.contextPath }/board/list.jsp";
	</script>
</body>
</html>