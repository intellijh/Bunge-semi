<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<jsp:include page="/layout/header.jsp" />
<title>메인 페이지</title>
<script src="${pageContext.request.contextPath}/js/mainpage.js"></script>
<style>
  .carousel-inner img {
    width: 32.99%;
    height: 40%;
  }
  </style>
<body>

<div class="container mt-3">

<div id="myCarousel" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${pageContext.request.contextPath}/image/sample4.jpg" alt="Los Angeles">
      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
      <img src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Los Angeles">
      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
      <img src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/image/sample9.png" alt="Los Angeles">
      <img src="${pageContext.request.contextPath}/image/sample5.png" alt="Los Angeles">
      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Chicago">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#myCarousel" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

</div>

</body>
</html>