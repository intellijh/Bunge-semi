<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<title>글쓰기</title>
<head>
<jsp:include page="/layout/header.jsp" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script src="${pageContext.request.contextPath}/js/writeform.js"></script>
 <style>
body {
  font-family:나눔고딕;
} 

h1 {
  font-size:1.5em;
  text-align:center;
  color:#1a92b9
}
	
.container {
    width: 1140px;
    margin: 40px auto;
}
	
label {
  font-weight:bold
}

.inf_cover {
  display:none;
  float:left;
}
	
.input-group1, .input-group2, .input-group3, .input-group4, .input-group5 {
  display:none
  }
	
input[type=file]{
  display:none
}
	
.remove1, .remove2, .remove3, .remove4, .remove5 {
  display:none
}
	
.postsubject{
  clear : both;
}

.bookinfo {
  font-size : 13px;
}

.bookinfoarea {
    width: auto;
    font-size: 15px;
}

.badge-success {
  color:white;
  border:1px solid white;
  border-bottom-width:6px;
}

.badge-info {
  color:white;
  border:1px solid white;
  border-bottom-width:6px;
}

.badge-warning {
  color:white;
  border:1px solid white;
  border-bottom-width:6px;
}

.badge-danger {
  color:white;
  border:1px solid white;
  border-bottom-width:6px;
}

textarea {
  resize:vertical;
  width:800px;
}

.preview {
  display:none;
}

.badge:empty {
    display: inline-block;
}

#inf_cover {
  margin-right:15px;
  margin-bottom:15px;
}

#searchbtn {
  color:white;
}

#searchbtn:visited {
  color:white;
}

.lastbtn {
  font-size:25px;
}

.infloc {
  margin-bottom:50px;
}
 </style>
 </head>
 <body>
 <div class="container">
  <form action="InfoAdd.com" method="post" enctype="multipart/form-data" name="boardform">
  	<div class="form-group">
  		<label for="m_id">글쓴이</label>
  		<input name="m_id" id="m_id" type="text" value="${m_id}" readOnly>
  		</div>	
  		
  		<div class="form-group">
  		<label for="inf_open">공개설정</label>
  		  <input type="radio" name="inf_open" id="inf_open1" value="0" class="radio" checked><span class="pr_0">공개</span>&nbsp;&nbsp;&nbsp;
  		  <input type="radio" name="inf_open" id="inf_open2" value="1" class="radio"><span class="pr_1">비공개</span>
  		</div>
  		
  		
		<div class="form-group">
	  		<label for="inf_book">책
		 		<input name="inf_book" id="inf_book" type="text" placeholder="'검색' 버튼을 눌러주세요" readOnly value="${booktitle}" size="90px">
	          	  <button type="button" class="badge badge-success"><a id="searchbtn" href="Infobooksearch.com?state=write">검색</a></button>
	        </label>
	      <c:if test="${booktitle != null}">
	        <div>
		 		<img src="${bookcover}" class="inf_cover" id="inf_cover" width="150px" height="200px">
	        </div>
	        <div class="bookinfoarea">
		 		<input type="hidden" value="${bookcover}" name="inf_cover" id="inf_cover">
		 		<span class="badge badge-success">책제목</span><span class="bookinfo">${booktitle}</span><br>
		 		<span class="badge badge-success">지은이</span><span class="bookinfo">${bookauthor}</span><br>
				  <input type="hidden" name="inf_author" value="${bookauthor}">
		 		<span class="badge badge-success">카테고리</span><span class="bookinfo">${bookcategoryname}</span><br>
		 		  <input type="hidden" name="inf_category" value="${bookcategoryname}">
		 		<span class="badge badge-success">출간일</span><span class="bookinfo">${bookpubdate}</span>
		 		  <input type="hidden" name="inf_pubdate" value="${bookpubdate}">
	  		</div>
	  	  </c:if>
  		</div>
  		

  		<div class="form-group postsubject">
   		  <label for="inf_subject">글 제목</label>
  		  <input name="inf_subject" id="inf_subject" type="text" maxlength="100" placeholder="게시글 제목을 입력하세요..." maxlength="100" size="86px">
  		</div>	
  		
  		
  		<div class="form-group">
  		  <label for="inf_content">글 내용</label>
  		  <span id="writecount" class="comment-write-area-count">0/1000</span>
  		  <div class="postcontentarea">
  		    <textarea name="inf_content" id="inf_content" rows="10" class="postcontent" maxlength="1000" placeholder="내용을 입력하세요..."></textarea>
  		  </div>
  		</div>
  		
  		<%-- 이 부분 <c:forEach> 이용해서 바꿀 수 있을 것 같다 --%>
  		<%-- 시간이 된다면, X버튼 만들어서 첨부파일 취소하는 기능 추가 --%>
  		<div class="form-group">
	  	  <label>첨부파일</label>
	      <button type="button" id="inputfile-btn" class="badge badge-success" data-toggle="tooltip" title="최대 5개까지 가능합니다">파일추가</button>
  		</div>
  		<div class="input-group1">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px" height="30px">
  		    <img class="preview" id="preview1" width="30px" height="30px">
	 	    <input type="file" name="inf_file1" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue1"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" class="remove1">
  		</div>
  		
  		<div class="input-group2">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px" height="30px">
	 	    <img class="preview" id="preview2" width="30px" height="30px">
	 	    <input type="file" name="inf_file2"  onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue2"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove2">
  		</div>
  		
  		<div class="input-group3">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px" height="30px">
	 	    <img class="preview" id="preview3" width="30px" height="30px">
	 	    <input type="file" name="inf_file3" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue3"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove3">
  		</div>
  		
  		<div class="input-group4">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px" height="30px">
	 	    <img class="preview" id="preview4" width="30px" height="30px">
	 	    <input type="file" name="inf_file4" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue4"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove4">
  		</div>
  		
  		<div class="input-group5">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px" height="30px">
	 	    <img class="preview" id="preview5" width="30px" height="30px">
	 	    <input type="file" name="inf_file5" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue5"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove5">
  		</div>
  		
 		
 		<div class="form-group infloc">
  		 <label for="address">위치</label>
  		    <input type="text" size="50" name="inf_loc" id="inf_loc">
  		    <input type="button" class="badge badge-success" value="위치찾기" id="postcode">
 		</div>
  		
   		 <div class="form-group">
				<button type="submit" class="badge badge-info lastbtn">등록</button>
				<button id="cancelbtn" type="reset" class="badge badge-danger lastbtn">취소</button>
		</div>
	</form>
  </div>
 </body>
</head>