<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>정보공유게시판 리스트</title>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
 <script src="js/list.js"></script>
 <%@ include file="/layout/header.jsp" %>
 <style>
	h1{font-size:1.5em; text-align:center; color:#1a92b9}
	.container{width:60%}
	
	label{font-weight:bold}
	#upfile{display:none}
 </style>
 </head>
 <body>
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
  	   		<%--답변 글 제목 앞에 여백 처리 부분
  	   			board_re_lev, board_num,
  	   			board_subject, board_name, board_date,
  	   			board_readcount : property 이름 --%>
  	   	<c:if test="${b.inf_lev != 0}"> <%-- 답글인 경우 --%>
  	   		<c:forEach var="a" begin="0" end="${b.inf_lev*2}" step="1">
  	   		&nbsp;
  	   		</c:forEach>
  	   		<img src="image/line.gif" style="width:20px">
  	   	</c:if>
  	   	
  	   	<c:if test="${b.inf_lev == 0}"> <%-- 원문인 경우 --%>
  	   		&nbsp;
  	   	</c:if>
  	   	
  	   	<a href="InfoDetail.com?num=${b.inf_num}">
  	   		<c:if test="${b.inf_subject.length()>=20}">
  	   			<c:out value="${b.inf_subject.substring(0,20)}..." />
  	   		</c:if>
  	   		<c:if test="${b.inf_subject.length()<20}">
  	   			<c:out value="${b.inf_subject}" />
  	   		</c:if>
  	   	</a>[${b.cnt}]	 <%--총댓글 수 --%>
  	   	</div>
  	   	</td>
  	   	<td><div>${b.inf_content}</div></td>
  	   	<td><div>${b.m_id}</div></td>
  	   	<td><div>${b.inf_reg}</div></td>
  	   	<td><div>${b.inf_readcount}</div></td>
  	   	</tr>
  	</c:forEach>
  </tbody>
   <%-- 게시글이 없는 경우 --%>
 <c:if test="${listcount == 0}">
 	<h3 style="text-align:center">등록된 글이 없습니다.</h3>
 </c:if>

 </table>
 <button type="button" style="position:relative;" class="btn btn-primary float-right">+글쓰기</button>
 </body>
</head>