<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<jsp:include page="/layout/header.jsp" />	
<title>메인 페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="${pageContext.request.contextPath}/js/mainpage.js"></script>
<style>
  body {
    font-family : 나눔고딕;
    margin : 0 auto;
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
    width : 1140px;
  }
  
  .carousel-inner img {
    width: 19.5%;
    height: 300px;
  }

  #myCarousel {
  	height : 370px;
  }
  
  #myCarousel > div {
  	height : 100%;
  }
  
.slidebackground {
    background: #BCE55C;
}

.slidebackground::before {
    position: absolute;
    content: "";
    top: 0px;
    left: 0px;
    width: 100%;
    height: 480px;
    background-color: rgba(0,0,0,0.4);
}

.slidearea {
  padding-top:5px;
  padding-bottom:40px;
}


.indicatorbtn {
  top:375px;
}

#bestseller {
  color:white;
  font-weight:bold;
  padding-bottom:5px;
  font-size:40px;
}

#bestsellercomm {
  color:white;
  font-weight:bold;
  font-size:20px;
  margin-left:20px;
}

.welcomement {
  padding-top:30px;
  padding-bottom:30px;
}

.welcomecommarea {
  padding-bottom:9px;
}

#poster {
    position: absolute;
    width: 240px;
    height: 321px;
    top: 30px;
    left: 886px;
}

.prevbtn {
  left:-176px;
}

.nextbtn {
  left:1130px;
}
<%-- 슬라이드 영역 끝--%>  

<%-- 인기 게시글 영역 시작 --%>
.border {
    border: 1px solid #bce55c!important;
}

.profile {
  border-radius : 50%;
}

.profilearea {
  display : inline-block;
}

.m_idarea {
  display : inline-block;
}

  .popularpost1 {
  	margin-bottom : 25px;
  }
  
  h4 {
    font-size : 17px;
  }
  
  .popularpost2 {
    border-radius: 4px;
    width : 700px;
    height : 160px;
  }
  

  
  .popularpost6 {
    display : inline-block;
  }
  
.booksubject {
    font-size: 8px;
    padding-left: 2px;
    position: relative;
    top: 4px;

}
  
.postcontent {
    padding-left: 1px;
    font-size: 13px;
    position: relative;
    top: 15px;
}

.popularpost4 {
    position: relative;
    top: 17px;
}
  
.popularpost5 {
    display: inline-block;
    padding-right: 20px;
}

.postlikecnt, .postcommcnt {
  font-size : 10px;
}
  
  .inf_reg {
    font-size : 8px;
  }
  
  .postsubject {
  	position : relative;
  	top : 10px;
  	font-weight : bolder;
  }
  
  h3 {
    display:inline-block;
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
    border: 1px solid #BCE55C !important;
}
  
  body > main > div > aside > div:nth-child(1) > h4 {
    border-bottom : 1px solid #dee2e6 !important;
  }
  
  .popularbookarea {
    display : flex;
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
    padding-right : 20px;
  }
  
  .popularcommcontent {
    display : inline-block;
  }
  
  .commheart {
  	width : 15px;
  	height : 15px;
  }
  
.p-4 {
    padding: 0.5em !important;
}

.commid {
    font-size: 9px;
}

.commreg {
  font-size : 8px
}

.comm_profile {
  border-radius : 50%;
}

.commcontent {
  font-size : 12px;
  padding-right : 5px;
}

.bg-light {
    background-color: #ffffff !important;
}
<%-- 인기 댓글 영역 끝 --%>

<%-- 더보기 시작 --%>

.btn-success {
    color: #fff;
    background-color: #BCE55C;
    border-color: #BCE55C;
    font-weight: bold;
    border-radius: 50px;
}
<%-- 더보기 끝 --%>
</style>
<body>
<%-- 슬라이드 이미지 --%>
<div class="slidebackground">
	<div class="container mt-3 slide slidearea">
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
	
	  <!-- Indicators -->
	  <ul class="carousel-indicators indicatorbtn">
	    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	    <li data-target="#myCarousel" data-slide-to="1"></li>
	    <li data-target="#myCarousel" data-slide-to="2"></li>
	  </ul>
	  
	  <!-- The slideshow -->
	  <div class="carousel-inner">
	  
	    <div class="carousel-item active welcomement">
	      <div class="welcomecommarea">
	        <div id="bestseller" class="badge badge-success">🤗환영해요!</div><span id="bestsellercomm">BUNGE에서 책의 바다에 풍덩 빠져보아요</span>
	      </div>
	      <div class="welcomecommarea">
	        <div id="bestseller" class="badge badge-success">🙏함께해요!</div><span id="bestsellercomm">같이 읽으면 쉽게 갈 수 있어요</span>
	      </div>
	      <div class="welcomecommarea">
	        <div id="bestseller" class="badge badge-success">🤔고민해요!</div><span id="bestsellercomm">책을 읽고 기록하면서 생각이 깊어져요</span>
	      </div>
	      <div class="welcomecommarea">
	        <div id="bestseller" class="badge badge-success">🎉즐거워요!</div><span id="bestsellercomm">책마니들과 소통하면서 즐거움이 생겨요</span>
	      </div>
	      <div class="welcomecommarea">
	        <div id="bestseller" class="badge badge-success">🚀성장해요!</div><span id="bestsellercomm">BUNGE를 이용할수록 달라지는 스스로를 볼 수 있어요</span>
	      </div>
	      <img id="poster" src="${pageContext.request.contextPath}/image/bungeposter.png">
	    </div>
	    
	    <div class="carousel-item">
	      <div id="bestseller">🏆베스트셀러<span id="bestsellercomm">실시간으로 인기있는 책을 알려드려요</span></div>
	      <a id="slidelink0"><img id="slideimg0" src="${pageContext.request.contextPath}/image/sample4.jpg" alt="Los Angeles"></a>
	      <a id="slidelink1"><img id="slideimg1" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	      <a id="slidelink2"><img id="slideimg2" src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles"></a>
	      <a id="slidelink3"><img id="slideimg3" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	      <a id="slidelink4"><img id="slideimg4" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	    </div>
	    
	    
	    <div class="carousel-item">
	      <div id="bestseller">👏신간도서<span id="bestsellercomm">주목받는 신간을 알려드려요</span></div>
	      <a id="newbest0"><img id="newbestimg0" src="${pageContext.request.contextPath}/image/sample4.jpg" alt="Los Angeles"></a>
	      <a id="newbest1"><img id="newbestimg1" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	      <a id="newbest2"><img id="newbestimg2" src="${pageContext.request.contextPath}/image/sample8.png" alt="Los Angeles"></a>
	      <a id="newbest3"><img id="newbestimg3" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	      <a id="newbest4"><img id="newbestimg4" src="${pageContext.request.contextPath}/image/sample7.png" alt="Chicago"></a>
	    </div>
	    
	  </div>
	  <a class="carousel-control-prev prevbtn" href="#myCarousel" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next nextbtn" href="#myCarousel" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	  </div>
	  
	  <!-- Left and right controls -->
	</div>
	</div>
</div>
<%-- 슬라이드 이미지 끝 --%>



<%-- 슬라이드 이미지 아래 메인 시작 --%>   
<main role="main" class="container">
  <div class="row">
    <div class="col-md-8 blog-main">
    
<%--인기 게시글1(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <h3><span class="badge badge-pill badge-success">정보공유 인기 게시글</span></h3>
	  <button type="button" class="btn btn-success" id="morelist">더보기</button>
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile0" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id0">m_id</span>
		    <span class="inf_reg" id="postreg0">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject0">inf_subject</h4>
	      <div id="postbook0" class="booksubject">inf_book</div>       
	      <div id="postcontent0" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt0" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt0" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg0" src="" style="width:80px;">
	  </div>
	</div>
<%-- 인기 게시글1(이미지 오른쪽) 끝 --%>

<%--인기 게시글2(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile1" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id1">m_id</span>
		    <span class="inf_reg" id="postreg1">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject1">inf_subject</h4>
	      <div id="postbook1" class="booksubject"></div>       
	      <div id="postcontent1" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt1" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt1" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg1" src="" style="width:80px;">
	  </div>
	</div>
<%-- 인기 게시글2(이미지 오른쪽) 끝 --%>

<%--인기 게시글3(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile2" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id2">m_id</span>
		    <span class="inf_reg" id="postreg2">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject2">inf_subject</h4>
	      <div id="postbook2" class="booksubject"></div>       
	      <div id="postcontent2" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt2" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt2" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg2" src="" style="width:80px;">
	  </div>
	</div>
<%-- 인기 게시글3(이미지 오른쪽) 끝 --%>

<%--인기 게시글4(이미지 오른쪽) 시작 --%>
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile3" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id3">m_id</span>
		    <span class="inf_reg" id="postreg3">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject3">inf_subject</h4>
	      <div id="postbook3" class="booksubject"></div>       
	      <div id="postcontent3" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt3" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt3" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg3" src="" style="width:80px;">
	  </div>
	</div>
<%--인기 게시글4(이미지 오른쪽) 끝 --%>
	
<%-- 거래게시판 게시글1(이미지 오른쪽) 시작--%>
	<div class="container mt-3 popularpost1">
	  <h3><span class="badge badge-pill badge-success">진행 중인 거래</span></h3>
	  <button type="button" class="btn btn-success" id="moretradelist">더보기</button>
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile4" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id4">m_id</span>
		    <span class="inf_reg" id="postreg4">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject4">inf_subject</h4>
	      <div id="postbook4" class="booksubject"></div>       
	      <div id="postcontent4" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt4" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt4" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg4" src="" style="width:80px;">
	  </div>
	</div>
	
	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile5" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id5">m_id</span>
		    <span class="inf_reg" id="postreg5">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject5">inf_subject</h4>
	      <div id="postbook5" class="booksubject"></div>       
	      <div id="postcontent5" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt5" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt5" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg5" src="" style="width:80px;">
	  </div>
	</div>

	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile6" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id6">m_id</span>
		    <span class="inf_reg" id="postreg6">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject6">inf_subject</h4>
	      <div id="postbook6" class="booksubject"></div>       
	      <div id="postcontent6" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt6" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt6" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg6" src="" style="width:80px;">
	  </div>
	</div>

	<div class="container mt-3 popularpost1">
	  <div class="media border p-3 popularpost2">
	    <div class="media-body popularpost3">
	      <div class="profilearea">
	        <img class="profile" id="m_profile7" width="32px" height="32px" >
	      </div>
	      <div class="m_idarea">
	      	<span id="m_id7">m_id</span>
		    <span class="inf_reg" id="postreg7">inf_reg</span>
	      </div>
	      <h4 class="postsubject" id="postsubject7">inf_subject</h4>
	      <div id="postbook7" class="booksubject"></div>       
	      <div id="postcontent7" class="postcontent">inf_content</div>
	      <div class="popularpost4">
	        <div class="popularpost5">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/like_on.png"><span id="postlikecnt7" class="postlikecnt"></span>
	        </div>
	        <div class="popularpost6">
	          <img style="width:10px;height:10px" src="${pageContext.request.contextPath}/image/chat.png"><span id="postcommcnt7" class="postcommcnt"></span>
	        </div>
	      </div>
	    </div>
	    <img id="postimg7" src="" style="width:80px;">
	  </div>
	</div>

    </div><!-- /.blog-main -->
<%-- 인기 있는 책 영역 시작 --%>
    <aside class="col-md-4 blog-sidebar">
      <h3><span class="badge badge-pill badge-success">책마니 인기 책</span></h3>
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
 
<%-- 인기 댓글 시작 --%>      
      <h3><span class="badge badge-pill badge-success">인기 댓글</span></h3>
      <div class="p-4 mb-3 bg-light rounded">
        <div class="popularcommarea">
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount0">commcount</span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent0" class="commcontent">comm_content</span>
            <img id="comm_m_profile0" width="15px" height="15px" class="comm_profile">
            <span id="comm_m_id0" class="commid">comm_m_id</span>
            <span id="commreg0" class="commreg">comm_reg</span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount1">commcount</span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent1" class="commcontent">comm_content</span>
            <img id="comm_m_profile1" width="15px" height="15px" class="comm_profile">
            <span id="comm_m_id1" class="commid">comm_m_id</span>
            <span id="commreg1" class="commreg">comm_reg</span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount2">commcount</span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent2" class="commcontent">comm_content</span>
            <img id="comm_m_profile2" width="15px" height="15px" class="comm_profile">
            <span id="comm_m_id2" class="commid">comm_m_id</span>
            <span id="commreg2" class="commreg">comm_reg</span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount3">commcount</span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent3" class="commcontent">comm_content</span>
            <img id="comm_m_profile3" width="15px" height="15px" class="comm_profile">
            <span id="comm_m_id3" class="commid">comm_m_id</span>
            <span id="commreg3" class="commreg">comm_reg</span>
          </div>
          
          <br>
          
          <div class="popularcommcount">
            <img src="./image/like_on.png" class="commheart">
            <span id="commcount4">commcount</span>
          </div>
          <div class="popularcommcontent">
            <span id="commcontent4" class="commcontent">comm_content</span>
            <img id="comm_m_profile4" width="15px" height="15px" class="comm_profile">
            <span id="comm_m_id4" class="commid">comm_m_id</span>
            <span id="commreg4" class="commreg">comm_reg</span>
          </div>
        </div>
      </div>
<%-- 인기 댓글 끝 --%>   

    </aside><!-- /.blog-sidebar -->
  </div><!-- /.row -->
</main><!-- /.container -->


</body>
</html>