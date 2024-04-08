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
.tab_container{
    position: relative;
    display: flex;
    margin: 0 auto;
    flex-direction: row;
    justify-content: space-evenly;
    padding-top: 60px;
}
.left_bar {
	width: 180px;
    height: 600px;
} 
.tab-slider--tabs{
    position: relative;
    left: 50px;
    padding-bottom: 20px;
}
.tab-slider--tabs li {
    text-align: center;
    width: 140px;
    margin: 5px;
    padding-top: 5px;

}
.membertitle {
   border-bottom: 1px solid rgba(212, 216, 229, .5);
    width: 1140px;
    position: relative;
    top : 20px;
    padding-bottom: 30px;
}
.membertitle h3 {
    position: relative;
    width: 1040px;
    left: 182px;
}
.m_profile {
    position: relative;
    left: 60px;
}
label{
	margin: 0;
	padding-bottom: 20px;
	
}
.chanagech {
    border: none;
}
.chanagech img {
    width: 20px;
    position: absolute;
    top: 110px;
    left: 100px;
    display: block;
    background-color: transparent;
}
.profilech {
    width: 140px;
    height: 140px;
}
.profilech img {
    width: 130px;
    height: 130px;
    border-radius: 50%;
}
.my {
    position: relative;
    left: 90px;
    width: 400px;
    height: 60px;
}
.my input {
    width: 250px;
}

.m_id b {
    padding-right: 16px;
}

.m_pwd_btn {
    position: absolute;
    top: 0px;
    width: 80px;
    height: 40px;
}
.m_pwd_btn button {
    width: 100px;
    height: 40px;
    position: absolute;
    left: 355px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}

.m_name b {
    padding-right: 30px;
}

.m_nick b {
    padding-right: 16px;
}
.m_nick_btn {
    position: absolute;
    top: 0px;
    width: 80px;
    height: 40px;
}
.m_nick_btn button {
    width: 100px;
    height: 40px;
    position: absolute;
    left: 355px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}
.m_gender {
    height: 40px;
}
.m_gender input{
  width: 15px;
}
.m_gender span {
    padding: 5px;
}
.m_gender b {
    padding-right: 30px;
}

.m_zipcode input {
    width: 60px;
}
.m_zipcode_btn {
    position: absolute;
    left: 160px;
    top: 0;
}
.m_zipcode_btn input {
    width: 160px;
    height: 40px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}
.m_addr1 {
    width: 500px;
}
.m_addr1 input {
    width: 380px;
}
.m_addr1 b {
    padding-right: 30px;
}
.m_addr2 input{
    width: 250px;
}
.m_addr2_btn {
    position: absolute;
    top: 0px;
    width: 80px;
    height: 40px;
}
.m_addr2_btn button {
    width: 100px;
    height: 40px;
    position: absolute;
    left: 355px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}
.m_phone b{
    padding-right: 16px;
}
.m_phone_btn {
    position: absolute;
    top: 0px;
    width: 80px;
    height: 40px;
}
.m_phone_btn button {
    width: 100px;
    height: 40px;
    position: absolute;
    left: 355px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}

.m_email input {
    width: 228px;
}
.m_email_btn {
    position: absolute;
    top: 0px;
    width: 80px;
    height: 40px;
}
.m_email_btn button {
    width: 100px;
    height: 40px;
    position: absolute;
    left: 355px;
    background-color: rgba(212,216,229,.25);
    border: solid 1px rgba(212,216,229,.5);
    border-radius: 4px;
    color: #7b8994;
}
.modal-content{
	top:300px;
	width: 300px;
    height: 200px;
    margin: 0 auto;
}
.modal-content form {
	text-align:  center;
}
.form-group {
	padding: 12px;
}
.form-contorl {
width: 250px;

}
</style>
</head>
<body>
<div id="warp">
<div class="mypage">
<div class="membertitle">
      <h3>회원 정보 수정</h3>
    </div>	
<div class="tab_container">
<div class="left_bar">
<div class="m_profile">
		<label>
			<span id="showImage">
					<c:set var="src" value='${"memberupload/"}${memberinfo.member.m_profile}'/>
					<div class="profilech">
						<input id="m_profile"  type="hidden" name="m_profile"  value="${memeberinfo.member.m_profile }">
						<img alt="profile" src="${src}" >
					</div>
			</span>
		 	<button type="button" class="chanagech" data-toggle="modal" data-target="#filemodal"><img src="${pageContext.request.contextPath}/image/cogwheel_icon.png"></button> 
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
		<div class="tab-slider--nav">
		  <ul class="tab-slider--tabs">
		   <a href="mypage.com"><li class="tab-slider--trigger"  rel="tab1"><span>마이페이지</span></li></a>
			<a href="reviewlist.com"><li class="tab-slider--trigger active" rel="tab2"><span>작성글</span></li></a>
			<a href="mycommlist.com"><li class="tab-slider--trigger"  rel="tab3"><span>작성댓글</span></li></a>
			<a href="mylikelist.com"><li class="tab-slider--trigger"  rel="tab4"><span>좋아요한 리뷰</span></li></a>
			<a href="mytradelist.com"><li class="tab-slider--trigger"  rel="tab5"><span>좋아요한 거래상품</span></li></a>
		  </ul>
		</div>
</div>
<div class="member">
		<div class="my m_id">
			<b>아이디</b>
			<input type="text" name="m_id" value="${memberinfo.member.m_id}" readonly>
		</div>
		
		<div class="my m_pwd">
		<b>비밀번호</b>
			<input type="text" id="origin_m_pwd" maxlength="15"  value="${memberinfo.member.m_pwd}" readonly>
			<div class="m_pwd_btn">
			<button type="button" data-toggle="modal" data-target="#pwdmodal">수정</button>
		</div>
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
		
		<div class="my m_name">
		<b>이름</b>
			<input type="text" name="m_name" value="${memberinfo.member.m_name}" readonly>
		</div>
		
		<div class="my m_nick">
		<b>닉네임</b>
			<input type="text" id="origin_m_nick" value="${memberinfo.member.m_nick}" readonly>
			<div class="m_nick_btn">
			<button type="button" data-toggle="modal" data-target="#nickmodal">수정</button>
			</div>
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
		
		<div class="my m_gender">
		<b>성별</b>
			<input type="hidden" id="m_gender" value="${memberinfo.member.m_gender}">
			<input type="radio" name="gender" value="남" disabled><span>남</span>
			<input type="radio" name="gender" value="여" disabled><span>여</span>
		</div>
		
		<div class="my m_zipcode">
			<b>우편번호</b>
			<input type="text" maxlength="5" name="m_zipcode" value="${memberinfo.member.m_zipcode}" required readonly>
			<div class="m_zipcode_btn">
			<input type="button" value="우편번호/주소 수정" name="postcode" >
			</div>
		</div>
		
		<div class="my m_addr1">
			<b>주소</b>
			<input type="text" size="50"  name="m_addr1"  value="${memberinfo.member.m_addr1}" required readonly>
		</div>
		
		<div class="my m_addr2">
			<b>상세주소</b>
			<input type="text" size="50" name="m_addr2" value="${memberinfo.member.m_addr2}" required readonly>
			<div class="m_addr2_btn">
			<button type="button" data-toggle="modal" data-target="#addrmodal">수정</button>
		</div>
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
		
		<div class="my m_phone">
			<b>핸드폰</b>
			<input type="tel" id="origin_m_phone" maxlength="11" value="${memberinfo.member.m_phone}" readonly>
			<div class="m_phone_btn">
			<button type="button" data-toggle="modal" data-target="#phonemodal">수정</button>
		</div>
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
		
		<div class="my m_email">
			<b>이메일 주소</b>
			<input type="text" id="origin_m_email" value="${memberinfo.member.m_email}">
			<div class="m_email_btn">
			<button type="button" data-toggle="modal" data-target="#emailmodal">수정</button>
		</div>
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
</div>
</div>
</body>
</html>