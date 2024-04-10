<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
<jsp:include page="/layout/header.jsp" />
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<style>
.findpwd {
    position: relative;
    top: 150px;
    width: 450px;
    height: 400px;
    margin: 0 auto;
}
.findpwd h2 {
  padding-bottom: 20px;
}
.find_name{
	position: relative;
    left: 68px;
    margin: 10px auto;
}
.find_id {
	position: relative;
    left: 53px;
    margin: 10px auto;
}
.find_name input , .find_id input, .find_email input {
	width: 250px;
}
.find_email {
	position: relative;
    left: 15px;
    margin: 10px auto;
}
.clearfix {
	padding-top:15px;
    position: relative;
    left: 67px;
}
.submitbtn {
	background-color: #D0ED8D;
    width: 140px;
    height: 40px;
    border: solid 1px rgba(212, 216, 229, .5);
    border-radius: 4px;
}
.cancelbtn {
	background-color: D0ED8D;
    width: 140px;
    height: 40px;
    border: solid 1px rgba(212, 216, 229, .5);
    border-radius: 4px;
}
</style>
<script>
$(function(){
	$(".cancelbtn").click(function () {
	location.href = "login.com";
	});
});
</script>
</head>
<body>
<div id="warp">
	<form name="findpwd" action="findpwdProcess.com" method="post">
		<div class="findpwd">
		<div class="findpwdtitle">
			<h2>비밀번호 찾기</h2>
		</div>
		<div class="find_id">
			<b>아이디</b>
			<input type="text" name="m_id"  placeholder="아이디 입력 (5~15자)"  min="5" maxlength="15" required>
		</div>
		<div class="find_name">
			<b>이름</b>
			<input type="text" name="m_name" placeholder="이름을 입력" maxlength="5" required>
		</div>
		<div class="find_email">
			<b>이메일 주소</b>
			<input type="text" name="m_email" placeholder="이메일을 입력" maxlength="30" required>
		</div>
		<div class="clearfix">
		<div class="submit btn">
			<button type="submit" class="submitbtn">비밀번호 찾기</button>
			</div>
			<div class="reset btn">
			<button type="reset" class="cancelbtn">로그인 돌아가기</button> <%--메인화면으로 --%>
			</div>
		</div>
		</div>
	</form>
	</div>
</body>
</html>