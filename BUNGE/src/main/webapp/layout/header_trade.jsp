<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/header.js"></script>
<html>
<head>
<style>
	header {
		height : 65px;
    	position: sticky;
    	top: 0;
    	width: 100%; /* 헤더의 전체 너비를 채우도록 설정 */
    	z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
		}
	
	.inner {
		line-height: 28px;
        margin : 0 auto ;
        width: 1140px;
        display: flex; /* Changed to flex to align items horizontally */
        justify-content: space-between; /* Added to evenly distribute items horizontally */
        align-items: center; /* Added to vertically center items */
        height : 65px;
        vertical-align: middle;    
        }

	.navbar {
		background: white;
	}

	.navbar-nav>li>a {
		padding : 0
	}
	
	.navbar-brand {
		padding : 0;
		float: left;
    	height: 50px;
    	padding: 15px 15px; 
    	font-size: 18px; 
    	line-height: 20px; 
	} 
	
	
	
	
	#headerprofile {
		padding-right : 2px; 
	}
	
	body > header > nav > div > ul.navbar-nav.ml-auto > li.nav-item.navimg > a > img {
		padding-right : 7px; 
	}
      
    
</style>
</head>
<body>
<input type="hidden" id="loginid" value="${m_id}" name="loginid">
<header>
<nav class="navbar">
  <div class="inner">
      <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/image/logo.png"
                                                       alt="logo"
                                                       width="140" height="30" class="d-inline-block align-text-top"></a>
    <ul class="nav navbar-nav">
      <li class="active"><a href="index.jsp">Home</a></li>
      <li class="active"><a class="nav-link" href="InfoList.com">정보공유게시판</a></li>
      <li class="active"><a class="nav-link" href="trade.net">거래게시판</a></li>
    </ul>  
    
      <ul class="navbar-nav ml-auto">
            <c:choose>
                <c:when test="${m_id ==null }">
					<li class="active">
              		  <a href="login.com">
                  		  <img src="${pageContext.request.contextPath}/image/chat.png" alt="chat" width="22" height="22">
               		 </a>
           			 </li>                
                    <li class="active">
                        <a href="login.com">
                            <img src="${pageContext.request.contextPath}/image/profile.png" class="headerpf" alt="profile" width="22"
                                 height="22">
                        </a>
                    </li>
                    <li class="nav-item navimg">
                        <a class="nav-link" href="login.com">로그인</a>
                    </li>
                    <li class="nav-item navimg">
                        <a class="nav-link" href="join.com">회원가입</a>
                    </li>
                </c:when>
      			<c:when test="${m_id != null}">
                <li class="nav-item navimg">
              		  <a href="chat.com">
                  		  <img src="${pageContext.request.contextPath}/image/chat.png" alt="chat" width="22" height="22">
               		 </a>
           			 </li> 
      			<li class="dropdown">
        			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
        				<img id="headerprofile" class="headerpf" src="${pageContext.request.contextPath}/image/profile.png" 
        				alt="profile" width="25" height="25">
        			</a>
        				<ul class="dropdown-menu">
          					<li><a class="dropdown-item" href="mypage.com">마이페이지</a></li>
          					<li><a class="dropdown-item" href="mytradelist.com">중고거래</a></li>
          					<li><a class="dropdown-item" href="reviewlist.com">활동</a></li>
        				</ul>
      			</li>
      			<li><a class="nav-link" href="logout.com">${m_id}님 (로그아웃)</a></li>
      			</c:when>
           		 </c:choose>
           		 <c:if test="${m_id == 'admin'}">
                   <li class="dropdown">
        			<a class="dropdown-toggle" data-toggle="dropdown" href="#">관리자</a>
        				<ul class="dropdown-menu">
          					<li><a class="dropdown-item" href="mypage.com">마이페이지</a></li>
          					<li><a class="dropdown-item" href="mytradelist.com">중고거래</a></li>
          					<li><a class="dropdown-item" href="reviewlist.com">활동</a></li>
        				</ul>
      			</li>
               </c:if>
    </ul>
  </div>
</nav>
</header>
</body>