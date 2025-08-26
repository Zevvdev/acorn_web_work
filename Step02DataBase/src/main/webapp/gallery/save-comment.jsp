<%@page import="test.dto.CommentDto"%>
<%@page import="test.dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//폼 전송되는 댓글 정보를 얻어낸다.
	int parentNum=Integer.parseInt(request.getParameter("parentNum"));
	String targetWriter=request.getParameter("targetWriter");
	String content=request.getParameter("content");
	
	//댓글의 그룹번호가 넘어오는지 읽어온다. (null이면 원글의 댓글 저장 요청)
	String strGroupNum=request.getParameter("groupNum");
	//댓글의 그룹번호를 담을 변수를 미리 만들고
	int groupNum=0;
	//만일 댓글 그룹번호가 넘어온다연 (대댓이라면)
	if(strGroupNum !=null){
		//댓글의 그룹번호를 변수에 담는다.
		groupNum=Integer.parseInt(strGroupNum);
	}
	
	
	//댓글 작성자 정보는 session 으로부터 얻어낸다.
	String writer=(String)session.getAttribute("userName");
	//저장할 댓글의 글번호를 미리 얻어낸다.
	int num=CommentDao.getInstance().getSequence();
	//저장할 댓글 정보 dto에 담기
	CommentDto dto=new CommentDto();
	dto.setNum(num);
	dto.setWriter(writer);
	dto.setTargetWriter(targetWriter);
	dto.setContent(content);
	dto.setParentNum(parentNum);
	
	//만약 원글의 댓글이면
	if(groupNum == 0){
		dto.setGroupNum(num); //원글의 댓글은 자신의 글번호가 댓글의 그룹번호
	}else{
		dto.setGroupNum(groupNum); //대댓은 전송된 그룹번호가 댓글의 그룹번호
	}
	
	
	//DB에 저장
	boolean isSuccess=CommentDao.getInstance().insert(dto);
	//응답(리다일렉트:새로운 경로로 요청 다시 하라고 응답)
	
	String cPath=request.getContextPath();
	//원래글 자세히 보기 페이지로 이동하라는 리다일렉트 응답
	response.sendRedirect(cPath+"/gallery/view.jsp?num="+parentNum);
	
	
	
%>
