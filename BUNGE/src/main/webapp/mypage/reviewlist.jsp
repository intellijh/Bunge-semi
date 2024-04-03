<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 리뷰 활동 페이지</title>
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
			<a href="mybookmarklist.com"><li class="tab-slider--trigger"  rel="tab3"><span>즐겨찾기</span></li></a>
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

						  <div class="board-img">내가 쓴 글 이미지</div>

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
	
		  <!-- tab2 시작 -->
		  <div id="tab2" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 글 시작 -->
			  <c:choose>
				<c:when test="${empty comm}">
				  <p>작성된 댓글이 없습니다.</p>
				</c:when>
				<c:when test="${!empty comm}">
				  <c:forEach var="comment" items="${comm}" varStatus="loop">
						
				  <div class="user_comm">
					<div class="comm-section">	                                          
					  <div class="comm">
						<div class="comm_box"> 내가 쓴 댓글 게시글 박스 제목,내용 댓글 내용                        
							<div class="my_comm_subject">
								<h3 class="my_comm_subject_title"> 내가 쓴 댓글 게시글 제목</h3>
							</div>
							<div class="my_comm_content">
								<p class="board_inf_content_text">내가 쓴 댓글 게시글 내용</p>
							</div>
							<div class="my_comm_content_text">
								내가 쓴 게시글에 댓글 내용
							</div>	
						</div>		
						  
						  <div class="comm_board-img">내가 쓴 댓글에 대한 게시글 이미지</div>
					   </div>
					</div>
				  </div>
				  
				  </c:forEach>
				</c:when>
			  </c:choose>
			  <!-- 글 종료 -->
			</div>	                  
		  </div>
		  <!-- tab2 종료 -->
		  
				<!-- tab3 시작 -->
		  <div id="tab3" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 즐겨찾기 시작 -->
			  <c:choose>
				<c:when test="${empty infomark}">
				  <p>즐겨찾기 내용이 없습니다.</p>
				</c:when>
				<c:when test="${!empty infomark}">
				  <c:forEach var="infoLike" items="${infomark}" varStatus="loop">
						
				  <div class="user_infomark">
					<div class="infomark_section">	                                          
				<div class="infomark">
					<div class="infomark_box">  즐겨찾기 박스  작성일, 제목, 내용            
						<div class="infomark_reg">
							<p>즐겨찾기 작성일?</p>
						</div>
						<div class="infomark_subject">
							<h3 class="infomark_inf_subject_title">즐겨찾기 글 제목</h3>
						</div>
						  <div class="infomark_content">
							<p class="infomark_inf_contet_text">즐겨찾기 쓴 글 내용</p>	
						</div>
					</div>   

						  <div class="infomark_board_img">즐겨찾기 글 이미지</div>

						  <div class="infomark_like_comm_box">즐겨찾기 박스 좋아요, 댓글 수
							<div class="infomark_inf_like_num">
								<div>즐겨찾기 이미지</div>
								<div>즐겨찾기 갯수</div>
							</div>
							<div class="infomark_inf_comm_num">
								<div>댓글 이미지</div>
								<div>댓글 갯수</div>
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