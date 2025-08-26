<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/new-form.jsp</title>
<jsp:include page="/WEB-INF/include/resource.jsp"></jsp:include>
<style>
    .drop-zone {
        border: 2px dashed #0d6efd;
        cursor: pointer;
        border-radius: 10px;
        background-color: #f8f9fa;
        display:flex;
        align-items: center;
        justify-content: center;
        height: 200px;
        
    }
    /* drop zone 에 파일을 드래그해서 올렸을 때 css */
    .drop-zone.dragover {
        background-color: #e9ecef;
    }
    .preview img {
        max-width: 120px;
        margin: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .preview-item {
        position: relative;
        display: inline-block;
    }
	.remove-btn {
	    position: absolute;
	    top: 11px;
	    right: 11px;
	    background-color: #ffffffcc; /* 반투명 흰색 */
	    color: #333;
	    border: none;
	    border-radius: 4px;
	    width: 20px;
	    height: 20px;
	    font-size: 16px;
	    cursor: pointer;
	    text-align: center;
	    transition: background-color 0.2s, color 0.2s;
	    box-shadow: 0 1px 4px rgba(0,0,0,0.2);
	    display: flex;
		align-items: center;
		justify-content: center;
	}
	
	.remove-btn:hover {
	    background-color: #dc3545;
	    color: white;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/include/navbar.jsp">
    <jsp:param name="thisPage" value="gallery"/>
</jsp:include>
<div class="container mt-4">
    <h2><i class="bi bi-image"></i> 새 갤러리 작성</h2>
    <form action="${pageContext.request.contextPath }/gallery/save" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="6" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">이미지 업로드 (Drag & Drop 또는 클릭)</label>
            <div class="drop-zone" id="dropZone">
                이곳에 이미지를 끌어다 놓거나 클릭하여 선택하세요.
                <input type="file" name="images" id="fileInput" multiple hidden>
            </div>
            <div class="preview d-flex flex-wrap mt-3" id="preview"></div>
        </div>

        <button type="submit" class="btn btn-primary">등록</button>
    </form>
</div>

<script>
    const dropZone = document.querySelector("#dropZone");
    const fileInput = document.querySelector("#fileInput");
    const preview = document.querySelector("#preview");

    let selectedFiles = [];
	
    // dropzone을 클릭했을 떄 input type="file"을 강제 클릭해서 파일 선택창이 열리도록
    dropZone.addEventListener("click", () => fileInput.click());
    
 	// drop zone에 마우스 드래그해서 들어갔을 때
    dropZone.addEventListener("dragover", (e) => {
    	e.preventDefault();
      	//dragover 클래스 추가하여 회색으로 변경되도록
        dropZone.classList.add("dragover");
    });
	
 	// dropzone 에 마우스 드래그해서 나갔을 때
    dropZone.addEventListener("dragleave", () => {
    	// dragover 클래스 제거하여 원래 색상으로 돌아가도록
        dropZone.classList.remove("dragover");
    });

    // 파일 끌어다가 drop했을 때
    dropZone.addEventListener("drop", (e) => {
        e.preventDefault();
        dropZone.classList.remove("dragover");
        // 선택된 파일객체가 들어있는 배열 -변경-> 기능 모두 쓸 수 있는 배열
        const files = Array.from(e.dataTransfer.files);
        // 기존에 선택한 파일이 들어있는 배열에 합친다.
        selectedFiles = selectedFiles.concat(files);
        // preview 를 업데이트(미리보기)
        updatePreview();
    });
	
    // drag drop 이 아니고 파일을 직접 선택했을 때 input type="file"에 change 이벤트 발생
    fileInput.addEventListener("change", () => {
    	// 위와 동일한 동작
        const files = Array.from(fileInput.files);
        selectedFiles = selectedFiles.concat(files);
        updatePreview();
    });

    // preview을 업데이트하는 함수(내부에서 await 이 있는 비동기 함수기 때문에 async 키워드 붙여서 만듬)
    async function updatePreview() {
    	// 이미 출력된 이미지를 모두 없애고
        preview.innerHTML = "";
	
    	// input type = "file" 에 value를 넣어줄 정보 구성하기 위한 객체
        const dataTransfer = new DataTransfer();
    	
		// 반복문 돌면서 선택된 파일 객체를 순서대로 참조
        for (let i = 0; i < selectedFiles.length; i++) {
        	// i번째 파일 객체 불러와서
            const file = selectedFiles[i];
        	// 만일 이미지 파일 아니라면 continue (for 문 계속 실행--contine 밑 코드 실행x-건너뛰고)
            if (!file.type.startsWith("image/")) continue;

            try {
            	// 선택한 이미지 파일을 읽어들여서 결과 얻어내기
            	// promise 객체가 resolve될 때까지 기다림
                const imageUrl = await readFileAsDataURL(file);  

                const container = document.createElement("div");
                container.classList.add("preview-item");

                const img = document.createElement("img");
                img.setAttribute("src", imageUrl);

                const btn = document.createElement("button");
                btn.classList.add("remove-btn");
                btn.innerText = "×";
                
                btn.addEventListener("click", () => {
                	// selectedFiles 배열에서 i번째 방으로부터 1개의 item 삭제
                    selectedFiles.splice(i, 1);
                	// 삭제 후 preview 가 다시 update 되도록 함수 호출
                    updatePreview();
                });

                container.insertAdjacentElement("beforeend", img);
                container.insertAdjacentElement("beforeend", btn);
                preview.insertAdjacentElement("beforeend", container);
				// DataTransfer 객체에 파일객체 추가
                dataTransfer.items.add(file);
            } catch (err) {
                console.error("이미지 로딩 실패:", err);
            }
        }
		// 선택한 파일객체가 들어있는 배열을 input type="file"의 value로 넣어주기
        fileInput.files = dataTransfer.files;
    }

    // 전달된 파일을 읽어들이는 Promise 객체 리턴해주는 함수
    function readFileAsDataURL(file) {
        return new Promise((resolve, reject) => {
        	// FileReader 객체를 이용해서 파일 읽어들이고
            const reader = new FileReader();
        	// 모두 다 읽었을 때 실행할 함수 등록
            reader.onload = () => resolve(reader.result);
            reader.onerror = reject;
            reader.readAsDataURL(file);
        });
    }
    
    // 폼에 "submit" 이벤트가 일어났을 때 실행할 함수
    document.querySelector("#saveForm").addEventlistener("submit", (e)=>{
    	//여기서 폼 입력란에 대한 검증을 하고 폼 제출을 막고 싶으면 e.preventDefault()를 실행하게 하면 된다.
    	
    	//만일 선택한 파일이 없다면
    	if(selectedFiles.length < 1){
    		alert("업로드할 이미지를 1개 이상 선택해주세요.")
    		e.preventDefault();
    	}
    });
    
</script>

</body>
</html>