<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/header.jsp" />
<title>아이디 찾기 결과 페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<style>
.idcomplete {
    position: relative;
    top: 150px;
    width: 450px;
    height: 400px;
    margin: 0 auto;
    text-align: center;
}
.idcomplete h3 {
	padding-bottom: 15px;
}
.submit {
	padding-top: 15px;
}
.submitbtn {
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
	<form  name="idcomplete" method="post" action="login.com">
	<div class="idcomplete">
		<h3>아이디 찾기 결과 페이지</h3>
	<c:choose>
	<c:when test="${empty m_id}">
		<p>해당 아이디 정보는 존재하지 않습니다.</p>
	</c:when>
		<c:when test="${!empty m_id}">
			<p>회원가입시 사용하신 아이디는 ${find_id} 입니다.</p>
		</c:when>
	</c:choose>
	<div class="submit btn">
		<button type="submit"  class="submitbtn">로그인페이지</button>
		</div>
		</div>
	</form>
</div>
</body>
</html>