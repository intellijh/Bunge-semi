<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과 페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
</head>
<body>

	<form  name="idcomplete" method="post" action="login.com">
		<h1>아이디 찾기 결과 페이지</h1>
	<c:choose>
		<c:when test="${!empty m_id}">
			
			<p>회원가입시 사용하신 아이디는 ${find_id} 입니다.</p>
		</c:when>
	</c:choose>
		<button type="submit" >로그인페이지</button>
	</form>

</body>
</html>