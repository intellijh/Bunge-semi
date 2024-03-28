<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
 <script src="${pageContext.request.contextPath}/js/writeform.js"></script>
 <style>
	h1{font-size:1.5em; text-align:center; color:#1a92b9}
	.container{width:60%}
	
	label{font-weight:bold}
	#upfile{display:none}
	img{width:20px}
 </style>
 </head>
 <body>
 <div class="container">
  <form action="InfoAdd.com" method="post" enctype="multipart/form-data"
  		name="boardform">
  	<div class="form-group">
  		<label for="m_id">글쓴이</label>
  		<input name="m_id" id="m_id" type="text" class="form-control"
  			   placeholder="Enter m_id">
  		</div>	
  		
  		<div class="form-group">
  		<label for="inf_subject">제목</label>
  		<input name="inf_subject" id="inf_subject" type="text" maxlength="100"		 
  			   class="form-control" placeholder="Enter inf_subject">
  		</div>	
  		
  		<div class="form-inline">
  		<label for="inf_open">공개설정</label>
  		<input type="radio" name="inf_open" id="inf_open" value="0" class="radio"><span class="pr_0">공개</span>&nbsp;&nbsp;&nbsp;
  		<input type="radio" name="inf_open" id="inf_open" value="1" class="radio"><span class="pr_1">비공개</span>
  		</div>	
  		
  		<div class="form-group">
  		<label for="inf_content">내용</label>
  		<textarea name="inf_content" id="inf_content" rows="10" 	 
  			   class="form-control" ></textarea>
  		</div>	
  		<div class="form-group">
  		<label>파일첨부
  		<img src="image/attach.png" alt="파일첨부">
  		<input name="inf_file" id="inf_file" type="file">
  		</label>
  		<span id="filevalue"></span>
  		</div>
  		
  		 <label for="address">위치</label>
  		    <input type="text" size="50" name="address" id="address">
  		    <input type="button" value="위치찾기" id="postcode">
  		
  		<div class="form-group">
				<button type="submit">등록</button>
				<input type="button">취소
				
<%-- 				<button type="submit" class="btn btn-primary">등록</button>
				<button type="submit" class="btn btn-danger">취소</button> --%>
		</div>
  		</form>
 </div>
 </body>
</head>