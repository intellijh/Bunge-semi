<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>MVC 게시판</title>
<%@ include file="/layout/header.jsp" %>
<script src="js/infomodifyform.js"></script>
<style>
  .container {width:60%}
  h1 {font-size:1.5rem; text-align:center; color:#1a92b9}
  input[type=file] {display:none}
  .attach {display:inline-block;}
</style>
</head>
<body>
  <%-- 게시판 수정 --%>
  <div class="container">
    <form action="InfoModifyProcess.com" method="post" name="modifyform" enctype="multipart/form-data">
      <input type="hidden" name="inf_num" value="${board.inf_num}">
      <h1>MVC 게시판 - 수정</h1>
      <div class="form-group">
        <label for="m_id">글쓴이</label>
        <input type="text" class="from-control"
        	   value="${board.m_id}" readOnly>
      </div>
      <div class="form-group">
        <label for="inf_subject">제목</label>
        <input name="inf_subject"
        	   id="inf_subject" type="text" class="from-control"
        	   value="${board.inf_subject}">
      </div>
      
      <div class="form-group">
        <label for="inf_content">내용</label>
        <textarea name="inf_content" id="inf_content"
        	   	  class="form-control" rows="10">${board.inf_content}</textarea>
      </div>
    <%-- 원문글인 경우에만 파일 첨부 수정 가능하다 --%>
    <c:if test="${board.inf_lev==0}">
      <div class="form-group">
        <br>
        <c:forEach var="a" items="${boardfile}" begin="0" varStatus="status">
          <label class="attach">파일첨부
        	<img src="image/down.png" alt="파일첨부" width="10px">
        	<input type="file" id="upfile${status.count}" name="board_file">
        	<img src="boardupload/${a.infa_filename}" width="10px" class="uploadedfile${status.count}">
        	<span id="filevalue${status.count}">${a.infa_filename}</span>
          </label>
	        <img src="image/remove.png" alt="파일삭제" width="10px" class="remove${status.count}"><br>
        </c:forEach>

      </div>
    </c:if>
    
      <div class="form-group">
        <button type=submit class="btn btn-primary">수정</button>
        <button type=reset class="btn btn-danger" onClick="history.go(-1)">취소</button>
      </div>
        
    </form>
  </div><%-- class="container" end --%>
<%@ include file="/layout/footer.jsp" %>
</body>
</html>