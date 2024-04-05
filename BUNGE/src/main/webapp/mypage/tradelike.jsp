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
.tab_container{
    position: relative;
    width: 800px;
    height: 400px;
    margin: 0 auto;
}
.tab-slider--tabs{
	font-size:12px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    padding-bottom: 20px;
}
.tab-slider--tabs li {
    text-align: center;
    width: 140px;
    margin: 5px;
    padding-top: 5px;
}
</style>
</head>
<body>
	<!-- tab menu 시작 -->
	<div class="tab_container">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
		  <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>좋아요한 리뷰</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>좋아요한 거래상품</span></li></a>
		  </ul>
		</div>
		<div class="tab-slider--container">
				<!-- tab4 시작 -->
		  <div id="tab3" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 즐겨찾기 시작 -->
			  <c:choose>
				<c:when test="${empty tradelist}">
				  <p>중고거래 찜한 내용이 없습니다.</p>
				</c:when>
				<c:when test="${!empty tradelist}">
				  <c:forEach var="t" items="${tradelist}" varStatus="loop">
						
				  <div class="user_infomark">
					<div class="infomark_section">	                                          
				<div class="infomark">
					<div class="infomark_box">  즐겨찾기 박스  작성일, 제목, 내용            
						<div class="infomark_reg">
							<p>좋아요 페이지 작성일 : ${t.trade.readcount}</p>
						</div>
						<div class="infomark_subject">
							<h3 class="infomark_inf_subject_title">좋아요한 글 제목 : ${t.trade.title}</h3>
						</div>
						  <div class="infomark_content">
							<p class="infomark_inf_contet_text">즐겨찾기 쓴 글 내용 : ${t.trade.description}</p>	
						</div>
					</div>   

						  <div class="infomark_board_img">${t.trade.iamgeid}</div>

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
</body>
</html>