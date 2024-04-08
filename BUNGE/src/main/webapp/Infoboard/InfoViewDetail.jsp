 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<html>
<head>
<title>상세페이지</title>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" href="css/view.css" type="text/css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="js/viewdetail.js"></script>
<style>
  body {
    font-family : 나눔고딕;
  }
  
 .inf_file {
 	width:50px
 }
 
 .commlike {
 	width:20px; height:20px;
 }
 
 .comment-like { 
 	display: flex; /* Flexbox 레이아웃 사용 */ 
 	text-align:center;
 }
 
 .comment-list-item .comment-nick-area img {
 	border:0; margin-right:10px;
 }
 
 #likeclick {
 	width:37px; height:37px;
 }

<%-- 프로필 부분 시작 --%>
.postprofile {
  border-radius : 50%;
}

.postuserid {
  font-size : 13px;
}

.postreg {
  font-size : 10px;
}
<%-- 프로필 부분 끝 --%>

 
<%-- 제목 부분 시작 --%>
.col-xl {
    -ms-flex-preferred-size: 0;
    flex-basis: 0;
    -ms-flex-positive: 1;
    flex-grow: 1;
    max-width: 80%;
    margin: 0 auto;
    /* border-bottom: 1px solid #BCE55C; */
}

.postsubject {
  font-weight : bolder;
  font-size : 25px;
  display : inline-block;
}

.posttool {
  text-align : center;
}

.btn-success {
    color: #fff;
    background-color: #BCE55C;
    border-color: #BCE55C;
}

.dropdowntool {
    position: absolute;
    display: inline-block;
    left: 787px;
    top: 25px;
}

<%-- 제목 부분 끝 --%>
 
<%-- "내용" 부분 시작 --%>
.form-control:disabled, .form-control[readonly] {
    background-color: #ffffff;
    opacity: 1;
}

pre {
    margin-top: 0;
    margin-bottom: 1rem;
    overflow: auto;
    white-space: break-spaces;
    font-family: 나눔고딕;
    word-wrap: break-word;
}

.postloc {
  font-weight : bolder;
}

.postbookinfoarea {
    font-size: 13px;
    display: inline-block;
    position: absolute;
    left:200px;
}

.postprofilearea {
    margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 1px solid #BCE55C;
}

.infoitem {
  margin-bottom:5px;
  margin-right:5px;
}

<%-- "내용" 부분 끝 --%>

<%-- 댓글 부분 시작 --%>
.comment-area {
    width : 858px;
    margin : 15px auto;
}

.comment-write .comment-write-area-text {
    overflow-x: hidden;
    overflow-y: auto;
    display: block;
    width: 100%;
    min-height: 40px;
    padding-right: 1px;
    border: 0;
    font-size: 13px;
    -webkit-appearance: none;
    resize: none;
    box-sizing: border-box;
    background: transparent;
    color: #000000;
    outline: 0;
}

<%-- 댓글 부분 끝 --%>


</style>
</head>
<body>
<input type="hidden" id="loginid" value="${m_id}" name="loginid"><%--view.js에서 사용하기 위해 추가합니다. --%>
<div class="container">
	<div class="col-xl">
	  <div class="postsubject">${boarddata.inf_subject}</div>
	  <c:if test="${boarddata.inf_open == 0}">
	    <span class="badge badge-success">공개</span>
	  </c:if>
	  <c:if test="${boarddata.inf_open == 1}">
	    <span class="badge badge-warning">비공개</span>
	  </c:if>
		<div class="dropdowntool">
		  <button type="button" class="btn btn-success dropdown-toggle droptool" data-toggle="dropdown">
		    더보기
		  </button>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="InfoList.com">목록</a>
		  <c:if test="${m_id != null}">
		    <a class="dropdown-item" href="InfoReply.com?inf_num=${boarddata.inf_num}">답변</a>
		  </c:if>
		  <c:if test="${m_id == boarddata.m_id}">
		    <a class="dropdown-item" href="InfoModify.com?inf_num=${boarddata.inf_num}">수정</a>
		    <a class="dropdown-item" href="InfoDelete.com">삭제</a>
		  </c:if>
		  </div>
		</div>
		
	  <div class="postprofilearea">
	    <img src="memberupload/${boarddata.m_profile}" width="30px" height="30px" class="postprofile">
	    <span class="postuserid">${boarddata.m_id}</span>
	    <span class="postreg">${boarddata.inf_reg}</span>
	  </div>
	  
	  <div class="postcontentarea">
	      <img src="${boarddata.inf_cover}" width="200px" height="300px">
	      <div class="postbookinfoarea">
		      <span class="badge badge-success infoitem">책제목</span><span class="postbooktitle">${boarddata.inf_book}</span><br>
		      <span class="badge badge-success infoitem">지은이</span><span>${boarddata.inf_author}</span><br>
		      <span class="badge badge-success infoitem">카테고리</span><span>${boarddata.inf_category}</span><br>
		      <span class="badge badge-success infoitem">출간일</span><span class="postbookpubdate">${boarddata.inf_pubdate}</span>
	      </div>
	    <pre class="postcontent">${boarddata.inf_content}</pre>
	    <div class="postloc">From ... ${boarddata.inf_loc}</div>
	    
	    <c:if test="${boarddata.inf_lev==0}">
          <tr>
            <td><div>첨부파일</div></td>
              <c:forEach var="a" items="${boardfile}" varStatus="status">
                <c:if test="${a.infa_filename != null}">
		          <td><img src="image/down.png" width="10px">
		            <a href="InfoBoardFileDown.com?filename=${a.infa_filename}">${a.infa_filename}</a>
		            <img src="boardupload/${a.infa_servername}" class="inf_file" id="inf_file${status.count}">
		          </td>
		        </c:if>
		        <c:if test="${a.infa_filename == null}">
		        </c:if>
              </c:forEach>
          </tr>
        </c:if>	
	    
	    <div class="imglike"><button><img src="./image/like_off.png" id="likeclick"></button></div>
        <span id="likecnt"></span>
	    
	  </div>
	</div> <%-- col-xl end --%>

   <%-- 댓글 시작 부분 --%>
   <div class="comment-area">
			<div class="comment-head">
				<h3 class="comment-count">
					댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
				</h3>
				<div class="comment-order">
					<ul class="comment-order-list">
					<%-- 등록순 / 최신순 들어가는 부분 --%>
					</ul>
				</div>
			</div><%-- comment-head end--%>
			<ul class="comment-list">
			</ul>
			<div class="comment-write">
				<div class="comment-write-area">
					<b class="comment-write-area-name" >${m_id}</b> 
					<span class="comment-write-area-count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
						class="comment-write-area-text" maxLength="200"></textarea>
					
				</div>
				<div class="register-box" >
					<div class="button btn-cancel" >취소</div><%-- 댓글의 취소는 display:none, 등록만 보이도록 합니다.--%>
					<div class="button btn-register" >등록</div>
				</div>
			</div><%--comment-write end--%>
		</div><%-- comment-area end--%>
		
		
<%-- modal 시작 --%>
    <div class="modal" id="mymodal">
    	<div class="modal-dialog">
    		<div class="modal-content">
    		<%-- Modal body --%>
    		<div class="modal-body">
    			<form name="deleteForm" action="InfoDelete.com" method="post">
    				<%-- http://localhost:8088/Board/BoardDetail.bo?num=22 
    					주소를 보묜 num을 파라미터로 넘기고 있습니다. 
    					이 값을 가져와서 ${param.num}를 사용
    					또는 ${boarddata.board_num}--%>
    			<input type="hidden" name="inf_num" value="${boarddata.inf_num}"
    					id="inf_num">
				<button type="submit" class="btn btn-primary">전송</button>   				
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>   				
    			</form>
    		</div>
    		</div>
    	</div>
    </div>


    
 
</div><%-- container end --%>


<%-- 테이블로 표시했던 부분 주석
 		<table class="table">
 			<tr>
 				<th colspan="2">MVC 게시판 - view 페이지 </th>
 			</tr>
 			<tr>
 				<td><div>글쓴이</div></td>
 				<td><div>${boarddata.m_id}</div></td>
 			</tr>
 			<tr>
 				<td><div>공개설정</div></td>
 				<td><div>${boarddata.inf_open}</div></td>
 			</tr>
 			<tr>
 				<td><div>책</div></td>
 				<td><div>${boarddata.inf_book}</div></td>
 			</tr>
 			<tr>
 				<td></td>
 				<td><div><img src="${boarddata.inf_cover}"></div></td>
 			</tr>
 			<tr>
 				<td><div>제목</div></td>
 				<td><c:out value="${boarddata.inf_subject}" /></td>
 			</tr>
 			<tr>
 				<td><div>내용</div></td>
 				<td style="padding-right:0px">
 					<textarea class="form-control" rows="5" readOnly>${boarddata.inf_content}
 					</textarea></td>
 			</tr>
 			<tr>
 				<td><div>위치</div></td>
 				<td><c:out value="${boarddata.inf_loc}" /></td>
 			</tr>
 			
 	    <c:if test="${boarddata.inf_lev==0}">
          <tr>
            <td><div>첨부파일</div></td>
              <c:forEach var="a" items="${boardfile}" varStatus="status">
                <c:if test="${a.infa_filename != null}">
		          <td><img src="image/down.png" width="10px">
		            <a href="InfoBoardFileDown.com?filename=${a.infa_filename}">${a.infa_filename}</a>
		            <img src="boardupload/${a.infa_servername}" class="inf_file" id="inf_file${status.count}">
		          </td>
		        </c:if>
		        <c:if test="${a.infa_filename == null}">
		        </c:if>
              </c:forEach>
          </tr>
        </c:if>		
        
        <tr>
          <td colspan="3" class="center">
            <c:if test="${boarddata.m_id == m_id || m_id == 'admin' }">
              <a href="InfoModify.com?inf_num=${boarddata.inf_num}">
                <button class="btn btn-info">수정</button>
              </a>
              <%-- href의 주소를 #으로 설정한다. --%>
<%--              
              <a href="#">
                <button class="btn btn-danger" data-toggle="modal"
                	    data-target="#myModal">삭제</button>
              </a>
            </c:if>
             <a href="InfoList.com">
              <button class="btn btn-warning">목록</button>
            </a>
            <a href="InfoReply.com?num=${boarddata.inf_num}">
              <button class="btn btn-success">답변</button>
            </a>
          </td>
        </tr>
        <tr> 
         <td class="imglike"><button><img src="./image/like_off.png" id="likeclick"></button>
         <span id="likecnt"></span></td>
 --%>
 <%--                      
      </tr>
      </table>
      
--%>
<%-- 게시판 view end --%>
    

<%-- ></div> <%-- class="container" end --%>
</body>
			