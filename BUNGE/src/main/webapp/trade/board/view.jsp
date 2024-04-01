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
	<a href="../../trade.net" id="title">거래 게시판</a>
</div>
<div id="content-view">
	<div id="content-view-inner">
		<div id="video-wrap">
			<img src="<c:out value="${trade.imageID}" />" width="140" height="200">
		</div>
		<div id="video-info">
			<div id="video-title"><c:out value="${trade.TITLE}" /></div>
			<span id="video-author"><c:out value="${trade.sellerID}" /></span>
			<span id="video-date" style="float:right"><c:out value="${trade.createDate}" /></span>
			<!-- 수정, 삭제 폼 -->
			<form method="POST" id="delete-or-update-form">
				<input type="hidden" name="id" value="<c:out value="${trade.tradeID}" />">
				<input type="password" name="password" style="margin-left:0px; margin-top:10px" id="write-password" placeholder="비밀번호">
				<input type="button" value="수정" id="update-button" class="btn btn-info" onclick="update()">
				<input type="button" value="삭제" id="delete-button" class="btn btn-danger" onclick="del()">
			</form>
			<p style="margin-top:30px"><c:out value="${trade.description}" /></p>
		</div>
		<!-- 댓글 -->
		<div id="comment">
			<span id="comment-title">댓글</span>
			<hr>
			<div id="comment-write-form">
				<input type="hidden" id="videoId" value="<c:out value="${trade.tradeID}" />">
				<div id="comment-write-info">
					<input type="text" id="comment-write-author" placeholder="작성자" value="익명">
					<hr>
					<input type="password" id="comment-write-password" placeholder="비밀번호">
				</div>
				<div id="comment-write-content">
					<textarea id="comment-write-desc"></textarea>
				</div>
				<input type="button" id="comment-submit-button" class="btn btn-info" value="작성" onclick="commentSubmit()">
			</div>
			<hr>
			<div id="comment-list"></div>
		</div>
	</div>
</div>
<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="../../static/jquery.js"></script>
<script type="text/javascript" src="../../static/bootstrap.min.js"></script>
<script type="text/javascript" src="../../static/deleteOrUpdate.js"></script>
<script type="text/javascript" src="../../static/comment.js"></script>
</html>
