<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chat</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
          integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chat.css">
    <script src="${pageContext.request.contextPath}/js/chat/chat.js"></script>
    <script src="${pageContext.request.contextPath}/js/chat/message.js"></script>
    <title>채팅 : 번지</title>
</head>
<body>
<jsp:include page="${pageContext.request.contextPath}/layout/header.jsp"/>

<input type="hidden" id="loginId" value="${m_id}">
<input type="hidden" id="sessionChatId" value="${chatId}">
<div class="container-fluid h-100">
    <div class="row justify-content-center h-100">
        <div class="col-md-4 col-xl-3 chat">
            <div class="card mb-sm-3 mb-md-0 contacts_card">
                <div class="card-header">
                    <div class="input-group">
                        <input type="text" placeholder="Search..." name="" class="form-control search">
                        <div class="input-group-prepend">
                            <span class="input-group-text search_btn"><i class="fas fa-search"></i></span>
                        </div>
                    </div>
                </div>
                <div class="card-body contacts_body">
                    <ui class="contacts">
                        <%-- 채팅 리스트 --%>
                    </ui>
                </div>
                <div class="card-footer"></div>
            </div>
        </div>
        <div class="col-md-8 col-xl-6 chat">
            <div class="card">
                <div class="card-header msg_head">
                    <div class="d-flex bd-highlight">
                        <div class="img_cont">
                            <img src="image/profile.png"
                                 class="rounded-circle user_img">
                            <span class="online_icon"></span>
                        </div>
                        <div class="user_info chat_top">
                            <%--                            <span>Chat with Khalid</span>--%>
                            <%--                            <p>1767 Messages</p>--%>
                        </div>
                    </div>
                    <span id="action_menu_btn"><i class="fas fa-ellipsis-v"></i></span>
                    <div class="action_menu">
                        <ul>
                            <li class="profile"><i class="fas fa-user-circle"></i> 프로필 보기</li>
                            <%--                            <li><i class="fas fa-users"></i> Add to close friends</li>--%>
                            <%--                            <li><i class="fas fa-plus"></i> Add to group</li>--%>
                            <li class="delete-chat-btn"><i class="fas fa-ban"></i> 채팅방 삭제</li>
                        </ul>
                    </div>
                </div>
                <div class="card-body msg_card_body">
                    <%-- 메세지 부분 --%>
                </div>
                <div class="card-footer">
                    <div class="input-group">
                        <div class="input-group-append">
                            <span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
                        </div>
                        <textarea name="" class="form-control type_msg" placeholder="Type your message..."
                                  maxlength="200"></textarea>
                        <div class="input-group-append">
                            <span class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
