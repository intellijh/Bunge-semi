<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 찜 페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
</head>
<body>
	<!-- tab menu 시작 -->
	<div class="tab_container">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab1"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab2"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab3"><span>즐겨찾기</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>중고거래 찜</span></li></a>
		  </ul>
		</div>
		<div class="tab-slider--container">
				<!-- tab3 시작 -->
		  <div id="tab4" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 즐겨찾기 시작 -->
			  <c:choose>
				<c:when test="${empty likelist}">
				  <p>즐겨찾기 내용이 없습니다.</p>
				</c:when>
				<c:when test="${!empty likelist}">
				  <c:forEach var="k" items="${likelist}" varStatus="loop">
						
				  <div class="user_infomark">
					<div class="infomark_section">	                                          
				<div class="infomark">
					<div class="infomark_box">  즐겨찾기 박스  작성일, 제목, 내용            
						<div class="infomark_reg">
							<p>좋아요 페이지 작성일 : ${k.board.inf_reg}</p>
						</div>
						<div class="infomark_subject">
							<h3 class="infomark_inf_subject_title">좋아요한 글 제목 : ${k.board.inf_subject}</h3>
						</div>
						  <div class="infomark_content">
							<p class="infomark_inf_contet_text">즐겨찾기 쓴 글 내용 : ${k.board.inf_content}</p>	
						</div>
					</div>   

						  <div class="infomark_board_img">즐겨찾기 글 이미지</div>

						  <div class="infomark_like_comm_box">좋아요, 댓글 박스
							<div class="infomark_inf_like_num">
								<div>
								<img src="${pageContext.request.contextPath}/image/like_on.png" alt="Like Icon">${k.infoLike.inf_num}
								</div>
							</div>
							<div class="infomark_inf_comm_num">
								<div>
								<div><img width="50px" height="50px" alt="talk" src="${pageContext.request.contextPath}/image/talk.jpg">${k.comment.inf_num}</div>
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
		  <!-- tab3 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
</body>
</html>