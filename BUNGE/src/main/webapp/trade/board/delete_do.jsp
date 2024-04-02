<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
         import="net.trade.db.*, java.io.File" %>
<%
    request.setAttribute("message", "비밀번호를 잘못 입력했습니다. 다시 입력하세요.");
%>

<script>
    var message = '<%= request.getAttribute("message") %>';
    if (message !== null && message !== '') {
        alert(message);
        // 다시 입력하는 페이지로 리디렉션할 수 있으면 해당 URL로 변경하시면 됩니다.
        window.location.href = 'view.jsp'; // 다시 입력하는 페이지로 리디렉션
    }
</script>
