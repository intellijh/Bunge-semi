<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="net.trade.db.Trade" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<style>
	body {width : 1140px}

</style>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap');
</style>

<head>
	<jsp:include page="../../layout/header.jsp" />
	<meta charset="UTF-8">
	<title>거래글 열람</title>
	<link rel="stylesheet" href="./static/bootstrap.min.css">
	<link rel="stylesheet" href="./static/style.css">
</head>
<body>
<div id="upper-bar">
</div>
<div id="content-view">
	<div id="content-view-inner">
		<div id="image-wrap">
			<img src="./image/<c:out value="${trade.imageID}" />" style = "float:left" width="280" height="400">
			<section>
				<div id="image-title"><c:out value="${trade.title}" />
				<button id="goBackButton" class="btn back-btn" style = "float:right">목록으로</button>
				</div>
				<script>
					document.getElementById("goBackButton").addEventListener("click", function() {
						history.back(); // 브라우저의 이전 페이지로 이동
					});
				</script>
				<br>
				<span id="image-category"><imgbox>카테고리</imgbox><c:out value="${trade.category}" /></span><br><br>
				<span id="image-quality"><imgbox>책 상태</imgbox><c:out value="${trade.quality}" /></span><br><br>
				<span id="image-condition"><imgbox>거래 상태</imgbox><c:out value="${trade.condition}" /></span><br><br>
				<span id="image-tradeMethod"><imgbox>선호 거래 방법</imgbox><c:out value="${trade.tradeMethod}" /></span><br><br>
				<span id="image-price"><imgbox>가격</imgbox><c:out value="${trade.price}원" /></span><br><br>
				<span id="image-author"><imgbox>판매자</imgbox><c:out value="${trade.sellerID}" /></span><br><br>
				<span id="image-readCount"><imgbox>조회수</imgbox><c:out value="${trade.readCount + 1}" /></span><br><br>
				<form method="post" action="chatCreate.com">
					<input type="hidden" name="tradeId" value="<c:out value="${trade.tradeID}" />">
					<input type="hidden" name="sellerId" value="<c:out value="${trade.sellerID}" />">
					<button class="w-btn w-btn-gra1 w-btn-gra-anim" type="submit" >채팅하기</button>
				</form>
			</section>
		<%--		<div id="image-info">--%>
			<%--			<input type="button" value="좋아요" id="like-button" class="btn btn-light" onclick="">--%>
			<%--		</div>--%>

			<!-- 수정, 삭제 폼 -->
			<form method="POST" id="delete-or-update-form">
				<input type="hidden" name="id" value="<c:out value="${trade.tradeID}" />">
				<p style="margin-top:30px; border: 1px solid #ccc; padding: 100px; max-width: 1500px; max-height: 3000px;">
					<c:out value="${trade.description}" />
				</p>
				<span id="image-date" style="float:right">
					<script>
						var createDate = new Date("<c:out value='${trade.createDate}' />");
						document.write(createDate.toLocaleString('en-US', {hour12: false}));
    				</script>
				</span>
				<input type="password" name="password" style="margin-left:0px; margin-top:10px" id="write-password" placeholder="비밀번호">
				<input type="button" value="수정" id="update-button" class="btn btn-info" onclick="update()">
				<input type="button" value="삭제" id="delete-button" class="btn btn-danger" onclick="del()">
			</form>

		</div>

	</div>
</div>
</body>
<script type="text/javascript" src="./static/jquery.js"></script>
<script type="text/javascript" src="./static/bootstrap.min.js"></script>
<script type="text/javascript" src="./static/deleteOrUpdate.js"></script>
</html>

