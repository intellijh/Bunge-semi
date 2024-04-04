<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 수정</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<jsp:include page="/layout/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/mypage.js"></script>
<style>

</style>
</head>
<body>
<div id="wrap">
<div class="tab_container">
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
		   <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>즐겨찾기</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>중고거래 찜</span></li></a>
		  </ul>
		</div>

	<h3>회원 정보 수정</h3>
		<hr>
		<div class="m_profile">
		<b>프로필 사진</b>
		<label>
			<img src="image/attach.png" width="10px">
			<span id="filename">${memberinfo.member.m_profile}</span>
			<span id="showImage">
					<c:set var="src" value='${"memberupload/"}${memberinfo.member.m_profile}'/>
					<input id="m_profile"  type="hidden" name="m_profile"  value="${memeberinfo.member.m_profile }">
				<img alt="profile" src="${src}" width="20px">
			</span>
		 	<button type="button" data-toggle="modal" data-target="#filemodal">수정</button> 
		</label>
		</div>
		
	<%-- 프로필 변경 modal 시작 --%>
    <div class="modal" id="filemodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_profile">프로필변경</label>
                 <input type="file" class="form-contorl" name="m_profile" accept="image/*" id="m_profile">
               </div>
               <input type="hidden" name="m_pwd" value="${memberinfo.member.m_pwd}" id="m_pwd">
               <input type="hidden" name="m_nick" value="${memberinfo.member.m_nick}" id="m_nick">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_addr2" value="${memberinfo.member.m_addr2}" id="m_addr2">
               <input type="hidden" name="m_phone" value="${memberinfo.member.m_phone}" id="m_phone">
               <input type="hidden" name="m_email" value="${memberinfo.member.m_email}" id="m_email">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 프로필 변경 modal 끝 --%>
		
		
		<div class="m_id">
			<b>아이디</b>
			<input type="text" name="m_id" value="${memberinfo.member.m_id}" readonly>
		</div>
		
		<div class="m_pwd">
		<b>비밀번호</b>
			<input type="text" id="origin_m_pwd" maxlength="15"  value="${memberinfo.member.m_pwd}" readonly>
			<button type="button" data-toggle="modal" data-target="#pwdmodal">수정</button>
		</div>
		
	<%-- 비밀번호 변경 modal 시작 --%>
    <div class="modal" id="pwdmodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_pwd">새로운 비밀번호</label>
                 <input type="text" class="form-contorl" name="m_pwd" id="m_pwd">
                 <div id="pwd_message"></div>
               </div>
               <input type="hidden" name="m_nick" value="${memberinfo.member.m_nick}" id="m_nick">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_addr2" value="${memberinfo.member.m_addr2}" id="m_addr2">
               <input type="hidden" name="m_phone" value="${memberinfo.member.m_phone}" id="m_phone">
               <input type="hidden" name="m_email" value="${memberinfo.member.m_email}" id="m_email">
               <input type="hidden" name="m_profile" value="${memberinfo.member.m_profile}" id="m_profile">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 프로필 변경 modal 끝 --%>
		
		<div class="m_name">
		<b>이름</b>
			<input type="text" name="m_name" value="${memberinfo.member.m_name}" readonly>
		</div>
		
		<div class="m_nick">
		<b>닉네임</b>
			<input type="text" id="origin_m_nick" value="${memberinfo.member.m_nick}" readonly>
			<button type="button" data-toggle="modal" data-target="#nickmodal">수정</button>
		</div>
		
	<%-- 닉네임 변경 modal 시작 --%>
    <div class="modal" id="nickmodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_nick">새로운 닉네임</label>
                 <input type="text" class="form-contorl" name="m_nick" id="m_nick">
                 <div id="nick_message"></div>
               </div>
               <input type="hidden" name="m_pwd" value="${memberinfo.member.m_pwd}" id="m_pwd">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_addr2" value="${memberinfo.member.m_addr2}" id="m_addr2">
               <input type="hidden" name="m_phone" value="${memberinfo.member.m_phone}" id="m_phone">
               <input type="hidden" name="m_email" value="${memberinfo.member.m_email}" id="m_email">
               <input type="hidden" name="m_profile" value="${memberinfo.member.m_profile}" id="m_profile">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 닉네임 변경 modal 끝 --%>
		
		<div class="m_gender">
		<b>성별</b>
			<input type="hidden" id="m_gender" value="${memberinfo.member.m_gender}">
			<input type="radio" name="gender" value="남" disabled><span>남</span>
			<input type="radio" name="gender" value="여" disabled><span>여</span>
		</div>
		
		<div class="m_zipcode">
			<b>우편번호</b>
			<input type="text" maxlength="5" name="m_zipcode" value="${memberinfo.member.m_zipcode}" required readonly>
			
			<input type="button" value="우편번호/주소 수정" name="postcode" >
		</div>
		
		<div class="m_addr1">
			<b>주소</b>
			<input type="text" size="50"  name="m_addr1"  value="${memberinfo.member.m_addr1}" required readonly>
		</div>
		
		<div class="m_addr2">
			<b>상세주소</b>
			<input type="text" size="50" name="m_addr2" value="${memberinfo.member.m_addr2}" required readonly>
			<button type="button" data-toggle="modal" data-target="#addrmodal">수정</button>
		</div>
		
	<%-- 상세주소 변경 modal 시작 --%>
    <div class="modal" id="addrmodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_addr2">새로운 상세주소</label>
                 <input type="text" class="form-contorl" name="m_addr2" id="m_addr2">
                 <div id="addr2_message"></div>
               </div>
               <input type="hidden" name="m_pwd" value="${memberinfo.member.m_pwd}" id="m_pwd">
               <input type="hidden" name="m_nick" value="${memberinfo.member.m_nick}" id="m_nick">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_phone" value="${memberinfo.member.m_phone}" id="m_phone">
               <input type="hidden" name="m_email" value="${memberinfo.member.m_email}" id="m_email">
               <input type="hidden" name="m_profile" value="${memberinfo.member.m_profile}" id="m_profile">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 상세주소 변경 modal 끝 --%>
		
		<div class="m_phone">
			<b>핸드폰</b>
			<input type="tel" id="origin_m_phone" maxlength="11" value="${memberinfo.member.m_phone}" readonly>
			<button type="button" data-toggle="modal" data-target="#phonemodal">수정</button>
		</div>
		
	<%-- 핸드폰 변경 modal 시작 --%>
    <div class="modal" id="phonemodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_phone">새로운 전화번호</label>
                 <input type="tel" class="form-contorl" name="m_phone" id="m_phone">
                 <div id="pho_message"></div>
               </div>
               <input type="hidden" name="m_pwd" value="${memberinfo.member.m_pwd}" id="m_pwd">
               <input type="hidden" name="m_nick" value="${memberinfo.member.m_nick}" id="m_nick">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_addr2" value="${memberinfo.member.m_addr2}" id="m_addr2">
               <input type="hidden" name="m_email" value="${memberinfo.member.m_email}" id="m_email">
               <input type="hidden" name="m_profile" value="${memberinfo.member.m_profile}" id="m_profile">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 핸드폰 변경 modal 끝 --%>
		
		<div class="m_email">
			<b>이메일 주소</b>
			<input type="text" id="origin_m_email" value="${memberinfo.member.m_email}">
			<button type="button" data-toggle="modal" data-target="#emailmodal">수정</button>
		</div>
		
	<%-- 핸드폰 변경 modal 시작 --%>
    <div class="modal" id="emailmodal">
      <div class="modal-dialog">
        <div class="modal-content">
          <%-- Modal body --%>
          <div class="modal-body">
            <form name="fileupdateform" action="mypagechange.com" method="post" enctype="multipart/form-data">
              <%-- http://localhost:8088/Board/BoardDetail.bo?num=22
              	   주소를 보면, num을 파라미터로 넘기고 있다.
              	   이 값을 가져와서 ${param.num}를 사용 또는 ${boarddata.board_num}
               --%>
               <div class="form-group">
                 <label for="m_email">새로운 이메일</label>
                 <input type="text" class="form-contorl" name="m_email" id="m_email">
                 <div id="email_message"></div>
               </div>
               <input type="hidden" name="m_pwd" value="${memberinfo.member.m_pwd}" id="m_pwd">
               <input type="hidden" name="m_nick" value="${memberinfo.member.m_nick}" id="m_nick">
               <input type="hidden" name="m_zipcode" value="${memberinfo.member.m_zipcode}" id="m_zipcode">
               <input type="hidden" name="m_addr1" value="${memberinfo.member.m_addr1}" id="m_addr1">
               <input type="hidden" name="m_addr2" value="${memberinfo.member.m_addr2}" id="m_addr2">
               <input type="hidden" name="m_phone" value="${memberinfo.member.m_phone}" id="m_phone">
               <input type="hidden" name="m_profile" value="${memberinfo.member.m_profile}" id="m_profile">
               <button type="submit" class="btn btn-primary">전송</button>
               <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%-- 핸드폰 변경 modal 끝 --%>
		
</div>
</div>
</body>
</html>