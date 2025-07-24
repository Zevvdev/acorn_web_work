<%@page import="org.apache.tomcat.jakartaee.commons.lang3.StringUtils"%>
<%@page import="test.dao.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//검색 keyword가 있는지 읽어와보기
	String keyword=request.getParameter("keyword");
	System.out.println(keyword); //null or "" 또는 "검색어"
	
	if(keyword==null){
		keyword="";
	}
	//기본 페이지 번호 1로 설정
	int pageNum=1;
	//페이지 번호 읽어오기
	String strPageNum=request.getParameter("pageNum");
	//전달되는 페이지 번호 있다면
	if(strPageNum != null){
		//해당 페이지 번호를 숫자로 변경해서 사용한다.
		pageNum=Integer.parseInt(strPageNum);
	}
		
	//한 페이지에 몇개씩 표시할 건지
	final int PAGE_ROW_COUNT=3;
	
	//하단 페이지를 몇개 표시할건지
	final int PAGE_DISPLAY_COUNT=5;

	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT; //공차수열
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT; //등비수열
	
	//하단 시작 페이지 번호 (소수점이 버려진 정수)를 이용
	int startPageNum = 1+ ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum = startPageNum+PAGE_DISPLAY_COUNT-1;

	/*
		StringUtils 클래스의 isEmpty() static 메소드를 이용하면 문자열이 비었는지 여부 알 수 있음
		null 또는 "" 빈 문자열은 비었다고 판정됨
		
		StringUtils.isEmpty(keyword) 는
		keyword == null or "".equals(keyword)
		를 대체할 수 있다
	*/
	//전체 글의 갯수
	int totalRow=0;
	if(StringUtils.isEmpty(keyword)){
		totalRow=BoardDao.getInstance().getCount();
	}else{
		totalRow=BoardDao.getInstance().getCountByKeyword(keyword);
	};
	//전체 페이지 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정
	}
	
	//dto에 select할 row의 정보 담기
	BoardDto dto=new BoardDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	//글목록
	List<BoardDto> list=null;
	//만일 keyword 없으면
	if(StringUtils.isEmpty(keyword)){
		list=BoardDao.getInstance().selectPage(dto);
	}else{
		dto.setKeyword(keyword);
		list=BoardDao.getInstance().selectPageByKeyword(dto);
	}
	
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/list.jsp</title>
<style>
	ul a{
		text-decoration: none;
		color: grey;
	}
	
	/* ul요소이면서 클래스 속성이 pagination인 */
	ul.my-pagination{
		list-style-type: none; /* ul의 disc 없애기 */
		padding-left: 0; /* 왼쪽 padding 제거 */
		display: flex; /* 자식 요소(li)를 flex 레이아웃으로 배치하기 위해(가로배치) */
		gap: 10px; /* 자식요소끼리 공간 부여 */
		justify-content: center; /* 가로로 배치된 상태에서 가운데 정렬 */
	}
	
	.active{
		font-weight: bold;
		color: green;
		text-decoration: underline;
	}
</style>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="board" name="thisPage"/>	
	</jsp:include>
	<div class="container pt-5 pt-">
		<a class="btn btn-outline-primary btn-sm  mb-3" href="new-form.jsp">
			새글 작성
			<i class="bi bi-pencil-square"></i>
		</a>
		<h1>게시글 목록입니다.</h1>
		<div class="row my-3">
			<!--  4/12인 칼럼 만들고 margin-start:auto로 왼쪽 마진 자동부여 -->
			<div class="col-lg-4 col-md-6 ms-auto">
				<form action="list.jsp" method="get">
					<div class="input-group">
						<input value="<%=StringUtils.isEmpty(keyword)? "":keyword %>" type="text" name="keyword" class="form-control" placeholder="검색어 입력.." />
						<button type="submit" class="btn btn-outline-secondary">검색</button>
					</div>
				</form>
				
			</div>		
		</div>
		<table class="table table bordered">
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성자</th>
				 	<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				
				<%for(BoardDto tmp:list){ %>
				
					<tr>
						<td><%=tmp.getNum() %></td>
						<td><%=tmp.getWriter() %></td>
						<td>
						<a href="${pageContext.request.contextPath }/board/view.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
						</td>
						<td><%=tmp.getViewCount() %></td>
						<td><%=tmp.getCreatedAt() %></td>
						<td><a href="${pageContext.request.contextPath }/board/edit.jsp?num=<%=tmp.getNum() %>">수정</a></td>
						<td><a href="javascript:" class="deleteLink" data-num="<%=tmp.getNum()%>">삭제</a></td>
					</tr>
				<%} %>
				 
				
			</tbody>
		</table>
		
		<ul class="pagination">
			<%-- startPageNum 이 1이 아닐때 이전 page 가 존재하기 때문에... --%>
			<%if(startPageNum != 1){ %>
				<li>
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&keyword=<%=keyword %>">&lsaquo;</a>
				</li>
			<%} %>			
			<%for(int i=startPageNum; i<=endPageNum ; i++){ %>
				<li>
					<a class="page-link <%= i==pageNum ? "active":"" %>" href="list.jsp?pageNum=<%=i %>&keyword=<%=keyword %>"><%=i %></a>
				</li>
			<%} %>
			<%-- endPageNum 이 totalPageCount 보다 작을때 다음 page 가 있다 --%>		
			<%if(endPageNum < totalPageCount){ %>
				<li>
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>&keyword=<%=keyword %>">&rsaquo;</a>
				</li>
			<%} %>	
		</ul>
		
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
</html>