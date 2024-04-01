<%@ page contentType="text/html;charset=utf-8" import="java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Form</title>
</head>
<body>
<form action="tradeUploadProcess.jsp" method="post" enctype="multipart/form-data">
    <input type="text" name="title" placeholder="Title">
    <input type="text" name="sellerID" placeholder="Seller ID">
    <textarea name="desc" placeholder="Description"></textarea>
    <input type="file" name="file">
    <input type="submit" value="Upload">
</form>
</body>
</html>