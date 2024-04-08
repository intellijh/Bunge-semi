<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.List, net.trade.db.Trade, net.trade.db.TradeDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("utf-8");

    String m_id = (String) session.getAttribute("m_id"); // 세션에서 m_id 값 가져오기

    if (m_id == null ) {
        // 세션에 m_id가 존재하지 않으면 로그인 페이지로 이동
        response.sendRedirect("login.com");
    }

//    TradeDAO tradeDAO = new TradeDAO();
//    ArrayList<Trade> tradeList = null;

//    String keyword = request.getParameter("keyword");
//    if (keyword == null){	// 키워드가 없을 경우 전체 동영상 조회
//        tradeList = tradeDAO.getTradeList();
//    } else {	// 키워드 존재 시 검색결과 조회
//        String mode = request.getParameter("mode");
//        if (mode.equals("제목")){
//            tradeList = tradeDAO.searchTradeByTitle(keyword);
//        } else if (mode.equals("내용")){
//            tradeList = tradeDAO.searchTradeByDesc(keyword);
//        }
//    }
//
//
//    String category = request.getParameter("category");
//    if(category != null) {
//        tradeList = tradeDAO.searchTradeByCategory(category);
//    }

%>


<style>
    @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap');
</style>

<!DOCTYPE html>

<html>
<head>
    <jsp:include page="../../layout/header.jsp" />
    <meta charset="UTF-8">
    <title>Trade Board</title>
    <link rel="stylesheet" href="../../static/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/style.css">
    <script>
        $(document).ready(function() {
            $(".category").click(function() {
                var category = $(this).data("category");

                // AJAX 요청 보내기
                $.ajax({
                    url: "tradeCategory.net",
                    type: "GET",
                    data: { category: category }, // 카테고리, 검색 모드, 검색어 함께 보내기
                    success: function(response) {


                    },
                    error: function(xhr, status, error) {
                        console.error("Error:", error);
                    }
                });
            });
        });
    </script>
</head>
<body>



<div id="upper-bar">
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


<div id="categoryandcolor">
    <br><index_title>Trade</index_title><br><br>
    <index_desc>마음의 양식을 나누어 보아요!</index_desc><br><br><br><br>

    <div id="category">
    <button class="category button" data-category="철학">철학</button>
    <button class="category button" data-category="종교">종교</button>
    <button class="category button" data-category="사회과학">사회과학</button>
    <button class="category button" data-category="자연과학">자연과학</button>
    <button class="category button" data-category="기술과학">기술과학</button>
    <button class="category button" data-category="예술">예술</button>
    <button class="category button" data-category="언어">언어</button>
    <button class="category button" data-category="문학">문학</button>
    <button class="category button" data-category="역사">역사</button>
    <button class="category button" data-category="IT">IT</button>
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
                <span id="post-info-price"><c:out value="${trade.price}원" /></span>
                <span id="post-info-author" style="float:right"><c:out value="${trade.sellerID}" /></span><br>
                <span id="post-info-readcount"><c:out value="조회수 : ${trade.readCount}" /></span>
                <span id="post-info-date" style="float:right"><c:out value="${trade.createDate}" /></span>
            </div>
        </div>
    </c:forEach>
</div>



<div id="under-bar">중고 거래 게시판</div>

</body>
<script type="text/javascript" src="../../static/jquery.js"></script>
<script type="text/javascript" src="../../static/bootstrap.min.js"></script>

</script>
</html>
