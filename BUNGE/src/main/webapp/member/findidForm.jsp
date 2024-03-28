<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지</title>
</head>
<body>
		<form name="findid" action="findidProcess.com" method="post">
		<h1>아이디 찾기</h1>
		<b>이름</b>
		<input type="text" name="m_name" placeholder="이름을 입력" maxlength="5" required>
		
		<b>이메일 주소</b>
		<input type="text" name="m_email" placeholder="이메일을 입력" maxlength="30" required>
		
			<div class="clearfix">
			<button type="submit" class="submitbtn">아이디 찾기</button>
			<button type="reset" class="cancelbtn">돌아가기</button> <%--메인화면으로 --%>
		</div>
		</form>
</body>
</html>