<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.List, net.trade.db.Trade, net.trade.db.TradeDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("utf-8");

    TradeDAO tradeDAO = new TradeDAO();
    ArrayList<Trade> tradeList = null;

    String keyword = request.getParameter("keyword");
    if (keyword == null){	// 키워드가 없을 경우 전체 동영상 조회
        tradeList = tradeDAO.getTradeList();
    } else {	// 키워드 존재 시 검색결과 조회
        String mode = request.getParameter("mode");
        if (mode.equals("제목")){
            tradeList = tradeDAO.searchTradeByTitle(keyword);
        } else if (mode.equals("내용")){
            tradeList = tradeDAO.searchTradeByDesc(keyword);
        }
    }

    String category = request.getParameter("category");
    ArrayList<Trade> categoryList = null;


    tradeDAO.close();
%>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../../layout/header.jsp" />
    <meta charset="UTF-8">
    <title>Trade Board</title>
    <link rel="stylesheet" href="../../static/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/style.css">
</head>
<body>
<div id="upper-bar">
    <a href="trade.net" id="title">거래 게시판</a>
    <a href="tradeWrite.net"><img src="../../static/upload_icon.png" id="button-write" height="43px"/></a>
</div>
<div id="navi-bar">
    <div id="search">
        <form action="trade.net" method="GET">
            <select class="form-control" id="search-mode" name="mode">
                <option>제목</option>
                <option>내용</option>
            </select>
            <input id="search-input" type="text" name="keyword" placeholder="검색어">
            <input id="search-button" class="btn btn-info" type="submit" value="검색">
        </form>
    </div>
</div>

<hr>

<div id="category-click">
    <div class="container"> <!-- 컨테이너 추가 -->
        <div class="row">
            <div class="col-md-12">
                <div class="category-search">
                    <form action="trade.net" method="GET">
                        <input id="category-button1" class="btn btn-light" type="submit" value="철학">
                        <input id="category-button2" class="btn btn-light" type="submit" value="종교">
                        <input id="category-button3" class="btn btn-light" type="submit" value="사회과학">
                        <input id="category-button4" class="btn btn-light" type="submit" value="자연과학">
                        <input id="category-button5" class="btn btn-light" type="submit" value="기술과학">
                        <input id="category-button6" class="btn btn-light" type="submit" value="예술">
                        <input id="category-button7" class="btn btn-light" type="submit" value="언어">
                        <input id="category-button8" class="btn btn-light" type="submit" value="문학">
                        <input id="category-button9" class="btn btn-light" type="submit" value="역사">
                        <input id="category-button10" class="btn btn-light" type="submit" value="IT">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<hr>

<div id="content">
    <c:forEach var="trade" items="${tradeList}">
        <div class="post" onclick="location.href='view.net?tradeID=${trade.tradeID}'">
            <div class="post-thumbnail" style="text-align: center;">
                <!-- 이미지 경로 출력 -->
                <img src="${pageContext.request.contextPath}/image/<c:out value="${trade.imageID}" />" width="140" height="200">
            </div>
            <div class="post-info">
                <span id="post-info-title"><c:out value="${trade.title}" /></span>
                <br>
                <span id="post-info-price"><c:out value="${trade.price}원" /></span><br>
                <span id="post-info-author"><c:out value="${trade.sellerID}" /></span>
                <span id="post-info-date" style="float:right"><c:out value="${trade.createDate}" /></span>
            </div>
        </div>
    </c:forEach>
</div>

<div id="pagination">
    <c:if test="${totalPages > 1}">
        <ul class="pagination">
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="trade.net?page=1">처음</a>
            </li>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="trade.net?page=${i}">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="trade.net?page=${totalPages}">끝</a>
            </li>
        </ul>
    </c:if>
</div>

<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="../../static/jquery.js"></script>
<script type="text/javascript" src="../../static/bootstrap.min.js"></script>
</html>
