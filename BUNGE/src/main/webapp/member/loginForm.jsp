<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>로그인 페이지</title>
<link href="${pageContext.request.contextPath}/css/Common.css" type="text/css" rel="stylesheet" >
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<jsp:include page="/layout/header.jsp" />
<style>

.login{
    position:relative;
    top: 150px;;
    width: 450px;
    height: 400px;
    margin: 0 auto;
}
.login_loge{
   text-align: center;
}
.login_id{
    position: relative;
    left: 100px;
    margin: 10px auto; 

}
.login input[name=m_id], input[name=m_pwd] {
    width: 250px;
    height: 40px;
}
.login_pwd{
    position: relative;
    left: 100px;
    margin: 10px auto; 

}

.login_check{
    position: relative;
    left: 100px;
    padding-bottom: 25px;
}

.btn {
    position: relative;
    left: 88px;
    display: inline;
    padding-right: 12px;
    text-align: center;
    color: #fff;
    border : none;
    }
button {
 	border: none;
}
.submit1 , .join1 {
    width: 110px;
    height: 45px;
    background-color: D0ED8D;
}
.clearfix {
    padding-bottom: 15px;
}
.findidbtn , .findpwdbtn{
    width: 250px;
    height: 45px;
    background-color: D0ED8D;
}

.find{
    position: relative;
    left: 100px; 
}
.findid{
    padding-bottom: 15px;
}
.login_loge {
padding-bottom: 20px;
}
</style>
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
	 <img alt="logo" src="${pageContext.request.contextPath}/image/logo.png">
	  </div>
	  
	 <div class="login_id">
	  <input type="text" name="m_id" placeholder="아이디 입력" required>
  	</div>
  	
  	<div class="login_pwd">
	  <input type="password" name="m_pwd" placeholder="비밀번호 입력" required>
	  </div>
	  
	  <div class="login_check">
	  <input type="checkbox" id="checkid"  name="checkid" value="store">
	  
	  <span>아이디저장</span>
	  </div>
		<div class="clearfix">
			<div class="submit btn">
				<button type="submit" class="submit1">로그인</button>
			</div>

			<div class="join btn">
				<button type="button" class="join1">회원가입</button>
			</div>
		</div>	
	<div class="find">
		<div class="findid">
		<a href="findid.com"><button type="button" class="findidbtn">아이디 찾기</button></a>
	</div>
	<div class="findpwd">
		<a href="findpwd.com"><button type="button" class="findpwdbtn">비밀번호찾기</button></a>
	</div>
	</div>
  </div>
</form>
</div>
</body>
</html>