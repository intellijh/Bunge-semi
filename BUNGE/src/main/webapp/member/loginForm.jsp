<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>로그인 페이지</title>
<link href="${pageContext.request.contextPath}/css/login.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/login.js"></script>

</head>
<body>
<form name="loginform"  action="loginProcess.com"  method="post">
  <h1>로그인</h1>
  <hr>
  <b>아이디</b>
  <input type="text" name="m_id" placeholder="Enter id" required>
  
  <b>비밀번호</b>
  <input type="password" name="m_pwd" placeholder="Enter passwrod" required>
  <input type="checkbox"  name="checkid" value="store">
  <span>아이디저장</span>
<a href="findid.com"><button type="button" class="findidbtn">아이디 찾기</button></a>
<a href="findpwd.com"><button type="button" class="findpwdbtn">비밀번호찾기</button></a>
	
  
  <div class="clearfix">
    <button type="submit" class="submitbtn">로그인</button>
    <button type="button" class="join">취소</button>
  </div>
</form>
</body>
</html>