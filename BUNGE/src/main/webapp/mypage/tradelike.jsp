<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<style>
.mytrade {
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
.tradetitle {
 	border-bottom: 1px solid rgba(212, 216, 229, .5);
    width: 1140px;
    position: relative;
    top : 20px;
    padding-bottom: 30px;
}
.tradetitle h3 {
	position: relative;
    left: 90px;
}
</style>
</head>
<body>
<div id="warp">
<div class="mytrade">
	<!-- tab menu 시작 -->
	<div class="tradetitle">
		<h3>좋아요한 중고거래 물품</h3>
	</div>
	<div class="tab_container">
	<div class="left_bar">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
		  <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>좋아요한 리뷰</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>좋아요한 거래상품</span></li></a>
		  </ul>
		</div>
		</div>
		<div class="tab-slider--container">
				<!-- tab4 시작 -->
		  <div id="tab3" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 즐겨찾기 시작 -->
			  <c:choose>
				<c:when test="${empty tradelist}">
				  <p>좋아요한 거래 물품이 없습니다.</p>
				</c:when>
				<c:when test="${!empty tradelist}">
				  <c:forEach var="t" items="${tradelist}" varStatus="loop">
						
				  <div class="user_trade">
					<div class="reade_section">	                                          
				<div class="trade">
					<div class="trade_box">  즐겨찾기 박스  작성일, 제목, 내용            
						<div class="trade_reg">
							<p>좋아요 페이지 작성일 : ${t.trade.readcount}</p>
						</div>
						<div class="trade_subject">
							<h3 class="trade_inf_subject_title">좋아요한 글 제목 : ${t.trade.title}</h3>
						</div>
						  <div class="trade_content">
							<p class="trade_inf_contet_text">즐겨찾기 쓴 글 내용 : ${t.trade.description}</p>	
						</div>
					</div>   
						  <div class="trade_board_img">${t.trade.iamgeid}</div>
						  <div class="infomark_like_comm_box">		  
							<div class="infomark_inf_comm_num">
								<div>
								</div>
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
		  <!-- tab4 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
	</div>
	</div>
</body>
</html>