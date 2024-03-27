<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
</head>
<body>
<h1>"Hello World!"</h1>
<c:forEach var="trade" items="${trades}">
  <tr>
    <td>${trade.tradeID}</td>
  </tr>
</c:forEach>
</body>
</html>