<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>책 검색 결과화면</title>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<script src ="js/infobook.js"></script>
</head>
<body>
<input type="hidden" name="state" value="${param.state}" id="state">
<input type="hidden" name="inf_num" value="${param.num}" id="inf_num">
</body>
</html>