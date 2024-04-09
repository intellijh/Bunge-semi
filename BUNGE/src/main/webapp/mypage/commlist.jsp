<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글에 단 댓글 페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commlist.js"></script>
<style>
.mycomm {
    position: relative;
    width: 1200px;
    margin: 0 auto;
}
.tab_container{
    position: relative;
    display: flex;
    margin: 0 auto;
    flex-direction: row;
    justify-content: space-around;
    padding-top: 40px;
}
.left_bar {
	width: 180px;
    height: 600px;
} 
.tab-slider--tabs{
	position: relative;
    left: 50px;
    padding-bottom: 20px;
}
.tab-slider--tabs li {
    text-align: center;
    width: 140px;
    margin: 5px;
    padding-top: 5px;
}
.tab-slider--container {
    position: relative;
    left: 90px;
}
.tab_box {
width: 850px;
}
.commtitle {
    border-bottom: 1px solid #BCE55C;
    width: auto;
    position: relative;
    top: 20px;
    padding-bottom: 15px;
    text-align: center;
}
.commtitle h3 {
    position: relative;
    width: auto;
    left: 0;
}
.user_comm {
	width: 750px;
    height: 200px;
    border-bottom: 1px solid rgba(220, 227, 233, .8);
}
.board_inf_content_text  {
    width: 600px;
    height: 100px;
    text-overflow: ellipsis;
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
}
.commcount {
  opacity:0.6;
  margin-right:10px;
}
.commreg {
  float:right;
  font-size:9px;
}
.contentbox {
  width:740px;
}
</style>
</head>
<body>
<div id="warp">
	<div class="mycomm">
	<!-- tab menu 시작 -->
	<div class="commtitle">
	<h3>내가 쓴 댓글 조회</h3>
	</div>
	<div class="tab_container">
	<div class="left_bar">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">     
		   <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>좋아요한 리뷰</span></li></a>
			<%-- 
				<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>좋아요한 거래상품</span></li></a>
				--%>
		  </ul>
		  </div>
		</div>
		<div class="tab-slider--container">
		  <!-- tab2 시작 -->
		  <div id="tab2" class="tab-slider--body">
			<div class="tab_box">
			  <div class="contentbox">
			  </div>
		    </div>
		  <!-- tab2 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
	</div>
	</div>
</body>
</html>