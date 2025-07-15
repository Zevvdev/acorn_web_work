<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//DB에 저장되어 있었던 정보라고 가정하자
	String nickName="짱구";
	boolean isMan=true;
	String gender="man";
	String job="developer";
	//DB 에 저장되있다 가정
	String comment="날씨 더워유 \n 습하구,, \n 집에 가고싶어유...";
	String hobbys="[\"game\", \"music\", \"golf\"]";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/jsp/test.05.jsp</title>
</head>
<body>
	<h1>어떤 정보를 수정하는 폼</h1>
	<p>
	최초 출력할 때는 DB에 저장된 정보를 이용해서 여러가지 form 요소들을 출력한다. 
	</br>
		<strong><%=gender.equals("man") ? "checked":"" %></strong>
		<strong><%=isMan ? "checked":"" %></strong>
	</p>
	<form action="update.jsp" method="get">
		<div>
			<label for="nick">닉네임</label>
			<input type="text" name="nick" id="nick" value="<%=nickName %>"/>		
		</div>
		<fieldset>
			<legend>성별</legend>
			<label>
				<input type="radio" name="gender" value="man" <%if(isMan){%>checked<%} %> />남자
			</label>
			<label>
				<input type="radio" name="gender" value="woman" />여자
			</label>
			
		</fieldset>
		<div>
			<label for="job">직업</label>
			<select name="job" id="job">
				<option value="student" <%=job.equals("student") ? "selected" : ""%>>학생</option>
				<option value="developer">개발자</option>
				<option value="etc">기타</option>
			</select>
		</div>
		<div>
			<label for="comment">하고싶은말</label>
			<textarea name="comment" id="comment" rows="5"><%=comment %></textarea>
		</div>
		<fieldset>
			<legend>취미(여러 개 선택 가능)</legend>
			<label>
			<input type="checkbox"	name="hobby" value="game" <%=hobbys.contains("game") ? "checked":"" %>/> 게임
			</label>
			<label>
			<input type="checkbox"	name="hobby" value="sports" <%=hobbys.contains("sports") ? "checked":"" %>/> 스포츠
			</label>
			<label>
			<input type="checkbox"	name="hobby" value="music" <%=hobbys.contains("music") ? "checked":"" %>/>음악
			</label>
		</fieldset>
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	
	</form>

</body>
</html>