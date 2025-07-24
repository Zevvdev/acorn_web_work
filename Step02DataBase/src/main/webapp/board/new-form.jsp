<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/new-form.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
<!-- Toast UI Editor CSS -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<!-- Toast UI Editor JS -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<!-- 한국어 번역 파일 추가 -->
<script src="https://uicdn.toast.com/editor/latest/i18n/ko-kr.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/include/navbar.jsp">
		<jsp:param value="new-form" name="thisPage"/>
	</jsp:include>
	<div class="container">
		<h1>게시글 작성 양식</h1>
		<form action="save.jsp" method="post" id="saveForm">
			<div class="mb-2">
				<label class="form-label" for="title">제목</label>
				<input class="form-control" type="text" name="title" id="title" />			
			</div>
			<div class="mb-2">
				<label class="form-label" for="editor">내용</label>
				<!-- Editor ui 가 출력될 div -->
				<div id="editor"></div>
				<textarea class="form-control" name="content" id="hiddenContent"></textarea>
			</div>
			<button class="btn btn-success btn-sm" type="submit">save</button>
		</form>
	
	</div>
	<script>
		// 위에 toast ui javascript 가 로딩되어있으면 toastui.Editor 클래스 사용 가능
		// 해당 클래스 이용해서 객체 생성하면서 {} object 로 ui 관련된 옵션 잘 전달하면
		// 우리가 원하는 모양의 텍스트 편집기를 만들 수 있다.
		const editor = new toastui.Editor({
			el: document.querySelector(' #editor'),
			height: '500px',
			initialEditType: 'wysiwyg',
			previewStyle: 'vertical',
			language: 'ko'
		});
		
		document.querySelector("#saveForm").addEventListener("submit", (e)=>{
			// 에디터로 작성된 문자열 읽어오기
			const content = editor.getHTML();
			// 테스트로 콘솔에 출력하기
			console.log(content);
			//에디터로 작성된 문자열을 폼 전송이 될 수 있도록 textarea의 value 값으로 넣어준다
			document.querySelector("#hiddenContent").value=content;
			// 테스트하기 위해 폼 전송 막기, 막지 않으면->전송
			//e.preventDefault();
		})
	</script>
</body>
</html>