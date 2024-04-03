<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글에 단 댓글 페이지</title>
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
		  <!-- tab2 시작 -->
		  <div id="tab2" class="tab-slider--body">
			<div class="tab_box">
			  <!-- 글 시작 -->
			  <c:choose>
				<c:when test="${empty commlist}">
				  <p>작성된 댓글이 없습니다.</p>
				</c:when>
				<c:when test="${!empty commlist}">
				  <c:forEach var="c"  items="${commlist}" >	
				  <div class="user_comm">
					<div class="comm-section">	                                          
					  <div class="comm">
						<div class="comm_box">                     
							<div class="my_comm_subject">
								<h3 class="my_comm_subject_title">아이디 : ${c.board.m_id}=> 제목 : ${c.board.inf_subject}</h3>
							</div>
							<div class="my_comm_content">
								<p class="board_inf_content_text">내용 : ${c.board.inf_content}</p>
							</div>
							<div class="my_comm_content_text">
								${c.comment.m_id} => ${c.comment.comm_content}
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
		  <!-- tab2 종료 -->
		</div>
	  </div>
	<!-- 내가 쓴 글/댓글 영역 끝 -->
</body>
</html>