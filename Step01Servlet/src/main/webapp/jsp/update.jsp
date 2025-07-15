<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 수정할 회원의 정보 추출하기
	String nick=request.getParameter("nick");
	String gender=request.getParameter("gender");
	String job=request.getParameter("job");
	String comment=request.getParameter("comment");
	//취미 정보는 넘어오지 않을 수 있고(선택 안함), 1개~3개 넘어올 수도 있지.
	String[] hobbys=request.getParameterValues("hobby"); //null일 수 있다.
	
	System.out.println("nick:"+nick);
	System.out.println("gender:"+gender);
	System.out.println("job:"+job);
	System.out.println("comment:"+comment);
	if(hobbys != null){
		for(String tmp:hobbys){
			System.out.println("hobby:"+tmp);
		}
	}

	//gsonxxx.jar 파일 다운로드->lib폴더
	//이 파일에 포함된 클래스로 생성된 객체를 이용하여
	//String[]에 저장된 문자열을 json 문자열로 변환하기
	if(hobbys !=null){
		Gson gson=new Gson();
		String result=gson.toJson(hobbys);
		System.out.println(result);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jsp/update.jsp</title>
</head>
<body>
	<p>회원정보 수정 완료</p>
</body>
</html>