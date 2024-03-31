<%@ page language="java" contentType="text/html; charset=UTF-8"%>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <script src= '${pageContext.request.contextPath}/js/pwdreset.js'></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style>
span {
	display: inline-block;
	font-size: 10px;
}
</style>
</head>
<body>
	<h1>비밀번호 재설정</h1>
	<form name="pwdreset" action="pwdreset.com" method="post">
	<b>비밀번호</b>
		<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
		<span id="pwd_message"></span>
		
		<b>비밀번호 확인</b>
		<input type="password" name="m_pwd_check" placeholder="비밀번호 재입력"  maxlength="15">
		<span id="pwd_check_message"></span>
		<div class="clearfix">
			<button type="submit" class="submitbtn">비밀번호 재설정 완료</button>
		</div>
		</form>
</body>
</html>