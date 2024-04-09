<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 좋아요한 리뷰 페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<style>
.mylike {
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
    left: 20px;
 }
 .tab_box {
width: 850px;
}
 .myliketitle {
    border-bottom: 1px solid #BCE55C;
    width: auto;
    position: relative;
    top: 20px;
    padding-bottom: 15px;
    text-align: center;
 }
  .myliketitle h3 {
  	position: relative;
    left: 90px;
  }
 .user_like {
 	width: 850px;
	height: 300px;
	border-bottom: 1px solid rgba(220, 227, 233, .8);
 }
.tab_box :last-child {
	border-bottom: none;
} 
.like {
	display: flex;
    justify-content: space-between;
    flex-direction: row;
    padding-top: 22px;
}
.board_img {
	height: 160px;
}
.board_img img {
	width: 200px;
	height: 250px;
}
.like_inf_subject_title {
	padding-bottom:10px;
}
.like_inf_contet_text {
    width: 600px;
    height: 110px;
    text-overflow: ellipsis;
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
}
.like_comm_box {
	display: flex;
    flex-direction: row;
}

</style>
</head>
<body>
<div id="warp">
	<div class="mylike">
	<!-- tab menu 시작 -->
	<div class="myliketitle">
		<h3>내가 좋아요한 리뷰 조회</h3>
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
				<!-- tab3 시작 -->
		  <div id="tab3" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 즐겨찾기 시작 -->
			  <c:choose>
				<c:when test="${empty likelist}">
				  <p>좋아요한 리뷰가 없습니다.</p>
				</c:when>
				<c:when test="${!empty likelist}">
				  <c:forEach var="k" items="${likelist}" varStatus="loop">
				  <div class="user_like">
					<div class="like_section">	                                          
				<div class="like">
					<div class="like_box">  
						<div class="like_reg">
							<p>작성일 : ${k.board.inf_reg}</p>
						</div>
						<div class="like_subject">
						 <a href="InfoDetail.com?inf_num=${k.board.inf_num}"><h3 class="like_inf_subject_title">제목 :${k.board.inf_subject}</h3></a>
						</div>
						  <div class="like_content">
							<p class="like_inf_contet_text">내용 : ${k.board.inf_content}</p>	
						</div>
					</div>   
						  <div class="board_img">
							<div class="img">
						  		<img  src="${k.board.inf_cover}">
						  		</div>
						  </div>
						 </div>
						  <div class="like_comm_box">
							<div class="inf_like_num">
								<div>
									<img src="${pageContext.request.contextPath}/image/like_on.png" alt="Like Icon">${k.board.infolikecnt}
								</div>
							</div>
							<div class="inf_comm_num">
								<div>
									<img width="50px" height="50px" alt="talk" src="${pageContext.request.contextPath}/image/talk.jpg">${k.board.cnt}
								</div>
							</div>
						  </div>
					   </div>
					</div>
				  </c:forEach>
				</c:when>
			  </c:choose>
			  <!-- 글 종료 -->
			</div>	                  
		  </div>
		  <!-- tab3 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
	</div>
	</div>
</body>
</html>