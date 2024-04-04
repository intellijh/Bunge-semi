<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>메인 페이지</title>
</head>
<body>
<jsp:include page="/layout/header.jsp" />
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/mainpage.js"></script>
  <style>
  /* Make the image fully responsive */
  .carousel-inner img {
    width: 33%;
    height: 50%;
  }
  </style>
</head>
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
      <img src="${pageContext.request.contextPath}/image/sample4.jpg" alt="Los Angeles" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles" width="300" height="500">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Los Angeles" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles" width="300" height="500">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/image/sample9.png" alt="Los Angeles" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample5.png" alt="Los Angeles" width="300" height="500">
      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Chicago" width="300" height="500">
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

</body>
</html>