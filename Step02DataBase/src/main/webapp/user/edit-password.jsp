<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/edit-passwordjsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<h1>비밀번호 수정 양식</h1>
		<form action="update-password.jsp" method="post" id="editForm">
			<div>
				<label for="password">기존 비밀번호</label>
				<input type="password" name="password" id="pasword" />
			</div>
			<div>
				<label for="newPassword">새 비밀번호</label>
				<input type="password" name="newPassword" id="newPassword" />
			</div>
			<div>
				<label for="newPassword2">새 비밀번호 확인</label>
				<input type="password" id="newPassword2" />
			</div>
			<button type="submit">수정하기</button>
		</form>
	</div>
	<script>
		//id가 editForm 인 요소에 "submit" 이벤트가 일어났을 떄 실행할 함수 등록
		//form 내부에 있는 submit 버튼 누르면 해당 form에는 submit 이벤트 발생.
		document.querySelector("#editForm").addEventListener("submit", (e)=>{
			/*
				- 폼에 입력한 내용의 유효성 검증
				- 유효하다면-- 관여 X (자동으로 폼 제출됨)
				- 유효 X -- e.preventDefault(); 를 실행하여 폼 제출 막음
			*/
			//기존 비밀번호
			const pwd=document.querySelector("#password").value;
			//new
			const newPwd=document.querySelecto("#newPassword").value;
			//new2
			const newPwd2=document.querySelector("#newPassword2").value;
			if(pwd.tim()==""){ //문자열에서 공백제거(좌우 공백)해서 비교
				alert("기존 비밀번호를 입력하세요!")
				e.preventDefault();
			} 
			if(newPwd.trim()==""){
				alert("새 비밀번호를 입력하세요")
				e.preventDefault();
			}
			else if(newPwd.trim() !== newPwd2.trim()){
				alert("새 비밀번호를 확인란과 동일하게 입력하세요")
				e.preventDefault();
			}
			
		});
		
	
	</script>
</body>
</html>