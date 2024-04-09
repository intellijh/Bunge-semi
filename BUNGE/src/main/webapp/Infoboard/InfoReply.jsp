<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>답글 쓰기 </title>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<%@ include file="/layout/header.jsp" %>
 <script src="js/reply.js"></script>
 <style>
	h1 {
		font-size:1.5em; text-align:center; color:#1a92b9
	}
	.container {
		width:60%;
		padding-top : 60px;
	}
	
	body > div > form > div:nth-child(7) {
		text-align : center
	}
	
	label{font-weight:bold}
	#upfile{display:none}
 </style>
 </head>
 <body>
 <div class="container">
  <form action="InfoReplyProcess.com" method="post" name="replyform">
  		<input name="inf_ref" value="${boarddata.inf_ref}" type="hidden">
  		<input name="inf_lev" value="${boarddata.inf_lev}" type="hidden">
  		<input name="inf_seq" value="${boarddata.inf_seq}" type="hidden">
		<div class="form-group">
			<label for="m_id">글쓴이</label>
			<input name="m_id" id="m_id" type="text" value="${m_id}"		 
  			   class="form-control" readonly>
		</div>
		<div class="form-group">		
		   <label for="inf_subject">제목</label>
		   <textarea name="inf_subject" id="inf_subject" rows="1" maxlength="100"		 
  			   class="form-control">Re:${boarddata.inf_subject}</textarea>
  		</div>	
  		<div class="form-group">
  			<label for="inf_content">내용</label>
  			<textarea name="inf_content" id="inf_content" rows="10" 	 
  			   class="form-control"></textarea>
  		</div>
  		<div class="form-group">
				<input type="submit" class="btn btn-primary" value="등록">
				<input type="button" class="btn btn-danger" value="취소" 
					   onClick="history.go(-1)">
		</div>
  		</form>
 </div>
 </body>
</head>