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
        <form action="TradeBoardServlet" method="GET">
            <select class="form-control" id="search-mode" name="mode">
                <option>제목</option>
                <option>내용</option>
            </select>
            <input id="search-input" type="text" name="keyword" placeholder="검색어">
            <input id="search-button" class="btn btn-info" type="submit" value="검색">
        </form>
    </div>
</div>
<div id="content">
    <c:forEach var="trade" items="${tradeList}">
        <div class="post" onclick="location.href='view.net?tradeID=${trade.tradeID}'">
            <div class="post-thumbnail" style="text-align: center;">
                <!-- 이미지 경로 출력 -->
                <img src="<c:out value="${trade.imageID}" />" width="140" height="200">
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
