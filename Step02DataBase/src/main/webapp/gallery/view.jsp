<%@page import="test.dao.CommentDao"%>
<%@page import="test.dto.CommentDto"%>
<%@page import="test.dto.GalleryImageDto"%>
<%@page import="test.dto.GalleryDto"%>
<%@page import="test.dao.GalleryDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//자세히 보여줄 gallery 의 pk
	int num= Integer.parseInt(request.getParameter("num"));
	//gallery 정보 얻어오기
	GalleryDto dto=test.dao.GalleryDao.getInstance().getData(num);
	//gallery에 업로드된 이미지 목록 얻어오기
	List<GalleryImageDto> images = GalleryDao.getInstance().getImageList(num);
	//로그인된 userName (null일 가능성 있음)
	String userName=(String) session.getAttribute("userName");
	//댓글 목록
	List<CommentDto> commentList = CommentDao.getInstance().selectList(num);
	//로그인 여부
	boolean isLogin = userName == null ? false : true;
	
%>  

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/view.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
<style>
	/* 대댓글이 처음에는 안보이게 */
	.re-re{
		display: none;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="view" name="thisPage"/>	
	</jsp:include>
	<div class="container">
		<div class="card shadow">
			<!-- 작성자 정보 -->
			<div class="card-header d-flex align-items-center">
				<img alt="프로필 이미지" src="${pageContext.request.contextPath }/upload/<%=dto.getProfileImage() %>"
					style="width:100ps; height:100ps; border-radius:50%/">
				<strong><%=dto.getWriter() %></strong>
				<span class="text-muted ms-auto"><%=dto.getCreatedAt() %></span>
			</div>
			<!-- 본문 -->
			<div class="card-body">
				<h5 class="card-title"><%=dto.getTitle() %></h5>
				<p class="card-text"><%=dto.getContent().replaceAll("\n", "<br>") %></p>
				<div class="row">
					<%for(GalleryImageDto tmp:images){ %>
						<div class="col-md-6">
						<img src="<%=request.getContextPath() %>/upload/<%=tmp.getSaveFileName() %>" 
							class="img-fluid rounded" alt="photo" />
						</div>
					<%} %>
				</div>
				
				<!-- 이미지 출력 -->
				<%for (GalleryImageDto img:images){ %>
					<img src="<%=request.getContextPath()%>/uplode/<%=img.getSaveFileName()%>"
						class="gallery image" alt="photo">
				<%} %>
			</div>
		</div><!-- .card -->
		
		<!-- 댓글 -->
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
				<div class="card mb-3 <%=tmp.getNum() == tmp.getGroupNum() ? "" : "ms-5 re-re" %>">
					<%if(tmp.getDeleted().equals("yes")){ %>
						<div class="card-body">삭제된 댓글입니다.</div>
					<%}else{ %>
						<div class="card-body d-flex flex-column flex-sm-row position-relative">
							<%if(tmp.getReplyCount() != 0 && tmp.getNum() == tmp.getGroupNum()){ %>
			            		<button class="dropdown-btn btn btn-outline-secondary btn-sm position-absolute"
			            			style="bottom:16px; right:16px;">
			            			<i class="bi bi-caret-down"></i>
			            			답글 <%=tmp.getReplyCount() %> 개
			            		</button>
		            		<%} %>
		            		
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
			                            <small class="text-muted"><%=tmp.getCreatedAt() %></small>
			                        </div>
			                        
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
		
	</div><!-- container -->
	
	<script>
		//로그인 여부
		const isLogin = <%=isLogin %>;
		
		//대댓글 보기 버튼 눌렀을 때 실행할 함수 등록
    	document.querySelectorAll(".dropdown-btn").forEach(item => {
		item.addEventListener("click", (e) => {
     		//click 이벤트 발생한 그 버튼의 자손요소 중에서 caret up 또는 down 요소 찾기
			const caret = item.querySelector(".bi-caret-up, .bi-caret-down");
     		//caret 모양을 위아래로 토글시키기
			
			caret.classList.toggle("bi-caret-down");
			caret.classList.toggle("bi-caret-up");
			
			// 1. 버튼의 두 단계 부모 요소로 이동
			const grandParent = item.parentElement.parentElement;
			// 2. 두단계 부모요소의 바로 다음 형제 요소의 참조값 얻어내기
			let next = grandParent.nextElementSibling;
			// 3. 반복문->
			while (next) {
				//re-re 존재하면
				if(next.classList.contains("re-re")){
					//d-block 클래스를 토글
					next.classList.toggle("d-block");
				}else{
					//re-re 존재하지 않으면 반복문 탈출
					break;
				}
				
				//그 다음 형제 참조값 얻어내기
				next = next.nextElementSibling;
				
			}
			 });
		});
		
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
					"${pageContext.request.contextPath }/user/login.jsp?url=${pageContext.request.contextPath }/gallery/view.jsp?num=<%=num %>";
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
    					"${pageContext.request.contextPath }/user/login.jsp?url=${pageContext.request.contextPath }/gallery/view.jsp?num=<%=num %>";
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
	
</body>
</html>