<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" import="net.trade.db.Trade"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>거래글 업로드</title>
    <link rel="stylesheet" href="./static/bootstrap.min.css">
    <link rel="stylesheet" href="./static/style.css">
  </head>
<body>
  <div id="upper-bar">
  	<a href="newtradeindex.jsp" id="title">거래 게시판</a>
  </div>
  <div id="content-view">
  	<div id="content-view-inner">
  	  <div id="write-view-title">거래글 업로드</div>
  	  <form id="write-form" action="submit_do.jsp" method="post" enctype="multipart/form-data">
  	  	<input type="text" id="write-title" name="title" placeholder="거래글 제목(30자 이내)" maxlength="30"><hr><br>
  	  	<textarea id="write-desc" name="desc" placeholder="거래글 내용(1000자 이내)" maxlength="1000"></textarea><hr><br>
  	  	썸네일 선택 (jpg, jpeg, png 파일만 업로드할 수 있습니다.)<br>
  	  	<input type="file" id="write-thumbnail" name="thumbnail" accept=".jpeg,.jpg,.png" required><br>
  	  	<img style="width: 360px; height: 202px; margin-top:30px;" id="preview-image" src="../../static/thumbnailPreview.png"><br>
  	  	(실제 보여질 이미지 크기입니다)<br><br>
  	  	<hr><br><br>
  	  	<div id="write-controller">
	  	  	<input type="text" id="write-author" name="author" placeholder="닉네임" maxlength="30">
	  	  	<input type="password" id="write-password" name="password" placeholder="비밀번호" maxlength="20">
	  	  	<input type="button" class="btn btn-danger" id="write-cancel" value="취소" onclick="cancel()">
	  	  	<input type="button" class="btn btn-info" id="write-submit" value="업로드" onclick="checkSubmit()">
  	  	</div>
  	  </form>
  	</div>
  </div>
  <div id="under-bar">인터넷 프로그래밍 동영상 관리 게시판</div>
</body>
<script type="text/javascript" src="./static/thumbnailPreview.js"></script>
<script type="text/javascript" src="./static/jquery.js"></script>
<script type="text/javascript" src="./static/bootstrap.min.js"></script>
<script type="text/javascript" src="./static/submit.js" charset='utf-8'></script>
</html>