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
  
  .mt-3 {
    margin-top : 0 !important
  }
  
  .p-3 {
    padding: 1rem!important;
  }
  
  body > main {
    position : relative;
    top : 30px
  }


<%-- 슬라이드 영역 시작 --%>  
  .slide {
    width : 1110px;
  }
  
  .carousel-inner img {
    width: 19.5%;
    height: 300px;
  }
  
  #myCarousel {
  	height : 300px;
  }
  
  #myCarousel > div {
  	height : 100%;
  }
<%-- 슬라이드 영역 끝--%>  

<%-- 인기 게시글 영역 시작 --%>
  .popularpost1 {
  	margin-bottom : 20px
  }
  
  h4 {
  	display : inline-block
  }
  
  .popularpost2 {
    border-radius: 4px;
  }
<%-- 인기 게시글 영역 끝 --%>




<%-- 인기 책 영역 --%>
  .tagcount {
    width : 80px;
  	font-size : 10px;
  }
  
  .popularcover {
    width : auto;
    height : 120px;
    
  }
  
  .mb-0 {
    width : 80px;
    display : inline-block;
  }
  
  .bg-light {
  	border : 1px solid #dee2e6 !important;
  }
  
  body > main > div > aside > div:nth-child(1) > h4 {
    border-bottom : 1px solid #dee2e6 !important;
  }
  
  .popularbookarea {
    display : flex;
    padding : 10px !important;
    justify-content: space-around;
  }
  
  .blog-sidebar {
    padding-left : 5px;
  }
  
<%-- 인기 책 영역 끝 --%>

<%-- 인기 댓글 영역 --%>
  .popularcommarea {
    display : inline-block !important;
  }
  
  .popularcommcount {
    display : inline-block;
  }
  
  .popularcommcontent {
    display : inline-block;
  }
  
  .commheart {
  	width : 15px;
  	height : 15px;
  }
  
  p-4 {
    padding: 0.5rem !important;
  }
<%-- 인기 댓글 영역 끝 --%>

</style>
<body>
<%-- 슬라이드 이미지 --%>
	<div class="container mt-3 slide">
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
    
<%--인기 게시글1(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <h4 class="font-italic">인기 게시글</h4>
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <h4 id="postsubject0">inf_subject</h4>
	      <span id="postreg0">inf_reg</span>       
	      <p id="postcontent0">inf_content</p>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt0" class="postlikecnt"></span>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt0" class="postcommcnt"></span>
	    </div>
	    <img id="postimg0" src="" style="width:60px;">
	  </div>
	</div>
<%-- 인기 게시글1(이미지 오른쪽) 끝 --%>

<%--인기 게시글2(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <h4 id="postsubject1">inf_subject</h4>
	      <span id="postreg1">inf_reg</span>       
	      <p id="postcontent1">inf_content</p>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt1" class="postlikecnt"></span>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt1" class="postcommcnt"></span>
	    </div>
	    <img id="postimg1" src="" style="width:60px;">
	  </div>
	</div>
<%-- 인기 게시글2(이미지 오른쪽) 끝 --%>

<%--인기 게시글3(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <h4 id="postsubject2">inf_subject</h4>
	      <span id="postreg2">inf_reg</span>       
	      <p id="postcontent2">inf_content</p>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt2" class="postlikecnt"></span>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt2" class="postcommcnt"></span>
	    </div>
	    <img id="postimg2" src="" style="width:60px;">
	  </div>
	</div>
<%-- 인기 게시글3(이미지 오른쪽) 끝 --%>

<%--인기 게시글4(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <h4 id="postsubject3">inf_subject</h4>
	      <span id="postreg3">inf_reg</span>       
	      <p id="postcontent3">inf_content</p>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt3" class="postlikecnt"></span>
	      <img style="width:15px;height:15px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt3" class="postcommcnt"></span>
	    </div>
	    <img id="postimg3" src="" style="width:60px;">
	  </div>
	</div>
<%-- 인기 게시글3(이미지 오른쪽) 끝 --%>

      

    </div><!-- /.blog-main -->
<%-- 인기 있는 책 영역 시작 --%>
    <aside class="col-md-4 blog-sidebar">
      <h4 class="font-italic">인기 책</h4>
      <div class="p-4 mb-3 bg-light rounded popularbookarea">
        <div class="mb-0"><img class="popularcover" id="popularbookcover0" src="">
          <div id="popularcount0" class="tagcount"></div>
        </div>
        <div class="mb-0"><img class="popularcover" id="popularbookcover1" src="">
          <div id="popularcount1" class="tagcount"></div>
        </div>
        <div class="mb-0"><img class="popularcover" id="popularbookcover2" src="">
          <div id="popularcount2" class="tagcount"></div>
        </div>
      </div>
<%-- 인기 있는 책 영역 끝 --%>
 
<%-- 좋아요best 댓글 --%>      
      <h4 class="font-italic">인기 댓글</h4>
      <div class="p-4 mb-3 bg-light rounded">
        <div class="popularcommarea">
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount0"></span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent0"></span>
          </div>
          
          <br>
          
           <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount1"></span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent1"></span>
          </div>
          
          <br>
          
           <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount2"></span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent2"></span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount3"></span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent3"></span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount4"></span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent4"></span>
          </div>
        </div>
      </div>
<%-- 좋아요best 댓글 --%>   

    </aside><!-- /.blog-sidebar -->
  </div><!-- /.row -->
</main><!-- /.container -->


</body>
</html>