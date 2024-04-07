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
    Trade<br>
    당신의 이웃들과 책을 거래해보아요!


</div>

<script>
    $(function() {
        $("button").on('click',function() {
            // 버튼 클릭 시 그 버튼의 value를 var kind로 가져오기
            var kind = (this).val();

            $.ajax({
                url : './tradeCategory.net', // 상기 주소로
                type : "post", // 포스트 방식으로 전송함
                cache : false,
                headers: {"cache-control": "no-cache", "pragma": "no-cache"},
                data : {"kind" : kind}, // kind를 kind로 명명해서 보냄
                success : function(data) {
                    console.log(data);

                    $('body').html(data); // 성공 시 body 부분에 data라는 html 문장 다 적용

                },
                error : function(data) {
                    alert('error');
                }
            })
        })
    })

</script>

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
