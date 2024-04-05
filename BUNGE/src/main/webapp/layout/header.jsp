<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Common.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<html>
<head>
    <style>
        body {
            width: 1200px;
            margin: 0 auto;
            line-height: 28px;
        }

        .inner {
            margin: 0 auto;
            display: flex; /* Changed to flex to align items horizontally */
            justify-content: space-between; /* Added to evenly distribute items horizontally */
            align-items: center; /* Added to vertically center items */
        }

        .nav-item {
            /* Removed padding for nav items to prevent spacing between items */
            padding: 0;
            margin: 0;
        }

        .nav-link {
            /* Added padding to nav links to create space between them */
            padding: 10px 15px;
        }

        .bg-light {
            background-color: #ffffff !important;
        }

        .navbar-light .navbar-nav .nav-link {
            color: rgba(0, 0, 0, 1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="inner">
        <!-- Brand -->
        <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/image/logo.png"
                                                       alt="logo"
                                                       width="140" height="30" class="d-inline-block align-text-top"></a>

        <!-- Links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="InfoList.com">정보공유게시판</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="trade.net">거래게시판</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="chat.com">
                    <img src="${pageContext.request.contextPath}/image/chat.png" alt="chat" width="22" height="22">
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <img src="${pageContext.request.contextPath}/image/bell.png" alt="bell" width="22" height="22">
                </a>
            </li>


            <c:choose>
                <c:when test="${m_id ==null }">
                    <li class="nav-item">
                        <a class="nav-link" href="mypage.com">
                            <img src="${pageContext.request.contextPath}/image/profile.png" alt="profile" width="25"
                                 height="25">
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.com">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="join.com">회원가입</a>
                    </li>
                </c:when>
                <c:when test="${m_id != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="mypage.com" id="navbardrop" data-toggle="dropdown">
                            <img src="${pageContext.request.contextPath}/image/profile.png" alt="profile" width="25"
                                 height="25">
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="mypage.com">마이페이지</a>
                            <a class="dropdown-item" href="mytradelist">중고거래</a>
                            <a class="dropdown-item" href="reviewlist">활동</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.com">${m_id}님 (로그아웃)</a>
                    </li>
                </c:when>
            </c:choose>
            <c:if test="${m_id == 'admin'}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 관리자 </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">회원정보</a>
                        <a class="dropdown-item" href="#">게시판</a>
                    </div>
                </li>
            </c:if>
        </ul>
    </div>
</nav>
</body>
</html>