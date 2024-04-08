<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>정보공유게시판 리스트</title>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<script src="js/infolist.js"></script>
<%@ include file="/layout/header.jsp" %>
<style>


	body {
  		font-family : "나눔고딕";
  		margin : 0 auto;
	}	
	
	.table {
		border : 1px soild #BCE55C;
		
	}
	
 	.container {
 		max-width : 1140px;
 		margin : 0 auto;
 		padding : 0;
  	}
  
  	label{
  		font-weight:bold
  	}
  
 	#upfile{
 		display:none
 	}
  
    .gray {
    	color:gray
    }
  
	.cover {
		width : 100px; height : 130px 
	}
	
	#viewcount {
 		width : auto;
 		margin-bottom : 2em;
 		display : inline-block
 	}
 
 	
 	#yeoback { 
 		width : 100%; 
 		height :300px;
 		margin : 0 auto;
 		background-color : #BCE55C;
 		text-align : center;
 	}
 	
 	.table thead th {
 		padding : .75rem;
 	    vertical-align: bottom;
    	border-bottom: 2px solid #BCE55C;
    	white-space: nowrap; /* 텍스트를 한 줄로 강제로 표시하도록 설정 */
    	padding : 15px 12px 15px 12px; 
    	text-align : center
 	}
 	
 	.table td,th {
 		font-size : 15px;
 		border-top: 1px solid #BCE55C;
 		vertical-align: middle; /* 텍스트 수직 가운데 정렬 */
 		text-align : center
 	}
 	
 	b { 
 		line-height: 70px
 	}
	
	.booksubject {
		font-size : 10px
	}
  
  	#newwritebutton {
  		background-color : #BCE55C;
  		border : #BCE55C;
  		display : inline-block;
  		
  	}
    
    .page-link, .pagination, .page-link:hover {
    	color: #000;
    }
    
    .page-item.active .page-link  {
    	background-color: #BCE55C; /* 활성화된 페이지 버튼의 배경색을 파란색으로 설정 */
    	color: #000; /* 텍스트 색상을 흰색으로 설정 */
    	border-color: #BCE55C; /* 테두리 색상을 파란색으로 설정 */
	}
	
	.title, .content {
	  text-align:justify!important;
	}
	
</style>
</head>
<body>
<input type="hidden" name="loginid" value="${m_id}" id="loginid">
<div id="yeoback">
 <b>Sharing</b><br><br><br>
 독후감과 나의 일상을 공유해봐요.<br><br><br>
 책의 내용이 좋았다면, 책을 읽은 장소가 좋았다면 우리 함께 공유해요!
 </div>
<div class="container">
 <%-- 게시글이 있는 경우 --%>
 <c:if test="${listcount > 0}">
    <table class="table">
      <thead>
  	    <tr>
  		  <th><div>번호</div></th>
  		  <th><div>제목</div></th>
  		  <th><div>내용</div></th>
  		  <th><div>작성자</div></th>
  		  <th><div>날짜</div></th>
  		  <th><div>조회수</div></th>
  		  <th><div>책 표지</div></th>
  		  <th><div>좋아요</div></th>
  	    </tr>
      </thead>
      <tbody>
  	    <c:set var="num" value="${listcount - (page -1)*limit}" />
  	    <c:forEach var="b" items="${boardlist}">
  	    <tr>
  	      <td><%-- 번호 --%>
  	      <c:set var="num" value="${num-1}" />  <%-- num=num-1; 의미 --%>
  	      </td>
  	      <td><%-- 제목 --%>
  	   	    <div>
  	   	    <c:if test="${b.inf_lev != 0}"> <%-- 답글인 경우 --%>
  	   		  <c:forEach var="a" begin="0" end="${b.inf_lev*2}" step="1">
  	   		  </c:forEach>
  	   		  <img src="image/line.gif" style="width:20px">
  	   	    </c:if>
  	   	      <a href="InfoDetail.com?inf_num=${b.inf_num}" id="inf_num">
  	   		<c:if test="${b.inf_subject.length()>=20}">
  	   			<c:out value="${b.inf_subject.substring(0,20)}..." />
  	   		</c:if>
  	   		<c:if test="${b.inf_subject.length()<20}">
  	   			<c:out value="${b.inf_subject}" />
  	   		</c:if>
  	   	      </a>[${b.cnt}]<br>
  	   	      <span id="postbook0" class="booksubject">book</span>	 <%--총 댓글 수 --%>
  	   	    </div>
  	   	  </td>
  	   	  <td><div>${b.inf_content}</div></td>
  	   	  <td><div>${b.m_id}</div></td>
  	   	  <td><div>${b.inf_reg}</div></td>
  	   	  <td><div>${b.inf_readcount}</div></td>
  	   	  <td><div>${b.infolikecnt}</div></td>
  	   	</tr>
  	    </c:forEach>
      </tbody>
    </table><br>
  	
  	 <button id="newwritebutton" type="button" style="position:relative;" class="btn btn-success float-right">+글쓰기</button><br><br>
  	
  	<div class="center-block">
	  <ul class="pagination justify-content-center">
	    <c:if test="${page <= 1}">
	      <li class="page-item">
	        <a class="page-link gray">이전&nbsp;</a>
	      </li>
	    </c:if>
	    <c:if test="${page > 1 }">
	      <li class="page-item">
	        <a href="InfoList.com?page=${page-1}"
	           class="page-link">이전&nbsp;</a>
	      </li>
	    </c:if>
	    
	    <c:forEach var="a" begin="${startpage}" end="${endpage}">
	      <c:if test="${a==page}">
	        <li class="page-item active">
	          <a class="page-link">${a}</a>
	        </li>
	      </c:if>
	      <c:if test="${a != page}">
	        <li class="page-item">
	          <a href="InfoList.com?page=${a}"
	          	 class="page-link">${a}</a>
	        </li>
	      </c:if>
	    </c:forEach>
	    
	    <c:if test="${page >= maxpage }">
	      <li class="page-item">
	        <a class="page-link gray">&nbsp;다음</a>
	      </li>
	    </c:if>
	    <c:if test="${page < maxpage }">
	      <li class="page-item">
	        <a href="InfoList.com?page=${page+1}"
	           class="page-link">&nbsp;다음</a>
	      </li>
	    </c:if>
	  </ul>
	</div><br>
 </c:if> <%-- <c:if test="${listcount > 0}"> end --%>
 
 <%-- 게시글이 없는 경우 --%>
 <c:if test="${listcount == 0}">
   <h3 style="text-align:center">등록된 글이 없습니다.</h3>
 </c:if>
</div>
</body>
</head>