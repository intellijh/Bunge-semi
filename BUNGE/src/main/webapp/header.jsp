<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<html>
<head>
</head>
<body>
<nav class="navbar bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar=barnd" href="#">
      <img src="${pageContext.request.contextPath}/image/logo.png" alt="logo" width="140" height="30" class="d-inline-block align-text-top">
    </a>
    <span class="navbar-text"><a class="nav-link">정보공유게시판</a></span>
    <span class="navbar-text"><a class="nav-link">거래게시판</a></span>
    <span class="navbar-text"><a class="nav-link">알림</a></span>
    <span class="navbar-text"><a class="nav-link">프로필사진</a></span>
    <span class="navbar-text"><a class="nav-link">login/logout</a></span>
  </div>
</nav>

</body>
</html>