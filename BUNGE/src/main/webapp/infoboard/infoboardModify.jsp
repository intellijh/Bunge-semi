<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>MVC 게시판</title>
<%@ include file="/layout/header.jsp" %>
<script src="js/modifyform.js"></script>
<style>
 .container {width:60%}
 h1 {font-size:1.5rem; text-align:center; color:#1a92b9}
 #upfile {display:none}
</style>
</head>
<body>
  <%-- 게시판 수정 --%>
  <div class="container">
    <form action="InfoModifyProcess.com" method="post" name="modifyform" enctype="multipart/form-data">
      <input type="hidden" name="inf_num" value="${boarddata.inf_num}">
      <h1>MVC 게시판 - 수정</h1>
      <div class="form-group">
        <label for="m_id">글쓴이</label>
        <input type="text" class="from-control"
        	   value="${boarddata.m_id}" readOnly>
      </div>
      <div class="form-group">
        <label for="inf_subject">제목</label>
        <input name="inf_subject"
        	   id="inf_subject" type="text" class="from-control"
        	   value="${boarddata.inf_subject}">
      </div>
      
      <div class="form-group">
        <label for="inf_content">내용</label>
        <textarea name="inf_content" id="inf_content"
        	   	  class="form-control" rows="10">${boarddata.inf_content}</textarea>
      </div>
    <%-- 원문글인 경우에만 파일 첨부 수정 가능하다 --%>
    <c:if test="${boarddata.inf_lev==0}">
      <div class="form-group">
        <label>파일첨부
          <img src="image/attach.png" alt="파일첨부" width="20px">
          <input type="file" id="infa_filename1" name="infa_filename1">
          <img src="image/attach.png" alt="파일첨부" width="20px">
          <input type="file" id="infa_filename2" name="infa_filename2">
          <img src="image/attach.png" alt="파일첨부" width="20px">
          <input type="file" id="infa_filename3" name="infa_filename3">
          <img src="image/attach.png" alt="파일첨부" width="20px">
          <input type="file" id="infa_filename4" name="infa_filename4">
          <img src="image/attach.png" alt="파일첨부" width="20px">
          <input type="file" id="infa_filename5" name="infa_filename5">
        </label>
        <span id="filevalue">${boarddata.board_file}</span>
        <img src="image/remove.png" alt="파일삭제" width="10px" class="remove">
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