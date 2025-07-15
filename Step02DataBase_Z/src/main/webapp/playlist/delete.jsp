<%@page import="test.dto.MusicDto"%>
<%@page import="test.dao.MusicDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String title=null;

 	try{
 		int num=Integer.parseInt(request.getParameter("num"));
 	 	MusicDao dao=new MusicDao();
 	 	MusicDto dto=dao.getbyNum(num);
 	 	
 	 	title = dto!=null? dto.getTitle():null;
 	 	
 	 	if(!dao.delete(num)){
 	 		title=null;
 	 	}
 		
 	}catch(Exception e){
 		e.printStackTrace();
 		title=null;
 	}
 	
 	
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/playlist/delete</title>
</head>
<body>
	<script>
	<%if(title!=null){%>
		alert("<%=title %>이 삭제되었습니다.");
		location.href="${pageContext.request.contextPath }/playlist/playlist.jsp";
	<%} else{ %>
		alert("삭제 중 오류 발생");
		location.href="${pageContext.request.contextPath }/playlist/playlist.jsp";
	<%} %>
	</script>
	

</body>
</html>