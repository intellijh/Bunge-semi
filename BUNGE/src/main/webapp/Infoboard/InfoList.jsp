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
  .container {
  	max-width : 1440px;
  }
  
  h1{font-size:1.5em; text-align:center; color:#1a92b9}
  
  label{font-weight:bold}
  
  #upfile{display:none}
  
  .gray {color:gray}
  
  .container {
  	margin-left : 50px;
  	margin-right : 50px;
  }
  
  
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:8%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:50%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:14%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:17%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:11%}
</style>
</head>
<body>
<div class="container">
 <%-- 게시글이 있는 경우 --%>
 <c:if test="${listcount > 0}">
 
   <div class="rows">
     <span>줄보기</span>
     <select class="form-control" id="viewcount">
       <option value="1">1</option>
       <option value="3">3</option>
       <option value="5">5</option>
       <option value="7">7</option>
       <option value="8">8 </option>
       <option value="10" selected>10</option>
     </select>
   </div>
   
    <table class="table table-striped">
      <thead>
  	    <tr>
  		  <th colspan="3">MVC 게시판 - List</th>
  		  <th colspan="2">
  			<span>글 개수 : ${listcount}</span>
  		  </th>
  	    </tr>
  	    <tr>
  		  <th><div>번호</div></th>
  		  <th><div>제목</div></th>
  		  <th><div>내용</div></th>
  		  <th><div>작성자</div></th>
  		  <th><div>날짜</div></th>
  		  <th><div>조회수</div></th>
  		  <th><div>책 표지</div></th>
  		  <th><div>좋아요</div></th>
  		  <th><div>프로필 이미지</div></th>
  	    </tr>
      </thead>
      <tbody>
  	    <c:set var="num" value="${listcount - (page -1)*limit}" />
  	    <c:forEach var="b" items="${boardlist}">
  	    <tr>
  	      <td><%-- 번호 --%>
  	      <c:out value="${num}"/><%-- num 출력 --%>
  	      <c:set var="num" value="${num-1}" />  <%-- num=num-1; 의미 --%>
  	      </td>
  	      <td><%-- 제목 --%>
  	   	    <div>
  	   	    <c:if test="${b.inf_lev != 0}"> <%-- 답글인 경우 --%>
  	   		  <c:forEach var="a" begin="0" end="${b.inf_lev*2}" step="1">
  	   		  &nbsp;
  	   		  </c:forEach>
  	   		  <img src="image/line.gif" style="width:20px">
  	   	    </c:if>
  	   	      <a href="InfoDetail.com?num=${b.inf_num}" id="inf_num">
  	   		<c:if test="${b.inf_subject.length()>=20}">
  	   			<c:out value="${b.inf_subject.substring(0,20)}..." />
  	   		</c:if>
  	   		<c:if test="${b.inf_subject.length()<20}">
  	   			<c:out value="${b.inf_subject}" />
  	   		</c:if>
  	   	      </a>[${b.cnt}]	 <%--총 댓글 수 --%>
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
    </table>
    
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
	</div>
    
    
 </c:if> <%-- <c:if test="${listcount > 0}"> end --%>
 
 <%-- 게시글이 없는 경우 --%>
 <c:if test="${listcount == 0}">
   <h3 style="text-align:center">등록된 글이 없습니다.</h3>
 </c:if>
 
 
 <button type="button" style="position:relative;" class="btn btn-primary float-right">+글쓰기</button>
</div>
</body>
</head>