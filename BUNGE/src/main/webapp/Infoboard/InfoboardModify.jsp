<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>수정 페이지</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<jsp:include page="/layout/header.jsp" />
<script src="js/infomodifyform.js"></script>
<style>
.nav-item {

}
  .container{
    width:60%
  }
  
  h1 {font-size:1.5rem; text-align:center; color:#1a92b9}
  
  input[type=file] {display:none}
  
  .attach {display:inline-block;}
  
  #preview1, #preview2, #preview3, #preview4, #preview5 {display:none}
  
  .attachname {display:none}
  
  .input-group1, .input-group2, .input-group3, .input-group4, .input-group5 {display:none}
  
.badge-success {
  color:white;
  border:1px solid white;
  border-bottom-width:6px;
}

.searchbtn {
  color:white;
}

.searchbtn:visited {
  color: white;
}

label {
  font-weight:bold;
}

.infoitem {
  margin-bottom:5px;
  margin-right:5px;
}

.postbookinfoarea {
    font-size: 13px;
    display: inline-block;
    position: absolute;
    top: 256px;
    width: 44%;
}

.infloc {
  margin-top:10px;
}

.subjectarea {
  width:100%;
}

.locarea {
  width: 84.77%;
}

#inf_book {
  margin-bottom:20px;
}
</style>
</head>
<body>
  <%-- 게시판 수정 --%>
  <div class="container">
    <form action="InfoModifyProcess.com" method="post" name="modifyform" enctype="multipart/form-data">
      <input type="hidden" name="inf_num" value="${board.inf_num}" id="inf_num">
      <div class="form-group">
        <label for="m_id">글쓴이</label>
        <input type="text" class="from-control"
        	   value="${board.m_id}" readOnly>
      </div>
	
      <%-- 공개/비공개 추가 --%>
      
      <div class="form-group">
  		<label for="inf_open">공개설정</label>
      	<c:if test="${board.inf_open==0}">
  		  <input type="radio" name="inf_open" id="inf_open1" value="0" class="radio" checked><span class="pr_0">공개</span>&nbsp;&nbsp;&nbsp;
  		  <input type="radio" name="inf_open" id="inf_open2" value="1" class="radio"><span class="pr_1">비공개</span>
      	</c:if>
      	<c:if test="${board.inf_open==1}">
  		  <input type="radio" name="inf_open" id="inf_open1" value="0" class="radio"><span class="pr_0">공개</span>&nbsp;&nbsp;&nbsp;
  		  <input type="radio" name="inf_open" id="inf_open2" value="1" class="radio" checked><span class="pr_1">비공개</span>
      	</c:if>
      </div>
      
      <div class="form-group">
      <c:if test="${board.inf_book != null && param.booktitle == null}"> 
        <label for="inf_book">책</label>
          <button type="button" class="badge badge-success"><a class="searchbtn" href="Infobooksearch.com?state=modify&inf_num=${board.inf_num}">검색</a></button>
          <input name="inf_book" id="inf_book" type="text" class="form-control" value="${board.inf_book}" size="100px" readOnly>
          <img src="${board.inf_cover}" class="inf_cover" id="inf_cover">
          <input type="hidden" name="inf_cover" value="${board.inf_cover}">
          <div class="postbookinfoarea">
		      <span class="badge badge-success infoitem">책제목</span><span class="postbooktitle">${board.inf_book}</span><br>
		      <span class="badge badge-success infoitem">지은이</span><span>${board.inf_author}</span><br>
		        <input type="hidden" name="inf_author" value="${board.inf_author}">
		      <span class="badge badge-success infoitem">카테고리</span><span>${board.inf_category}</span><br>
		        <input type="hidden" name="inf_category" value="${board.inf_category}">
		      <span class="badge badge-success infoitem">출간일</span><span class="postbookpubdate">${board.inf_pubdate}</span>
		        <input type="hidden" name="inf_pubdate" value="${board.inf_pubdate}">
	      </div>
      </c:if>
      <c:if test="${param.bookcover != null}"> 
        <label for="inf_book">책</label>
          <button type="button" class="badge badge-success searchbtn"><a class="searchbtn" href="Infobooksearch.com?state=modify&inf_num=${board.inf_num}">검색</a></button>
          <input name="inf_book" id="inf_book" type="text" class="form-control" value="${param.booktitle}" size="100px" readOnly>
          <img src="${param.bookcover}" class="inf_cover" id="inf_cover">
          <input type="hidden" name="inf_cover" value="${param.bookcover}">
           <div class="postbookinfoarea">
		      <span class="badge badge-success infoitem">책제목</span><span class="postbooktitle">${param.bookcover}</span><br>
		      <span class="badge badge-success infoitem">지은이</span><span>${param.bookauthor}</span><br>
		        <input type="hidden" name="inf_author" value="${param.bookauthor}">
		      <span class="badge badge-success infoitem">카테고리</span><span>${param.bookcategoryname}</span><br>
		        <input type="hidden" name="inf_category" value="${param.bookcategoryname}">
		      <span class="badge badge-success infoitem">출간일</span><span class="postbookpubdate">${param.bookpubdate}</span>
		        <input type="hidden" name="inf_pubdate" value="${param.bookpubdate}">
	      </div> 
      </c:if>
      </div>
      
      <div class="form-group">
        <label for="inf_subject">제목</label>
        <input name="inf_subject" id="inf_subject" type="text" class="from-control subjectarea" value="${board.inf_subject}">
      </div>
      
      <div class="form-group">
        <label for="inf_content">내용</label>
        <span id="writecount" class="comment-write-area-count">0/1000</span>
        <textarea name="inf_content" id="inf_content" class="form-control" rows="10">${board.inf_content}</textarea>
      </div>
      
      <%-- 장소 추가 --%>
      
    <%-- 원문글인 경우에만 파일 첨부 수정 가능하다 --%>
    

    
<c:if test="${board.inf_lev==0}">
      <button type="button" id="inputfile-btn" class="badge badge-success" data-toggle="tooltip" title="5개까지 첨부할 수 있어요">파일추가</button>
 	<c:if test="${boardfile[0] == null}">
 	  <div class="input-group1">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview1" width="50px">
	 	    <input type="file" name="upfile1" id="upfile1" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filename1"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" id="remove1" class="remove">
  		</div>
  	</c:if>
    <c:if test="${boardfile[0] != null}">
      <div class="input-group1">
          <label>
            <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview1" width="50px">
            <input type="file" id="upfile1" class="upfile1" name="upfile1" onchange="readURL(this)">
            <img src="boardupload/${boardfile[0].infa_filename}" width="50px" class="uploadedfile1">
            <img id="preview1" width="50px">
            <span class="filename" id="filename1">${boardfile[0].infa_filename}</span>
          </label>
            <img src="image/remove.png" alt="파일삭제" width="10px" id="remove1" class="remove">
     </div>
    </c:if>
    
    <c:if test="${boardfile[1] == null}">
 	  <div class="input-group2">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview2" width="50px">
	 	    <input type="file" name="upfile2" id="upfile2" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filename2"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" id="remove2" class="remove">
  		</div>
  	</c:if>
    <c:if test="${boardfile[1] != null}">
      <div class="input-group2">
          <label>
            <img src="image/attach.png" alt="파일첨부" width="30px">
            <input type="file" id="upfile2" class="upfile2" name="upfile2" onchange="readURL(this)">
            <img src="boardupload/${boardfile[1].infa_filename}" width="50px" class="uploadedfile2">
            <img id="preview2" width="50px">
            <span class="filename" id="filename2">${boardfile[1].infa_filename}</span>
          </label>
            <img src="image/remove.png" alt="파일삭제" width="10px" id="remove2" class="remove">
     </div>
    </c:if>
    
    <c:if test="${boardfile[2] == null}">
 	  <div class="input-group3">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview3" width="50px">
	 	    <input type="file" name="upfile3" id="upfile3" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filename3"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" id="remove3" class="remove">
  		</div>
  	</c:if>
    <c:if test="${boardfile[2] != null}">
      <div class="input-group3">
          <label>
            <img src="image/attach.png" alt="파일첨부" width="30px">
            <input type="file" id="upfile3" class="upfile3" name="upfile3" onchange="readURL(this)">
            <img src="boardupload/${boardfile[2].infa_filename}" width="50px" class="uploadedfile3">
            <img id="preview3" width="50px">
            <span class="filename" id="filename3">${boardfile[2].infa_filename}</span>
          </label>
            <img src="image/remove.png" alt="파일삭제" width="10px" id="remove3" class="remove">
      </div>
    </c:if>
    
    <c:if test="${boardfile[3] == null}">
 	  <div class="input-group4">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview4" width="50px">
	 	    <input type="file" name="upfile4" id="upfile4" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filename4"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" id="remove4" class="remove">
  		</div>
  	</c:if>
    <c:if test="${boardfile[3] != null}">
      <div class="input-group4">
          <label>
            <img src="image/attach.png" alt="파일첨부" width="30px">
            <input type="file" id="upfile4" class="upfile4" name="upfile4" onchange="readURL(this)">
            <img src="boardupload/${boardfile[3].infa_filename}" width="50px" class="uploadedfile4">
            <img id="preview4" width="50px">
            <span class="filename" id="filename4">${boardfile[3].infa_filename}</span>
          </label>
            <img src="image/remove.png" alt="파일삭제" width="10px" id="remove4" class="remove">
      </div>
    </c:if>
    
    <c:if test="${boardfile[4] == null}">
 	  <div class="input-group5">
	 	  <label>
	 	    <img src="image/attach.png" alt="파일첨부" width="30px">
  		    <img id="preview5" width="50px">
	 	    <input type="file" name="upfile5" id="upfile5" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filename5"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" id="remove5" class="remove">
  		</div>
  	</c:if>
    <c:if test="${boardfile[4] != null}">
      <div class="input-group5">
          <label>
            <img src="image/attach.png" alt="파일첨부" width="30px">
            <input type="file" id="upfile5" class="upfile5" name="upfile5" onchange="readURL(this)">
            <img src="boardupload/${boardfile[4].infa_filename}" width="50px" class="uploadedfile5">
            <img id="preview5" width="50px">
            <span class="filename" id="filename5">${boardfile[4].infa_filename}</span>
          </label>
            <img src="image/remove.png" alt="파일삭제" width="10px" id="remove5" class="remove">
      </div>
    </c:if>
    
</c:if>
    
    
<%--    
    <c:if test="${boardfile[0] == null}">
 	  <div class="input-group1">
	 	  <label>
	 	    첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
  		    <img id="preview1">
	 	    <input type="file" name="inf_file1" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue1"></span>
 	 		<img src="image/remove.png" alt="파일삭제" width="10px" class="remove1">
  		</div>
  	</c:if>
    <c:if test="${boardfile[0] != null}">
      <div>첨부한 파일목록 (클릭하면 첨부파일을 수정할 수 있습니다)</div>
          <label>
            <input type="file" id="uploadedfile1" class="uploadedfile1" name="uploadedfile1" onchange="readURL(this)">
            <img src="boardupload/${boardfile[0].infa_filename}" width="50px" class="uploadedfile${status.count}">
            <img id="preview${status.count}" width="50px">
          </label>
    </c:if>
      	
      	
      	<div class="input-group2">
	 	  <label>
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <img id="preview2">
	 	    <input type="file" name="inf_file2"  onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue2"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove2">
  		</div>
  		
  		<div class="input-group3">
	 	  <label>
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <img id="preview3">
	 	    <input type="file" name="inf_file3" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue3"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove3">
  		</div>
  		
  		<div class="input-group4">
	 	  <label>
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <img id="preview4">
	 	    <input type="file" name="inf_file4" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue4"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove4">
  		</div>
  		
  		<div class="input-group5">
	 	  <label>
	 	  첨부파일
	 	    <img src="image/attach.png" alt="파일첨부">
	 	    <img id="preview5">
	 	    <input type="file" name="inf_file5" onchange="readURL(this)">
	 	  </label>
	 	    <span class="filename" id="filevalue5"></span>
	 	    <img src="image/remove.png" alt="파일삭제" width="10px" class="remove5">
  		</div>
    </c:if>
--%>
    
      <div class="form-group">
        <label for="inf_loc">위치</label>
        <input type="text" size="50" name="inf_loc" id="inf_loc" class="locarea" value="${board.inf_loc}">
        <input type="button" value="위치수정" id="postcode">
      </div>
      
      <div class="form-group infloc">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-danger" id="cancel">취소</button>
      </div>
        
    </form>
  </div><%-- class="container" end --%>
</body>
</html>