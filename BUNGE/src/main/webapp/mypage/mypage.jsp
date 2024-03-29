<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 수정</title>
</head>
<body>
 <jsp:include page="${Context.request.contextPath}/layout/header2.jsp" />
<form name="joinform" action="updateProcess.com" method="post" enctype="multipart/form-data">
	<h3>회원 정보 수정</h3>
		<hr>
	<b>프로필 사진</b>
	<label>
			<img src="image/attach.png" width="10px">
			<%--
			<span id="filename"></span>
			<span id="showImage">
				<c:if test="">
					<c:set var="src" value="image/profile.png" />
				</c:if>
				<c:if test="">
					<c:set var="src" value='"'/>
					<input type="hidden" name="check" value="">
				</c:if>
				<img alt="profile" src="${src}" width="20px">
			</span>
			 --%>
			 <input type="file" name="memberfile" accept="image/*">
		</label>
		<b>닉네임</b>
		<input type="text" name="m_nick" value="${pageinfo.m_nick}">
		
		<b>아이디</b>
		<input type="text" name="m_id" value="${pageinfo.m_id}" readonly>
		
		<b>비밀번호</b>
		<input type="password" name="m_pwd" value="${pageinfo.m_pwd}">
		
		<b>성별</b>
		<div>
			<input type="radio" name="gender" value="남"><span>남</span>
			<input type="radio" name="gender" value="여"><span>여</span>
		</div>
		<b>핸드폰</b>
		<input type="tel" name="m_phone" value="${pageinfo.m_phone}">
		
		<b>이메일 주소</b>
		<input type="text" name="m_email" value="${pageinfo.m_email}">
		
		<div class="clearfix">
		    <button type="submit" class="submitbtn">수정</button>
		    <button type="reset" class="cancelbtn">취소</button>			
		</div>
		</form>
		
</body>
</html>