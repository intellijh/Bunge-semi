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
	<div class="section2">
		<table class="table table">
		<c:set var="num" value="${listcount-(page-1)*limit}" />
		<c:forEach var="b" items="${boardlist}">
			<tr>
				<td>
					<c:out value="${num}"/>
					<c:set var="num" value="${num-1 }" />
				</td>
			</tr>
			<div>
				<c:if test="${b.board_re_lev==0 }">
				&nbsp;
				</c:if>
				
				<a href="reviewlist.com?num=${b.board_num}">
					<c:if test="${b.board_ }"></c:if>
					
				</a>
			</div> 
		</c:forEach>
		</table>
	</div>
</body>
</html>