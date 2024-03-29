<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" import="net.trade.db.Trade,net.trade.db.TradeDAO,java.util.ArrayList,java.net.URLDecoder"%>
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
    <meta charset="EUC-KR">
    <title>Trade Board</title>
    <link rel="stylesheet" href="../../static/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/style.css">
</head>
<body>
<div id="upper-bar">
    <a href="newtradeindex.jsp" id="title">거래 게시판</a>
    <a href="write.jsp"><img src="../../static/upload_icon.png" id="button-write" height="43px"/></a>
</div>
<div id="navi-bar">
    <div id="search">
        <form action="newtradeindex.jsp" method="GET">
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
    <% for (Trade trade : tradeList) { %>
    <div class="post" onclick="location.href='view.jsp?id=<%=trade.getTradeID()%>'">
        <div class="post-thumbnail">
            <img src="<%="./upload/" + trade.getImageID()%>" width="360" height="202">
        </div>
        <div class="post-info">
            <span id="post-info-title"><%=trade.getTitle()%></span>
            <br>
            <span id="post-info-author"><%=trade.getSellerID()%></span>
            <span id="post-info-date" style="float:right"><%=trade.getCreateDate()%></span>
        </div>
    </div>
    <% } %>
</div>
<div id="under-bar">중고 거래 게시판</div>
</body>
<script type="text/javascript" src="../../static/jquery.js"></script>
<script type="text/javascript" src="../../static/bootstrap.min.js"></script>
</html>

