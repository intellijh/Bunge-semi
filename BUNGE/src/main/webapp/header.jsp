<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<html>
<head>
<style>
 .navbar-text {
 	font-size:10px;
 }
 
 #navbarSupportedContent {
 	margin-right : 50px;
 }
 

</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/image/logo.png" alt="logo" width="140" height="30" class="d-inline-block align-text-top"></a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">정보공유게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">거래게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">알림</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">프로필사진</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">login/logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>
