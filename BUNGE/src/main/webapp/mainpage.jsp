<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<jsp:include page="/layout/header.jsp" />
<title>메인 페이지</title>
<script src="${pageContext.request.contextPath}/js/mainpage.js"></script>
<style>
  body {
    font-family : emoji;
  }
  .carousel-inner img {
    width: 19.5%;
    height: 300px;
  }

  .mt-3 {
    margin-top : 0 !important
  }
  
  .p-3 {
    padding: 1rem!important;
  }


  #myCarousel {
  	height : 300px;
  }
  
  #myCarousel > div {
  	height : 100%;
  }
  
  
  body > main {
    position : relative;
    top : 30px
  }

<%-- 3번 영역 --%>
  .tagcount {
    width : auto;
  	padding-bottom : 10px;
  	font-size : 10px;
  }
  
  .popularcover {
    width : 100px;
  }
  
  .mb-0 {
    width : 100px;
    display : inline-block;
  }
  
  .bg-light {
  	border : 1px solid #dee2e6 !important;
  }
  
  body > main > div > aside > div:nth-child(1) > h4 {
    border-bottom : 1px solid #dee2e6 !important;
  }
<%-- 3번 영역 --%>


</style>
<body>
<%-- 슬라이드 이미지 --%>
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
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	    </div>
	    <div class="carousel-item">
	      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Los Angeles">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	      <img src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	    </div>
	    <div class="carousel-item">
	      <img src="${pageContext.request.contextPath}/image/sample9.png" alt="Los Angeles">
	      <img src="${pageContext.request.contextPath}/image/sample5.png" alt="Los Angeles">
	      <img src="${pageContext.request.contextPath}/image/sample6.png" alt="Chicago">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
	      <img src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago">
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
<%-- 슬라이드 이미지 끝 --%>



<%-- 슬라이드 이미지 아래 메인 시작 --%>   
<main role="main" class="container">
  <div class="row">
    <div class="col-md-8 blog-main">
    
<%-- Best Sharing1(이미지 오른쪽) 시작 --%>
	<div class="container mt-3">
	  <div class="media border p-3">
	    <div class="media-body">
	      <h4>John Doe <small><i>2024/03/02</i></small></h4>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	      <p>좋아요</p>
	      <p>댓글 수</p>       
	    </div>
	    <img src="https://image.aladin.co.kr/product/29125/5/cover/8965965047_1.jpg" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
	  </div>
	</div>
<%-- Best Sharing1 끝 --%>

<%-- Best Sharing3(이미지 오른쪽) 시작 --%>
	<div class="container mt-3">
	  <div class="media border p-3">
	    <div class="media-body">
	      <h4>John Doe <small><i>2024/03/02</i></small></h4>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	      <p>좋아요</p>
	      <p>댓글 수</p>       
	    </div>
	    <img src="https://image.aladin.co.kr/product/29125/5/cover/8965965047_1.jpg" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
	  </div>
	</div>
<%-- Best Sharing3 끝 --%>

<%-- Best Sharing3(이미지 오른쪽) 시작 --%>
	<div class="container mt-3">
	  <div class="media border p-3">
	    <div class="media-body">
	      <h4>John Doe <small><i>2024/03/02</i></small></h4>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	      <p>좋아요</p>
	      <p>댓글 수</p>       
	    </div>
	    <img src="https://image.aladin.co.kr/product/29125/5/cover/8965965047_1.jpg" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
	  </div>
	</div>
<%-- Best Sharing3 끝 --%>

<%-- Best Sharing3(이미지 오른쪽) 시작 --%>
	<div class="container mt-3">
	  <div class="media border p-3">
	    <div class="media-body">
	      <h4>John Doe <small><i>2024/03/02</i></small></h4>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	      <p>좋아요</p>
	      <p>댓글 수</p>       
	    </div>
	    <img src="https://image.aladin.co.kr/product/29125/5/cover/8965965047_1.jpg" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
	  </div>
	</div>
<%-- Best Sharing3 끝 --%>
      

    </div><!-- /.blog-main -->
<%-- 인기 있는 책 영역 --%>
    <aside class="col-md-4 blog-sidebar">
      <div class="p-4 mb-3 bg-light rounded">
        <h4 class="font-italic">인기 있는 책</h4>
        <div class="mb-0"><img class="popularcover" id="popularbookcover0" src="">
          <div id="popularcount0" class="tagcount"></div>
        </div>
        <div class="mb-0"><img class="popularcover" id="popularbookcover1" src="">
          <div id="popularcount1" class="tagcount"></div>
        </div>
      </div>
<%-- 인기 있는 책 영역 --%>
      
      <div class="p-4 mb-3 bg-light rounded">
        <h4 class="font-italic">가장 좋아요 많이 받은 댓글 sample2</h4>
        <p class="mb-0">Saw you downtown singing the Blues. Watch you circle the drain. Why don't you let me stop by? Heavy is the head that <em>wears the crown</em>. Yes, we make angels cry, raining down on earth from up above.</p>
      </div>
      
      <div class="p-4 mb-3 bg-light rounded">
        <h4 class="font-italic">채팅 영역</h4>
        <p class="mb-0">Saw you downtown singing the Blues. Watch you circle the drain. Why don't you let me stop by? Heavy is the head that <em>wears the crown</em>. Yes, we make angels cry, raining down on earth from up above.</p>
      </div>
      
      <div class="p-4 mb-3 bg-light rounded">
        <h4 class="font-italic">가장 좋아요 많이 받은 댓글 sample1</h4>
        <ol class="list-unstyled mb-0">
          <li><a href="#">March 2014</a></li>
          <li><a href="#">February 2014</a></li>
          <li><a href="#">January 2014</a></li>
          <li><a href="#">December 2013</a></li>
          <li><a href="#">November 2013</a></li>
          <li><a href="#">October 2013</a></li>
          <li><a href="#">September 2013</a></li>
          <li><a href="#">August 2013</a></li>
          <li><a href="#">July 2013</a></li>
          <li><a href="#">June 2013</a></li>
          <li><a href="#">May 2013</a></li>
          <li><a href="#">April 2013</a></li>
        </ol>
      </div>
    </aside><!-- /.blog-sidebar -->
  </div><!-- /.row -->
</main><!-- /.container -->


</body>
</html>