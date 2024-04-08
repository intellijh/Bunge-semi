<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src= '${pageContext.request.contextPath}/js/join.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<style>
 body {
    margin: 0 auto;
    line-height: 28px;
}
.member {
 position:relative;
    width: 800px;
    height: 400px;
    margin: 0 auto;
}
.join {
    position: relative;
    left: 200px;
    width: 400px;
    height: 60px;
    margin: 5px;
}
.join input {
    width: 250px;
}
.message {
	font-size: 12px;
}

.jointitle {
   border-bottom: 1px solid rgba(212, 216, 229, .5);
    width: 1140px;
    position: relative;
    top : 20px;
    padding-bottom: 30px;
}

.jointitle h2{
	position: relative;
    width: 1040px;
    left: 182px;
}
.member {
padding-top : 38px
}
.m_id b {
	padding-right: 16px;
}
.m_name b {
    padding-right: 30px;
}
.m_nick b {
    padding-right: 16px;
}
.m_gender {
    height: 40px;
}
.m_gender input{
  width: 15px;
}
.m_gender span {
    padding: 5px;
}
.m_gender b {
    padding-right: 30px;
}
.m_zipcode input {
    width: 80px;
}
.m_addr1, .m_addr2 , .m_phone , .m_email{
    width: 500px;
}
.m_addr1 input, .m_addr2 input, .m_phone input  {
    width: 380px;
}
.m_addr1 b {
    padding-right: 30px;
}
.m_phone b{
    padding-right: 16px;
}
.m_email input {
    width: 358px;
}
.clearfix {
 	position: relative;
    left: 220px;
    padding-top: 15px;
}
.submitbtn {
	background-color: D0ED8D;
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
</head>
<body>
<div id="warp">
	<form name="joinform" action="joinProcess.com" method="post">
	<div class="jointitle">
	<h2>회원가입</h2>
	</div>
	<div class="member">
	<div class="join m_id">
			<b>아이디</b>
			<input type="text" name="m_id"  placeholder="아이디 입력 (5~15자)"  min="5" maxlength="15" required>
			<div class="message">
				<span id="id_message"></span>
			</div>
		</div>
		
		<div class="join m_pwd">
			<b>비밀번호</b>
			<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
			<span id="pwd_message"></span>
		</div>
		
		<div class="join m_name">
			<b>이름</b>
			<input type="text" name="m_name" placeholder="이름을 입력" maxlength="5" required>
			<div class="message">
			<span id="name_message"></span>
			</div>
		</div>
		
		<div class="join m_nick">
			<b>닉네임</b>
			<input type="text" name="m_nick" placeholder="닉네임을 입력" maxlength="10" required>
			<div class="message">
				<span id="nick_message"></span>
			</div>
		</div>
		
		<div class="join m_gender">
		<b>성별</b>
			<input type="radio" name="m_gender"  value='남' ><span>남</span>
			<input type="radio" name="m_gender" value='여'><span>여</span>
		<div class="message">
			<span id="gender_message"></span>
		</div>
		</div>
		
		<div class="join m_zipcode">
			<b>우편번호</b>
			<input type="text" maxlength="5" name="m_zipcode"  required readonly>
			
			<input type="button" value="우편검색" name="postcode">
			<div class="message">
				<span id="zipcode_message"></span>
			</div>
		</div>
		
		<div class="join m_addr1">
			<b>주소</b>
			<input type="text" size="50"  name="m_addr1" required readonly>
			<div class="message">
				<span id="addr1_message"></span>
				</div>
		</div>
		
		<div class="join m_addr2">
			<b>상세주소</b>
			<input type="text" size="200" name="m_addr2" required>
			<span id="addr2_message"></span>
		</div>
		
		<div class="join m_phone">
			<b>핸드폰</b>
				<input type="tel" name="m_phone" maxlength="11" placeholder="핸드폰번호 입력('-' 제외 11자리 입력)"  
					required>
			<div class="message">
				<span id="pho_message"></span>
			</div>
		</div>
		
		<div class="join m_email">
			<b>이메일 주소</b>
			<input type="text" name="m_email" placeholder="이메일을 입력" maxlength="30" required>
			<div class="message">
				<span id="email_message"></span>
			</div>
		</div>
		
		<div class="join m_birthdate">
			<b>생년월일</b>
			<input type="date" name="m_birthdate" min="1900-01-01" required>
			<div class="message">
				<span id="birth_message"></span>
			</div>
		</div>
		
		<div class="clearfix">
		<div class="submit btn">
			<button type="submit" class="submitbtn">회원가입</button>
			</div>
			<div class="reset btn">
			<button type="reset" class="cancelbtn">돌아가기</button> <%--메인화면으로 --%>
			</div>
		</div>
		</div>
	</form>
	</div>
</body>
</html>