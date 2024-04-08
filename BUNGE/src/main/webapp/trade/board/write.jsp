<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="net.trade.db.Trade" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="${pageContext.request.contextPath}/layout/header.jsp" />
	<meta charset="UTF-8">
	<title>거래글 업로드</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
</head>
<body>
<div id="upper-bar">
</div>
<div id="content-view">
	<div id="content-view-inner">
		<div id="write-view-title">거래글 업로드</div>
		<hr><br>

		<form id="write-form" action="tradeSubmit.net" method="post" enctype="multipart/form-data">
			<!-- 거래글 제목 -->
			<input type="text" id="write-title" name="title" placeholder="거래글 제목(30자 이내)" maxlength="30"><br><br>

			<input name="m_id" id="m_id" type="text" value="${m_id}" class="form-control" readOnly>

			<br>

			<!-- 드롭다운 리스트들 -->
			카테고리
			<select name="category">
				<option value="철학">철학</option>
				<option value="종교">종교</option>
				<option value="사회과학">사회과학</option>
				<option value="자연과학">자연과학</option>
				<option value="기술과학">기술과학</option>
				<option value="예술">예술</option>
				<option value="언어">언어</option>
				<option value="문학">문학</option>
				<option value="역사">역사</option>
				<option value="IT">IT</option>
				<!-- 나머지 항목 추가 -->
			</select><br><br>
			책 상태
			<select name="quality">
				<option value="A">A</option>
				<option value="B">B</option>
				<option value="C">C</option>
			</select><br><br>
			거래 상태
			<select name="condition">
				<option value="판매중">판매중</option>
				<option value="예약중">예약중</option>
				<option value="거래완료">거래완료</option>
			</select><br><br>
			선호 거래방식
			<select name="tradeMethod">
				<option value="택배거래">택배거래</option>
				<option value="직거래">직거래</option>
			</select><br><br>
			<input type="number" id="price" name="price" placeholder="가격을 입력하세요" maxlength="20" >

			<!-- 거래글 내용 -->
			<textarea id="write-desc" name="desc" placeholder="거래글 내용(1000자 이내)" maxlength="1000"></textarea><br><br>

			<!-- 이미지 업로드 -->
			<input type="file" id="write-thumbnail" name="imageID" accept=".jpeg,.jpg,.png" required><br>
			<!-- 이미지 미리보기 -->
			<img style="width: 140px; height: 200px; margin-top:30px;" id="preview-image" src="static/thumbnailPreview.png" alt="썸네일 미리보기"><br>
			(실제 보여질 이미지 크기입니다)<br><br>

			<!-- 비밀번호 입력 -->
			<input type="password" id="write-password" name="password" placeholder="비밀번호" maxlength="20">

			<!-- 세션에서 가져온 id 값 전달 -->
			<input type="button" class="btn btn-danger" id="write-cancel" value="취소" onclick="cancel()">
			<input type="button" class="btn btn-info" id="write-submit" value="업로드" onclick="checkSubmit()">



		</form>
	</div>
</div>
<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/thumbnailPreview.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/submit.js" charset='utf-8'></script>
</html>
