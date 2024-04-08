<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <script src= '${pageContext.request.contextPath}/js/pwdreset.js'></script>
    <jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<style>
.pwdreset {
	position: relative;
    top: 150px;
    width: 450px;
    height: 400px;
    margin: 0 auto;
}
.pwdreset h2 {
	padding-bottom: 20px;
}
.pwd {
	position: relative;
    left: 68px;
    margin: 10px auto;
}
.pwd b {
	padding-right: 39px;
}
.pwdcheck {
	position: relative;
    left: 68px;
    margin: 10px auto;
}
.pwd input, .pwdcheck input {
	width: 250px;
}
.message {
	font-size: 12px;
}
.submit {
	padding-top:15px;
    position: relative;
 	left: 162px;

}
.submitbtn {
	background-color: D0ED8D;
    width: 175px;
    height: 40px;
    border: solid 1px rgba(212, 216, 229, .5);
    border-radius: 4px;
}
</style>
</head>
<body>
<div id="warp">
	<h2>비밀번호 재설정</h2>
	<form name="pwdreset" action="pwdreset.com" method="post">
	<div class="pwdreset">
	<div class="pwd">
	<b>비밀번호</b>
		<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
		<div class="message">
		<span id="pwd_message"></span>
		</div>
		</div>
		<div class="pwdcheck">
		<b>비밀번호 확인</b>
		<input type="password" name="m_pwd_check" placeholder="비밀번호 재입력"  maxlength="15">
		<div class="message">
		<span id="pwd_check_message"></span>
		</div>
		</div>
		<div class="submit btn">
			<button type="submit" class="submitbtn">비밀번호 재설정 완료</button>
		</div>
		</div>
		</form>
		</div>
</body>
</html>