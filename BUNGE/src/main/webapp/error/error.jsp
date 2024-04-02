<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<title>error.jsp</title>
<link href="${pageContext.request.contextPath}/css/join.css" rel="stylesheet" type="text/css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<style>
	body {width:500px; margin:3em auto;}
	div {
		color:orange;
		font-size:30px;
		text-align:center;
	}
	span {font-size:1.5rem; color:#5d5de2}
</style>
<body>
<div>
 <p><img src="${pageContext.request.contextPath}/image/error.png" width="100px"></p>
 <p>죄송합니다.<br>
 	${message}</p>
 	<span>서비스 이용에 불편을 드려 죄송합니다.</span>
</div>
</body>
