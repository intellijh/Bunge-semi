<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="net.trade.db.Trade,net.trade.db.TradeDAO"%>
<%
	request.setCharacterEncoding("utf-8");
	
	TradeDAO tradeDAO = new TradeDAO();
	// 글 정보 조회
	Trade trade = tradeDAO.selectOneTradeById(Integer.parseInt(request.getParameter("tradeID")));
	
	tradeDAO.close();
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title><%=trade.getTitle()%> - Trade Board</title>
    <link rel="stylesheet" href="./static/bootstrap.min.css">
    <link rel="stylesheet" href="./static/style.css">
  </head>
<body>
  <div id="upper-bar">
  	<a href="index.jsp" id="title">Video Board</a>
  </div>
  <div id="content-view">
  	<div id="content-view-inner">
  	  <div id="video-wrap">
	  <video src="<%="./upload/"+trade.getTradeID()%>" controls autoplay>
		이 브라우저는 지원하지 않습니다.
	  </video>
  	  </div>
  	  <div id="video-info">
  		<div id="video-title"><%=trade.getTitle()%></div>
  		<span id="video-author"><%=trade.getSellerID()%></span>
  		<span id="video-date" style="float:right"><%=trade.getCreateDate()%></span>
  		<form method="POST" id="delete-or-update-form">
  			<input type="hidden" name="id" value="<%=trade.getSellerID()%>">
  			<input type="password" name="password" style="margin-left:0px; margin-top:10px" id="write-password" placeholder="비밀번호">
  			<input type="button" value="수정" id="update-button" class="btn btn-info" onclick="update()">
			<input type="button" value="삭제" id="delete-button" class="btn btn-danger" onclick="del()">
  		</form>
  		<p style="margin-top:30px"><%=trade.getDescription()%></p>
  	  </div>
  	  <div id="comment">
  	  	<span id="comment-title">댓글</span>
  		<hr>
  		<div id="comment-write-form">
  			<input type="hidden" id="videoId" value="<%=trade.getSellerID()%>">
			<div id="comment-write-info">
				<input type="text" id="comment-write-author" placeholder="작성자" value="익명">
				<hr>
				<input type="password" id="comment-write-password" placeholder="비밀번호">
			</div>
			<div id="comment-write-content">
				<textarea id="comment-write-desc"></textarea>
			</div>
			<input type="button" id="comment-submit-button" class="btn btn-info" value="작성" onclick="commentSubmit()"> 
  		</div>
  		<hr>
  		<div id="comment-list"></div>
  	  </div>
  	</div>
  </div>
  <div id="under-bar">인터넷 프로그래밍 동영상 관리 게시판</div>
</body>
<script type="text/javascript" src="./static/jquery.js"></script>
<script type="text/javascript" src="./static/bootstrap.min.js"></script>
<script type="text/javascript" src="./static/deleteOrUpdate.js"></script>
<script type="text/javascript" src="./static/comment.js"></script>
</html>