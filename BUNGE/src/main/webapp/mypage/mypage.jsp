<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 수정</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/mypage.js"></script>
<style>
input[type=file]{display: none;}
</style>
</head>
<body>
<div id="wrap">
<div class="tab_container">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
		   <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>즐겨찾기</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>중고거래 찜</span></li></a>
		  </ul>
		</div>
<form name="changeform" action="mypagechange.com" method="post" enctype="multipart/form-data">
	<h3>회원 정보 수정</h3>
		<hr>
		<div class="m_profile">
		<b>프로필 사진</b>
		<label>
			<img src="image/attach.png" width="10px">
			<span id="filename">${memberinfo.member.m_profile}</span>
			<span id="showImage">
					<c:set var="src" value='${"memberupload/"}${memberinfo.member.m_profile}'/>
					<input id="check"  type="hidden" name="check"  value="${memeberinfo.member.m_profile }">
				<img alt="profile" src="${src}" width="20px">
			</span>
			 <input type="file" name="m_profile" accept="image/*">
		</label>
		</div>
		
		<div class="m_id">
			<b>아이디</b>
			<input type="text" name="m_id" value="${memberinfo.member.m_id}" readonly>
		</div>
		
		<div class="m_pwd">
		<b>비밀번호</b>
			<input type="password" name="m_pwd" maxlength="15"  value="${memberinfo.member.m_pwd}" readonly>
			<button type="button" id="pwdchange">수정</button>
			<span id="pwd_message"></span>
		</div>	
		
		<div class="m_name">
		<b>이름</b>
			<input type="text" name="m_name" value="${memberinfo.member.m_name}" readonly>
		</div>
		
		<div class="m_nick">
		<b>닉네임</b>
			<input type="text" name="m_nick" value="${memberinfo.member.m_nick}" >
			<button type="button" id="nickchange">수정</button>
			<span id="nick_message"></span>
		</div>
		
		<div class="m_gender">
		<b>성별</b>
			<input type="radio" name="gender" value="남" readonly><span>남</span>
			<input type="radio" name="gender" value="여" readonly><span>여</span>
		</div>
		
		<div class="m_zipcode">
			<b>우편번호</b>
			<input type="text" maxlength="5" name="m_zipcode" value="${memberinfo.member.m_zipcode}" required readonly>
			
			<input type="button" value="우편수정" name="postcode" >
			<span id="zipcode_message"></span>
		</div>
		
		<div class="m_addr1">
			<b>주소</b>
			<input type="text" size="50"  name="m_addr1"  value="${memberinfo.member.m_addr1}" required readonly>
			<span id="addr1_message"></span>
		</div>
		
		<div class="m_addr2">
			<b>상세주소</b>
			<input type="text" size="50" name="m_addr2" value="${memberinfo.member.m_addr2}" required>
			<span id="addr2_message"></span>
		</div>
		
		<div class="m_phone">
			<b>핸드폰</b>
			<input type="tel" name="m_phone" maxlength="11" value="${memberinfo.member.m_phone}">
			<button type="button" id="phonechange">수정</button>
			<span id="pho_message"></span>
		</div>
		
		<div class="m_email">
			<b>이메일 주소</b>
			<input type="text" name="m_email" value="${memberinfo.member.m_email}">
			<button type="button" id="emailchange">수정</button>
			<span id="email_message"></span>
		</div>
		
		<div class="clearfix">
		    <button type="submit" class="submitbtn">수정완료</button>
		    <button type="reset" class="cancelbtn">취소</button>			
		</div>
		</form>
		</div>
	</div>
</body>
</html>