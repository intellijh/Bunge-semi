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
        <div id="write-view-title">글 수정하기</div>
        <hr><br>

        <form id="write-form" action="tradeUpdateDo.net" method="post" enctype="multipart/form-data">
            <!-- 거래글 제목 -->
            <input type="text" id="write-title" name="title" value="<c:out value="${trade.title}" />" maxlength="30"><br><br>

            <!-- 드롭다운 리스트들 -->
            카테고리
            <select name="category">
                <option value="철학" <c:if test="${'철학' eq trade.category}">selected</c:if>>철학</option>
                <option value="종교" <c:if test="${'종교' eq trade.category}">selected</c:if>>종교</option>
                <option value="사회과학" <c:if test="${'사회과학' eq trade.category}">selected</c:if>>사회과학</option>
                <option value="자연과학" <c:if test="${'자연과학' eq trade.category}">selected</c:if>>자연과학</option>
                <option value="기술과학" <c:if test="${'기술과학' eq trade.category}">selected</c:if>>기술과학</option>
                <option value="예술" <c:if test="${'예술' eq trade.category}">selected</c:if>>예술</option>
                <option value="언어" <c:if test="${'언어' eq trade.category}">selected</c:if>>언어</option>
                <option value="문학" <c:if test="${'문학' eq trade.category}">selected</c:if>>문학</option>
                <option value="역사" <c:if test="${'역사' eq trade.category}">selected</c:if>>역사</option>
                <option value="IT" <c:if test="${'IT' eq trade.category}">selected</c:if>>IT</option>
                <!-- 나머지 항목 추가 -->
            </select><br><br>
            책 상태
            <select name="quality">
                <option value="A" <c:if test="${'A' eq trade.quality}">selected</c:if>>A</option>
                <option value="B" <c:if test="${'B' eq trade.quality}">selected</c:if>>B</option>
                <option value="C" <c:if test="${'C' eq trade.quality}">selected</c:if>>C</option>
            </select><br><br>

            거래 상태
            <select name="condition">
                <option value="판매중" <c:if test="${'판매중' eq trade.condition}">selected</c:if>>판매중</option>
                <option value="예약중" <c:if test="${'예약중' eq trade.condition}">selected</c:if>>예약중</option>
                <option value="거래완료" <c:if test="${'거래완료' eq trade.condition}">selected</c:if>>거래완료</option>
            </select><br><br>

            선호 거래 방법
            <select name="tradeMethod">
                <option value="택배거래" <c:if test="${'택배거래' eq trade.tradeMethod}">selected</c:if>>택배거래</option>
                <option value="직거래" <c:if test="${'직거래' eq trade.tradeMethod}">selected</c:if>>직거래</option>
            </select><br><br>
            <input type="hidden" name="id" value="<c:out value="${trade.tradeID}" />">
            <input type="text" id="price" name="price" value="<c:out value="${trade.price}" />" maxlength="30">

            <!-- 거래글 내용 -->
            <textarea id="write-desc" name="desc" maxlength="1000"><c:out value="${trade.description}" /></textarea><br><br>

            <!-- 이미지 업로드 -->
            <input type="file" id="write-thumbnail" name="imageID" accept=".jpeg,.jpg,.png">
            <c:if test="${!empty trade.imageID}">
                <input type="hidden" name="existingImage" value="${trade.imageID}">
            </c:if><br>
            <!-- 이미지 미리보기 -->
            <img style="width: 140px; height: 200px; margin-top:30px;" id="preview-image" src="${pageContext.request.contextPath}/image/${trade.imageID}" alt="썸네일 미리보기"><br>
            (실제 보여질 이미지 크기입니다)<br><br>

            <!-- 비밀번호 입력 -->
            <input type="button" class="btn btn-danger" id="write-cancel" value="취소" onclick="cancel()">
            <input type="submit" class="btn btn-info" id="write-submit" value="수정하기">
        </form>
    </div>
</div>
<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/thumbnailPreview.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/submit_do.js" charset='utf-8'></script>
</html>
