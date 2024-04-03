<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/layout/header.jsp"/>
<div class="container">
<%--    <form action="chatCreate.com" method="post">--%>
<%--        <div>--%>
<%--            <input type="text" name="sellerId" value="A12345" readonly>--%>
<%--            <input type="text" name="tradeId" value="3" readonly>--%>
<%--            <button type="submit">입장</button>--%>
<%--        </div>--%>
<%--        <div>--%>
<%--            <input type="text" name="sellerId" value="B1234" readonly>--%>
<%--            <input type="text" name="tradeId" value="2" readonly>--%>
<%--            <button type="submit">입장</button>--%>
<%--        </div>--%>
<%--        <br>--%>
<%--    </form>--%>
    <div>
        <input type="text" name="sellerId" value="A12345" readonly>
        <input type="text" name="tradeId" value="3" readonly>
        <a href="/chatCreate.com?sellerId=A12345&tradeId=3">입장</a>
    </div>
    <div>
        <input type="text" name="sellerId" value="B1234" readonly>
        <input type="text" name="tradeId" value="2" readonly>
        <a href="/chatCreate.com?sellerId=B1234&tradeId=2">입장</a>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/layout/footer.jsp"/>
</body>
</html>
