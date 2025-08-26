<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/signup-form.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="member" name="thisPage"/>	
	</jsp:include>
	<div class="container">
		<h1>회원가입 양식</h1>
				<%-- 웹브라우저의 자체 폼 검증기능 비활성화  <form  novalidate> --%>
		<form action="signup.jsp" method="post" novalidate>
			<div class="mb-2">
				<label class="form-label" for="userName">아이디</label>
				<input class="form-control" type="text" name="userName" id="userName"/>
				<small class="form-text">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요</small>
				<div class="valid-feedback">사용 가능한 아이디 입니다.</div>
				<div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="pwd">비밀번호</label>
				<input class="form-control" type="password" name="pwd" id="pwd"/>
				<small class="form-text">특수 문자를 하나 이상 조합하세요.</small>
				<div class="invalid-feedback">비밀 번호를 확인 하세요</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="pwd2">비밀번호 확인</label>
				<input class="form-control" type="password"  id="pwd2"/>
			</div>
			<div class="mb-2">
				<label class="form-label" for="email">이메일</label>
				<input class="form-control" type="email" name="email" id="email"/>
				<div class="invalid-feedback">이메일 형식에 맞게 입력하세요.</div>
			</div>
			<button class="btn btn-primary btn-sm" type="submit" disabled>가입</button>
		</form>
	</div>
	<script>
	
		//아이디 유효성 여부 관린할 변수
		let isIdValid=false;
		let isPwdValid=false;
		let isEmailValid=false;
		
		const checkForm = () =>{
			//만일 아이디, 비밀번호, 이메일이 유효하다면
			if(isIdValid && isPwdValid && isEmailValid){
				//전송 버튼에 disabled 속성 제거하고
				document.querySelector("[type=submit]").removeAttribute("disabled");
			}else{
				//전송 버튼에 disabled 속성 추가
				document.querySelector("[type=submit]").setAttribute("disabled","")
			}
		}
		
		document.querySelector("#userName").addEventListener("blur", (e)=>{
			//현재까지 입력한 아이디 읽어오기
			const inputId = e.target.value;
			// "영문자 소문자로 시작하고 5~10글자 이내" 검증조건 만족여부
			const reg = /^[a-z].{4,9}$/;
			if(!reg.test(inputId)){
				e.target.classList.remove("is-valid");
				e.target.classList.add("is-invalid");
				
				//사용할 수 없는 아이디 false
				isIdValid=false;
				checkForm();
				
				return;
			}
			//fetch() 함수를 이용해서 get 방식으로 입력한 아이디를 보내고 사용여부 json으로 응답받기
			fetch("check-id.jsp?inputId="+inputId)
			.then(res=>res.json())
			.then(data=>{
				// 일단 is-valid, is-invalid 클래스 제거
				e.target.classList.remove("is-valid", "is-invalid")
				// data는 {canUse:true} 구조의 object
				if(data.canUse){ //사용가능
					e.target.classList.add("is-valid");
					isIdValid=true;
				}else{ //사용가능 X
					e.target.classList.add("is-invalid");
					isIdValid=false;
				}
				checkForm();
			})
		});
		//함수를 미리 만들어서 
		const checkPwd = ()=>{
			
			//비밀 번호를 검증할 정규 표현식(특수문자 포함여부)
			const reg_pwd=/[\W]/;
			
			//양쪽에 입력한 비밀번호를 읽어와서
			let pwd=document.querySelector("#pwd").value;
			let pwd2=document.querySelector("#pwd2").value;
			
			//일단 is-valid 와 is-invalid 클래스를 제거를 먼저하고 
			document.querySelector("#pwd").classList.remove("is-valid", "is-invalid");
			
			//일단 정규표현식을 만족하는지 확인해서 만족하지 않으면 함수를 여기서 종료
			//만일 첫번째 비밀번호가 정규표현식을 통과하지 못하거나 또는 두번째 비밀번호가 정규표현식을 통과하지 못한다면
			if( !reg_pwd.test(pwd) || !reg_pwd.test(pwd2) ){
				document.querySelector("#pwd").classList.add("is-invalid");
				isPwdValid=false;
				checkForm();
				return;
			}
			
			if(pwd == pwd2){
				document.querySelector("#pwd").classList.add("is-valid");
				isPwdValid=true;
			}else{
				document.querySelector("#pwd").classList.add("is-invalid");
				//비밀번호가 유효 하지 않다는 의미에서 false 를 넣어준다.
				isPwdValid=false;
			}
		};	
		//비밀번호 혹은 비밀번호 확인란에 입력했을 때 동일한 함수 호출되도록
		document.querySelector("#pwd").addEventListener("input", checkPwd);
		document.querySelector("#pwd2").addEventListener("input", checkPwd);
		
		
		document.querySelector("#email").addEventListener("input", (e)=>{
			
			//이메일을 검증할 정규 표현식
			const reg_email=/@/;
			
			//입력한 문자열 읽어오기  (e.target 은 이벤트가 발생한 바로 그 요소의 참조값이다)
			const email=e.target.value;
			
			//일단 is-valid 와 is-invalid 클래스를 제거를 먼저하고 
			document.querySelector("#email").classList.remove("is-valid", "is-invalid");
			
			if(reg_email.test(email)){
				document.querySelector("#email").classList.add("is-valid");
				isEmailValid=true;
			}else{
				document.querySelector("#email").classList.add("is-invalid");
				isEmailValid=false;
			}
			checkForm();
		});		
		
	</script>
</body>
</html>