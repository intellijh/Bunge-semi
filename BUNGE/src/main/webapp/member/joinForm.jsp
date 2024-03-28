<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link href="${pageContext.request.contextPath}/css/join.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src= '${pageContext.request.contextPath}/js/join.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
</head>
<script type="text/javascript">
	/*
	const autophone = (pho) => {
	pho.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
	*/
</script>
<body>
	<form name="joinform" action="joinProcess.com" method="post">
	<h1>회원가입</h1>
	<hr>
		<b>아이디</b>
		<input type="text" name="m_id"  placeholder="아이디 입력 (5~15자)"  min="5" maxlength="15" required>
		<span id="id_message"></span>
		
		<b>비밀번호</b>
		<input type="password" name="m_pwd" placeholder="비밀번호 입력"  maxlength="15">
		<span id="pwd_message"></span>
		
		<b>이름</b>
		<input type="text" name="m_name" placeholder="이름을 입력" maxlength="5" required>
		<span id="name_message"></span>
		
		<b>닉네임</b>
		<input type="text" name="m_nick" placeholder="닉네임을 입력" maxlength="10" required>
		<span id="nick_message"></span>
		
		<b>성별</b>
		<div>
			<input type="radio" name="m_gender"  value='남' ><span>남</span>
			<input type="radio" name="m_gender" value='여'><span>여</span>
		<span id="gender_message"></span>
		</div>
		
		<b>우편번호</b>
		<input type="text" maxlength="5" name="m_zipcode"  required readonly>
		
		<input type="button" value="우편검색" name="postcode">
		<span id="zipcode_message"></span>
		
		<b>주소</b>
		<input type="text" size="50"  name="m_addr1" required readonly>
		<span id="addr1_message"></span>
		<b>상세주소</b>
		<input type="text" size="200" name="m_addr2" required>
		<span id="addr2_message"></span>
		
		<b>핸드폰</b>
			<input type="tel" name="m_phone" maxlength="11" placeholder="핸드폰번호 입력('-' 제외 11자리 입력)"  
				required>
		<span id="pho_message"></span>
		
		<b>이메일 주소</b>
		<input type="text" name="m_email" placeholder="이메일을 입력" maxlength="30" required>
		<span id="email_message"></span>
		
		<b>생년월일</b>
		<input type="date" name="m_birthdate" min="1900-01-01" required>
		<span id="birth_message"></span>
		<div class="clearfix">
			<button type="submit" class="submitbtn">회원가입</button>
			<button type="reset" class="cancelbtn">돌아가기</button> <%--메인화면으로 --%>
		</div>
	</form>
</body>
</html>