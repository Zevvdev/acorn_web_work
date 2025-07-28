
<%@page import="test.dao.CommentDao"%>
<%@page import="test.dto.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="test.dao.BoardDao"%>
<%@page import="test.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//get 방식 파라미터로 전달되는 글번호 얻기
	int num=Integer.parseInt(request.getParameter("num"));
	//DB에서 해당 글 정보 얻기
	BoardDto dto=BoardDao.getInstance().getByNum(num);
	//로그인된 userName (null일 수도)
	String userName=(String)session.getAttribute("userName");
	//만일 본인 글 자세히 보기가 아니면 조회수 1을 증가시킨다.
	if(!dto.getWriter().equals(userName)){
		BoardDao.getInstance().addViewCount(num);
	}
	//댓글 목록을 DB에서 읽어오기
	List<CommentDto> commentList=CommentDao.getInstance().selectList(num);
	//로그인했는지 여부 알아내기
	boolean isLogin = userName == null ? false : true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/view.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="view" name="thisPage"/>	
	</jsp:include>
	<div class="container pt-2">
		<nav>
			 <ol class="breadcrumb">
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/">Home</a></li>
			   <li class="breadcrumb-item">
			   <a href="${pageContext.request.contextPath }/board/list.jsp">Board</a></li>
			   <li class="breadcrumb-item active">Detail</li>
			 </ol>
		</nav>	
		<h1>게시물 상세보기</h1>
		<div class="btn-group mb-2">
			<a class="btn btn-outline-secondary btn-sm <%= dto.getPrevNum()==0? "disabled" : "" %>" href="view.jsp?num=<%=dto.getPrevNum() %>">
				<i class="bi bi-arrow-left"></i>
				Prev
			</a>
			<a class="btn btn-outline-secondary btn-sm" <%=dto.getNextNum()==0? "disabled" : "" %> href="view.jsp?num=<%=dto.getNextNum() %>">
				<i class="bi bi-arrow-right"></i>
				Next
			</a>
		</div>
		
		<table class="table table-striped">
			<colgroup>
				<col class="col-2" />
				<col class="col" />
			</colgroup>
			<tr>
				<th>글번호</th>
				<td><%=num %></td>			
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<%if(dto.getProfileImage() == null){ %>
						<i style="font-size:100px;" class="bi bi-person-circle"></i>
					<%}else{ %>
						<img src="${pageContext.request.contextPath }/upload/<%=dto.getProfileImage() %>" 
							style="width:100px;height:100px;border-radius:50%;"/>
					<%} %>
					<%=dto.getWriter() %>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<th><%=StringEscapeUtils.escapeHtml4(dto.getTitle())%></th>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getCreatedAt() %></td>
			</tr>
		</table>
		
		<div class="card mt-4">
		  <div class="card-header bg-light">
		    <strong>본문 내용</strong>
		  </div>
		  <div class="card-body p-1">
		    <%=dto.getContent() %>
		  </div>
		</div>
		
		<%if(dto.getWriter().equals(userName)){ %>
			<div class="text-end pt-2">
				<a class="btn btn-warning btn-sm" href="edit.jsp?num=<%=dto.getNum()%>">Edit</a>
				<a class="btn btn-danger btn-sm" href="delete.jsp?num=<%=dto.getNum()%>">Delete</a>
			</div>
		<%} %>
		
		<div class="card my-3">
		  <div class="card-header bg-primary text-white">
		    댓글을 입력해 주세요
		  </div>
		  <div class="card-body">
		    <!-- 원글의 댓글을 작성할 폼 -->
		    <form action="save-comment.jsp" method="post">
		      <!-- 숨겨진 입력값 -->
		      <input type="hidden" name="parentNum" value="<%=dto.getNum() %>"/>
		      <input type="hidden" name="targetWriter" value="<%=dto.getWriter() %>" />
		
		      <div class="mb-3">
		        <label for="commentContent" class="form-label">댓글 내용</label>
		        <textarea id="commentContent" name="content" rows="5" class="form-control" placeholder="댓글을 입력하세요"></textarea>
		      </div>
		
		      <button type="submit" class="btn btn-success">등록</button>
		    </form>
		  </div>
		</div>
		
		<!-- 댓글 목록 출력하기 -->
		<div class="comments">
			<%for(CommentDto tmp:commentList){ %>
			<!-- 대댓글은 자신의 글번호와 댓글의 그룹번호가 다름->왼쪽 마진(들여쓰기) -->
				<div class="card mb-3 <%=tmp.getNum() == tmp.getGroupNum() ? "" : "ms-5" %>">
					<%if(tmp.getDeleted().equals("yes")){ %>
						<div class="card-body">삭제된 댓글입니다.</div>
					<%}else{ %>
						<div class="card-body d-flex flex-column flex-sm-row position-relative">
							<%if(tmp.getNum() != tmp.getGroupNum()){ %>
		            			<i class="bi bi-arrow-return-right position-absolute" style="top:0;left:-30px"></i>
		            		<%} %>
			            	<!-- 댓글 작성자가 로그인된 userName일 경우 삭제버튼 출력 -->
			            	<%if(tmp.getWriter().equals(userName)) {%>
			            		<button data-num="<%=tmp.getNum() %>" class="btn-close position-absolute top-0 end-0 m-2"></button>
			            	<%} %>
			            	<%if(tmp.getProfileImage()==null){ %>
			            		<i style="font-size:50px;" class="bi me-3 align-self-center bi-person-circle"></i>
			            	<%}else{ %>
				                <img class="rounded-circle me-3 align-self-center" 
				                	src="${pageContext.request.contextPath }/upload/<%=tmp.getProfileImage() %>" 
				                	alt="프로필 이미지" 
				                	style="width:50px; height:50px;">
			                <%} %>
		                		                
			                <div class="flex-grow-1">
			                    <div class="d-flex justify-content-between">
			                        <div>
			                            <strong><%=tmp.getWriter() %></strong>
			                            <span>@<%=tmp.getTargetWriter() %></span>
			                        </div>
			                        <small><%=tmp.getCreatedAt() %></small>
		                    	</div>
		                    	<pre><%=tmp.getContent() %></pre>
		                    	<!-- 댓글 작성자가 로그인된 userName이라면 수정폼 / 아니면 댓글폼 -->
		                    	<%if(tmp.getWriter().equals(userName)){ %>
		                    		<!-- 수정 버튼 (본인에게만 보임) -->
				                    <button class="btn btn-sm btn-outline-secondary edit-btn">수정</button>
				
				                    <!-- 댓글 수정 폼 (처음에는 숨김) -->
				                    <div class="d-none form-div">
				                        <form action="comment-update.jsp" method="post">
					                        <!-- 댓글을 수정하기 위한 댓글의 번호, 이 페이지로 다시 돌아오기 위한 parentNum 같이 전송 -->
					                        <input type="hidden" name="num" value="<%=tmp.getNum()%>"/>
					                        <input type="hidden" name="parentNum" value="<%=num%>"/>
				                            <textarea name="content" class="form-control mb-2" rows="2" ><%=tmp.getContent() %></textarea>
				                            <button type="submit" class="btn btn-sm btn-success">수정 완료</button>
				                            <button type="reset" class="btn btn-sm btn-secondary cancel-edit-btn">취소</button>
			                        	</form>
	                    			</div>	
		                    	
		                    	<%}else{ %>
			                    	<button class="btn btn-sm btn-outline-primary show-reply-btn">댓글</button>  
		                   			<!-- 댓글 입력 폼 (처음에는 숨김) -->
		                   			<div class="d-none form-div">
		                       			<form action="save-comment.jsp" method="post">
		                       				<!-- 원글의 글 번호, 댓글대상자, 댓글 그룹번호 -->
		                       				<input type="hidden" name="parentNum" value="<%=dto.getNum() %>" />
		                       				<input type="hidden" name="targetWriter" value="<%=tmp.getWriter() %>" />
		                       				<input type="hidden" name="groupNum" value="<%=tmp.getGroupNum() %>" />
		                           			<textarea name="content" class="form-control mb-2" rows="2" placeholder="댓글을 입력하세요..."></textarea>
		                           			<button type="submit" class="btn btn-sm btn-success">등록</button>
		                           			<button type="reset" class="btn btn-sm btn-secondary cancel-reply-btn">취소</button>
		                           		</form>
		                    		</div>
		                    	<%} %>
	                    	</div>
                 		</div> <!-- card body -->
					<%} %>
               	</div> <!-- card -->
			<%} %>
		</div> <!-- comments -->
	</div><!-- .container -->
	<script>
		//로그인 여부
		const isLogin = <%=isLogin %>;
		//삭제 버튼을 눌렀을 때
		document.querySelectorAll(".btn-close").forEach(item=>{
			item.addEventListener("click", ()=>{
				//data-num 속성에 출력된 삭제할 댓글의 번호
				const num=item.getAttribute("data-num");
				const isDelete=confirm(num+"번 댓글을 삭제하시겠습니까?");
				if(isDelete){
					//"delete.jsp?num=삭제할댓글&parentNum=원글" 
					//\${}는 jsp 가 해석하지 못하게 \${} 역슬래시 붙이기
					location.href=`comment-delete.jsp?num=\${num}&parentNum=<%=num %>`;
				}
			})
		})
        //클래스명이 edit-btn 인 모든 버튼에 "click" 이벤트리스너
        document.querySelectorAll(".edit-btn").forEach(item=>{
            item.addEventListener("click", ()=>{
                //클릭한 버튼의 다음 형제요소의 class 목록에서 d-none 을 제거 
                item.nextElementSibling.classList.remove("d-none");
                //클릭한 버튼의 class 목록에 d-none 을 추가
                item.classList.add("d-none");
            });
        });
        //취소 버튼 - 이벤트리스너
        document.querySelectorAll(".cancel-edit-btn").forEach(item=>{
            item.addEventListener("click",()=>{
                //가장 가까운 부모 요소중에 클래스 속성이 form-div 인요소  
                const formDiv=item.closest(".form-div");
                //formDiv 에 d-none 클래스 추가해서 안보이게 하고
                formDiv.classList.add("d-none");
                //formDiv 의 이전 형제요소(댓글버튼)에 d-none 클래스 제거해서 보이게 한다  
                formDiv.previousElementSibling.classList.remove("d-none");
            })
        })
		document.querySelector("#commentContent").addEventListener("input", ()=>{
			//원글의 댓글 입력란에 포커스 왔을 때 -- 로그인 x라면
			if(!isLogin){
				const isMove=confirm("댓글 작성을 위해 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
				location.href=
					"${pageContext.request.contextPath }/user/login.jsp?url=${pageContext.request.contextPath }/board/view.jsp?num=<%=num %>";
			}
		})
		
        //모든 댓글 버튼에 이벤트 등록
        document.querySelectorAll(".show-reply-btn").forEach(item=>{
            // 매개변수에 전달된 item 은 댓글 button 의 참조값이다 
            item.addEventListener("click", ()=>{
            	//로그인 안했다면
            	if(!isLogin){
    				alert("댓글 작성을 위해 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
    				location.href=
    					"${pageContext.request.contextPath }/user/login.jsp?url=${pageContext.request.contextPath }/board/view.jsp?num=<%=num %>";
    				return;
            	}
                //클릭한 버튼의 다음 형제요소의 class 목록에서 d-none 을 제거 
                item.nextElementSibling.classList.remove("d-none");
                //클릭한 버튼의 class 목록에 d-none 을 추가
                item.classList.add("d-none");
            });
        });

        document.querySelectorAll(".cancel-reply-btn").forEach(item=>{
            item.addEventListener("click", ()=>{
                //가장 가까운 부모 요소중에 클래스 속성이 form-div 인요소  
                const formDiv=item.closest(".form-div");
                //formDiv 에 d-none 클래스 추가해서 안보이게 하고
                formDiv.classList.add("d-none");
                //formDiv 의 이전 형제요소(댓글버튼)에 d-none 클래스 제거해서 보이게 한다  
                formDiv.previousElementSibling.classList.remove("d-none");
            });
        });
    </script>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
	
</body>
</html>