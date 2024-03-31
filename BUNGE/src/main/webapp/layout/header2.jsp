<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
    <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/image/logo.png" alt="logo" width="140" height="30" class="d-inline-block align-text-top"></a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="InfoList.com">정보공유게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">거래게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">알림</a>
        </li>
        <c:choose>
        <c:when test="${m_id ==null }">
        <li class="nav-item"><a class="nav-link" href="login.com">로그인</a></li>
        </c:when>
 	<c:when test="${m_id != null}">
	    <li class="nav-item"><a class="nav-link" href="#">프로필사진</a></li>
	 	<li class="nav-item"><a class="nav-link" href="logout.com">${m_id}님 (로그아웃)</a></li>
	    <li class="nav-item"><a class="nav-link" href="mypage.com">마이페이지</a></li>
	     <li class="nav-item"><a class="nav-link" href="#">중고거래</a></li>
	      <li class="nav-item"><a class="nav-link" href="#">리뷰활동</a></li>
 	</c:when>
</c:choose>
       <c:if test="${id == 'admin'}">
     		 <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop"
                       data-toggle="dropdown"> 관리자 </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">회원정보</a>
                        <a class="dropdown-item" href="#">게시판</a>
</div>
     	</c:if>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>
