    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="net.trade.db.Trade" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <div class="post" onclick="location.href='/trade/board/view.jsp?id=${trade.tradeID}'">
                <div class="post-thumbnail" style="text-align: center;">
                    <!-- 이미지 경로 출력 -->
                    <img src="<c:out value="${trade.imageID}" />" width="140" height="200">
                </div>
                <div class="post-info">
                    <span id="post-info-title"><c:out value="${trade.title}" /></span>
                    <br>
                    <span id="post-info-author"><c:out value="${trade.sellerID}" /></span>
                    <span id="post-info-date" style="float:right"><c:out value="${trade.createDate}" /></span>
                </div>
            </div>
        </c:forEach>
    </div>
    <div id="under-bar">중고 거래 게시판</div>
    </body>
    <script type="text/javascript" src="../../static/jquery.js"></script>
    <script type="text/javascript" src="../../static/bootstrap.min.js"></script>
    </html>
