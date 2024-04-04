<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>로그인 페이지</title>
<link href="${pageContext.request.contextPath}/css/Common.css" type="text/css" rel="stylesheet" >
<link href="${pageContext.request.contextPath}/css/login.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<jsp:include page="/layout/header.jsp" />
<script>
$(function() {
	$(".join").click(function () {
		location.href = "index.jsp";
	});
//아이디 저장
	const m_id = '${cookie_id}';
	if (m_id) {
		$("input[name=m_id]").val(m_id);
		$("#checkid").prop('checked', true);
	}
});
</script>
</head>
<body>
<div id="warp">
<form name="loginform"  action="loginProcess.com"  method="post">
<div class="login">
	<div class="login_loge">
	  <h1>로고 이미지</h1>
	  </div>
	  
	 <div class="login_id">
	  <b>아이디</b>
	  <input type="text" name="m_id" placeholder="아이디 입력" required>
  	</div>
  	
  	<div class="login_pwd">
	  <b>비밀번호</b>
	  <input type="password" name="m_pwd" placeholder="비밀번호 입력" required>
	  </div>
	  
	  <div class="login_check">
	  <input type="checkbox" id="checkid"  name="checkid" value="store">
	  <span>아이디저장</span>
	  </div>
	  <div class="findid">
		<a href="findid.com"><button type="button" class="findidbtn">아이디 찾기</button></a>
		</div>
		
		<div class="findpwd">
		<a href="findpwd.com"><button type="button" class="findpwdbtn">비밀번호찾기</button></a>
		</div>
	  
	  <div class="clearfix">
	    <button type="submit" class="submitbtn">로그인</button>
	    <button type="button" class="join">취소</button>
  	</div>
  </div>
</form>
</div>
</body>
</html>