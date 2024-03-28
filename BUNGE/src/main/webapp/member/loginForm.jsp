<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>로그인 페이지</title>
<link href="${pageContext.request.contextPath}/css/login.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>

<script>
$(function() {
	$(".join").click(function () {
		location.href = "join.net";
	});
	
	const id = '${cookie_id}';
	if (id) {
		$("#id").val(id);
		$("#remember").prop('checked', true);
	}
})
</script>
</head>
<body>
<form name="loginform" action="loginProcess.com" method="post">
  <h1>로그인</h1>
  <hr>
  <b>아이디</b>
  <input type="text" name="m_id" placeholder="Enter id" required>
  
  <b>Password</b>
  <input type="password" name="m_pwd" placeholder="Enter passwrod" required>
  <input type="checkbox" id="remember" name="remember" value="store">
  <span>아이디저장</span>
  
  <div class="clearfix">
    <button type="submit" class="submitbtn">로그인</button>
    <a href=""><button type="button" class="join">취소</button></a>
  </div>
</form>
</body>
</html>