<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>
	<h1>비밀번호 재설정</h1>
	<form name="pwdreset" action="pwdreset.com" method="post">
	<b>비밀번호</b>
		<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
		
		<b>비밀번호 확인</b>
		<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
		<div class="clearfix">
			<button type="submit" class="submitbtn">로그인 페이지로 이동</button>
		</div>
		</form>
</body>
</html>