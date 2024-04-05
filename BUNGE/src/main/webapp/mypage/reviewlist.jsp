<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 리뷰 활동 페이지</title>
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
.user_board {
}
</style>
</head>
<body>
<div id=warp>
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
		  <!-- tab1 시작 -->
		  <div id="tab1" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 글 시작 -->
			  <c:choose>
				<c:when test="${empty boardlist}">
				  <p>작성된 글이 없습니다.</p>
				</c:when>
				<c:when test="${!empty boardlist}">
				  <c:forEach var="b" items="${boardlist}" >
				  <div class="user_board">
					<div class="board-section">	  
					<div class="board">                                     
					  <div class="board_box">게시글 박스 제목이랑 내용    
					  <p>작성글 보기</p>                   
						<div class="board_subject">
							<h3 class="board_inf_subject_title">제목 : ${b.board.inf_subject}</h3>
						</div>
						  <div class="board_content">
							<p class="board_inf_contet_text">내용 : ${b.board.inf_content}</p>
						  </div>
					</div>   

						  <div class="board-img">
						  		책 제목 : ${b.board.inf_book}
						  		<div class="img">
						  		<img  src="${b.board.inf_cover}">
						  		</div>
						  </div>
						  

						  <div class="like_comm_box">좋아요, 댓글 박스
							<div class="inf_like_num">내가 쓴 글 좋아요 갯수
								<div>
									<img src="${pageContext.request.contextPath}/image/like_on.png" alt="Like Icon">${b.infoLike.inf_num}
								</div>
							</div>
							<div class="inf_comm_num">내가 쓴 글 댓글 갯수
								<div><img width="50px" height="50px" alt="talk" src="${pageContext.request.contextPath}/image/talk.jpg">${b.comment.inf_num}</div>
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
		  <!-- tab1 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
	</div>
</body>
</html>