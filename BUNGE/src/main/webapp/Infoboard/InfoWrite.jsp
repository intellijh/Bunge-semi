<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<title>글쓰기</title>
<head>
<script src = "http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
 <script src="${pageContext.request.contextPath}/js/writeform.js"></script>
 <style>
	h1{font-size:1.5em; text-align:center; color:#1a92b9}
	
	.container{width:60%}
	
	label{font-weight:bold}

	img{width:15px}
	
	.input-group1, .input-group2, .input-group3, .input-group4, .input-group5 {display:none}
	
	input[type=file]{display:none}
 </style>
 </head>
 <body>
 <div class="container">
  <form action="InfoAdd.com" method="post" enctype="multipart/form-data" name="boardform">
  	<div class="form-group">
  		<label for="m_id">글쓴이</label>
  		<input name="m_id" id="m_id" type="text" value="${m_id}" class="form-control" placeholder="Enter m_id" readOnly>
  		</div>	
  		
  		<div class="form-group">
  		<label for="inf_open">공개설정</label>
  		<input type="radio" name="inf_open" id="inf_open1" value="0" class="radio"><span class="pr_0">공개</span>&nbsp;&nbsp;&nbsp;
  		<input type="radio" name="inf_open" id="inf_open2" value="1" class="radio"><span class="pr_1">비공개</span>
  		</div>	

  		<div class="form-group">
  		<label for="inf_subject">제목</label>
  		<input name="inf_subject" id="inf_subject" type="text" maxlength="100"		 
  			   class="form-control" placeholder="Enter inf_subject">
  		</div>	
  		
  		
  		<div class="form-group">
  		<label for="inf_content">내용</label>
  		<textarea name="inf_content" id="inf_content" rows="10" 	 
  			   class="form-control" ></textarea>
  		</div>
  		
  		<%-- 이 부분 <c:forEach> 이용해서 바꿀 수 있을 것 같다 --%>
  		<%-- 시간이 된다면, X버튼 만들어서 첨부파일 취소하는 기능 추가 --%>
  		<button type="button" id="inputfile-btn">파일추가</button> (파일 첨부는 최대 5개까지 가능합니다...)
  		<div class="input-group1">
	 	  <label>
	 	    첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <input type="file" name="inf_file1" onchange="readURL(this)">
	 	  </label>
	 	    <span id="filevalue1"></span>
  		</div>
  		
  		<div class="input-group2">
	 	  <label for="inf_file">
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <input type="file" name="inf_file2" onchange="readURL(this)">
	 	    <span id="filevalue2"></span>
	 	  </label>
  		</div>
  		
  		<div class="input-group3">
	 	  <label for="inf_file">
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <input type="file" name="inf_file3" onchange="readURL(this)">
	 	    <span id="filevalue3"></span>
	 	  </label>
  		</div>
  		
  		<div class="input-group4">
	 	  <label for="inf_file">
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <input type="file" name="inf_file4" onchange="reaudURL(this)">
	 	    <span id="filevalue4"></span>
	 	  </label>
  		</div>
  		
  		<div class="input-group5">
	 	  <label for="inf_file">
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <input type="file" name="inf_file5" onchange="reaudURL(this)">
	 	    <span id="filevalue5"></span>
	 	  </label>
  		</div>
  		
 		
 		<div class="form-group">
  		 <label for="address">위치</label>
  		    <input type="text" size="50" name="inf_loc" id="inf_loc">
  		    <input type="button" value="위치찾기" id="postcode">
 		</div>
  		
   		 <div class="form-group">
				<button type="submit" class="submit-btn">등록</button>
				<button type="reset" class="cancel-btn">취소</button>
		</div>
	</form>
  </div>
 </body>
</head>