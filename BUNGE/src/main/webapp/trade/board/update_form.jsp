<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래 정보 수정</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>거래 정보 수정</h2>
<form action="update_trade.do" method="post" enctype="multipart/form-data">
    <!-- 거래 ID를 hidden으로 전달 -->
    <input type="hidden" name="id" value="${trade.id}">

    <!-- 거래 제목 입력 -->
    <label for="title">제목:</label>
    <input type="text" id="title" name="title" value="${trade.title}" required><br>

    <!-- 거래 카테고리 입력 -->
    <label for="category">카테고리:</label>
    <input type="text" id="category" name="category" value="${trade.category}" required><br>

    <!-- 거래 품질 입력 -->
    <label for="quality">품질:</label>
    <input type="text" id="quality" name="quality" value="${trade.quality}" required><br>

    <!-- 거래 상태 입력 -->
    <label for="condition">상태:</label>
    <input type="text" id="condition" name="condition" value="${trade.condition}" required><br>

    <!-- 거래 방법 입력 -->
    <label for="tradeMethod">거래 방법:</label>
    <input type="text" id="tradeMethod" name="tradeMethod" value="${trade.tradeMethod}" required><br>

    <!-- 거래 설명 입력 -->
    <label for="desc">설명:</label>
    <textarea id="desc" name="desc" rows="4" cols="50" required>${trade.desc}</textarea><br>

    <!-- 거래 가격 입력 -->
    <label for="price">가격:</label>
    <input type="text" id="price" name="price" value="${trade.price}" required><br>

    <!-- 거래 이미지 업로드 -->
    <label for="image">이미지:</label>
    <input type="file" id="image" name="image"><br>

    <!-- 비밀번호 입력 -->
    <label for="password">비밀번호:</label>
    <input type="password" id="password" name="password" required><br>

    <!-- 수정 버튼 -->
    <input type="submit" value="수정">
</form>
</body>
</html>
