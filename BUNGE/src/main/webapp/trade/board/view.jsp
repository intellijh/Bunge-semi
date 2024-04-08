<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="net.trade.db.Trade" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../../layout/header.jsp" />
	<meta charset="UTF-8">
	<title>거래글 열람</title>
	<link rel="stylesheet" href="../../static/bootstrap.min.css">
	<link rel="stylesheet" href="../../static/style.css">
</head>
<body>
<div id="upper-bar">
</div>
<div id="content-view">
	<div id="content-view-inner">
		<div id="image-wrap">
			<img src="${pageContext.request.contextPath}/image/<c:out value="${trade.imageID}" />" width="280" height="400">
			<form method="post" action="chatCreate.com">
				<input type="hidden" name="tradeId" value="<c:out value="${trade.tradeID}" />">
				<input type="hidden" name="sellerId" value="<c:out value="${trade.sellerID}" />">
				<button type="submit">채팅하기</button>
			</form>
			<input type="button" value="좋아요" id="like-button" class="btn btn-light" onclick="">

		</div>
		<div id="image-info">
			<div id="image-title"><c:out value="${trade.title}" /></div>
			<span id="image-category"><c:out value="카테고리 : ${trade.category}" /></span><br>
			<span id="image-quality"><c:out value="책 상태 : ${trade.quality}" /></span><br>
			<span id="image-condition"><c:out value="거래 상태 : ${trade.condition}" /></span><br>
			<span id="image-tradeMethod"><c:out value="선호 거래 방법 : ${trade.tradeMethod}" /></span><br>
			<span id="image-price"><c:out value="${trade.price}원" /></span><br>
			<span id="image-author"><c:out value="${trade.sellerID}" /></span><br>
			<span id="image-readCount"><c:out value="조회수 : ${trade.readCount}" /></span>

			<!-- 수정, 삭제 폼 -->
			<form method="POST" id="delete-or-update-form">
				<input type="hidden" name="id" value="<c:out value="${trade.tradeID}" />">
				<p style="margin-top:30px; border: 1px solid #ccc; padding: 100px; max-width: 1500px;">
					<c:out value="${trade.description}" />
				</p>
				<span id="image-date" style="float:right"><c:out value="${trade.createDate}" /></span>
				<input type="password" name="password" style="margin-left:0px; margin-top:10px" id="write-password" placeholder="비밀번호">
				<input type="button" value="수정" id="update-button" class="btn btn-info" onclick="update()">
				<input type="button" value="삭제" id="delete-button" class="btn btn-danger" onclick="del()">
			</form>

		</div>

	</div>
</div>
<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="../../static/jquery.js"></script>
<script type="text/javascript" src="../../static/bootstrap.min.js"></script>
<script type="text/javascript" src="../../static/deleteOrUpdate.js"></script>
</html>
