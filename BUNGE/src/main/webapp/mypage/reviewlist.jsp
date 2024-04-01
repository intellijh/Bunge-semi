<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 리뷰 활동 페이지</title>
<jsp:include page="/layout/header.jsp" />
</head>
<body>
	<!-- tab menu 시작 -->
 <div class="tab_container">
	<div class="tab-slider--nav">
	  <ul class="tab-slider--tabs">
		<li class="tab-slider--trigger active" rel="tab1"><span>작성글</span></li>
		<li class="tab-slider--trigger" rel="tab2"><span>작성댓글</span></li>
	  </ul>
	</div>
	<div class="tab-slider--container">
	  <!-- tab1 시작 -->
	  <div id="tab1" class="tab-slider--body">
		<div class="tab_box">
		  <!-- 글 시작 -->
		  <c:choose>
			<c:when test="${empty mypage}">
			  <p>작성된 글이 없습니다.</p>
			</c:when>
			<c:when test="${!empty mypage}">
			  <c:forEach var="mypage" items="${mypage}" varStatus="loop">
					
			  <div class="user_board">
				<div class="board-section">	                                          
				  <div class="board_box">	                         
					<div class="board_title">
					  <div class="board_textarea">
						<h3 class="board_inf_subject_title">${mypage.board.inf_subject}</h3>
						<span class="board_board_title">${mypage.board.inf_subject}</span>
					  </div>
					</div>

					<div class="board-post">
					  <div class="board-img"></div>
					  <div class="board-details">
						<div class="board_details_titlebox">
						  <div class="board_details_title">
							<span class="board-author" id="user"> ${myArticle.userVO.nickname}</span>
							<span class="board-time">${myArticle.boardVO.create_date}</span>
							 <div class="board-like-unlike">
								<span><a href="${contextPath}/group/board?group_id=${mypage.board.grp_id}&article_no=${myArticle.boardVO.article_no}"><i class="fa-solid fa-pen"></i></a></span>
								<span><a href="${contextPath}/mypage/myBoardList/delArticle?article_no=${myArticle.boardVO.article_no}"><i class="fa-solid fa-xmark"></i></a></span>
							  </div>
						  </div>
						 
						</div>
						<p class="board-content">
							 ${mypage.board.inf_content}
						</p>
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
		  <!-- comment 시작 -->
		  <c:choose>
			<c:when test="${empty myCommentList}">
			  <p>작성된 댓글이 없습니다.</p>
			</c:when>
			<c:when test="${!empty myCommentList}">
			  <c:forEach var="myComment" items="${myCommentList}" varStatus="loop">
		  
			  <div class="user-comment">
				<div class="comments-section">	                                          
				  <div class="comment_box">	                         
					<div class="comment_title">
					  <div class="comment_textarea">
						<h3 class="comment_group_title">${myComment.groupVO.grp_name}</h3>
						<span class="comment_board_title">${myComment.boardVO.title}</span>
					  </div>
					</div>

					<div class="comment-post">
					  <div class="comment-img"></div>
					  <div class="comment-details">
						<div class="comment_details_titlebox">
						  <div class="comment_details_title">
							<span class="comment-author" id="user"> ${myComment.userVO.nickname}</span>
							<span class="comment-time">${myCommentcreate_date}</span>
							 <div class="comment-like-unlike">
								<span><a href="${contextPath}/group/board?group_id=${myComment.groupVO.grp_id}&article_no=${myComment.boardVO.article_no}"><i class="fa-solid fa-pen"></i></a></span>
								<span><a href="${contextPath}/mypage/myBoardList/delComment?comment_no=${myComment.commentVO.comment_no}"><i class="fa-solid fa-xmark"></i></a></span>
							  </div>
						  </div>
						</div>
						<p class="comment-content">
							 ${myComment.commentVO.com_cont}
						</p>
					  </div>
					</div>
				   </div>
				</div>
			  </div>
			 </c:forEach>
			</c:when>
		  </c:choose>
		  <!-- comment 종료 -->	                    
		</div>
	  </div>
	  <!-- tab2 종료 -->
	</div>
  </div>
</div>
  
<!-- 내가 쓴 글/댓글 영역 끝 -->
</body>
</html>