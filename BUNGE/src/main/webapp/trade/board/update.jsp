<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="UTF-8" import="net.trade.db.*"%>
<%
    request.setCharacterEncoding("utf-8");

    Video video = new Video();
    // POST 요청만 받음
    if (request.getMethod().equals("POST")){
        VideoRepo videoRepo = new VideoRepo();
        // 글 정보 로드
        video = videoRepo.selectOneVideoById(Integer.parseInt(request.getParameter("id")));

        videoRepo.close();
    } else {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비디오 수정</title>
    <link rel="stylesheet" href="../../static/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/style.css">
</head>
<body>
<div id="upper-bar">
    <a href="trade.net" id="title">거래 게시판</a>
</div>
<div id="content-view">
    <div id="content-view-inner">
        <div id="write-view-title">글 수정</div>
        <form id="write-form" action="submit_do.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%=trade.getId()%>">
            <input type="text" id="write-title" name="title" placeholder="비디오 제목" maxlength="30" value="<%=trade.getTitle()%>"><hr><br>
            <input type="file" id="write-video" name="video" accept=".mp4,.mkv,.avi" required><br><br>
            썸네일 선택 (jpg, jpeg, png 파일만 업로드할 수 있습니다.)<br>
            <input type="file" id="write-thumbnail" name="thumbnail" accept=".jpeg,.jpg,.png" required><br>
            <img style="width: 360px; height: 202px; margin-top:30px;" id="preview-image" src="<%="./upload/" + video.getThumbnail()%>"><br>
            (실제 보여질 썸네일 크기입니다)<br><br>
            <hr><br><br>
            <div id="write-controller">
                <input type="text" id="write-author" value="<%=video.getAuthor()%>" disabled>
                <input type="password" id="write-password" value="PASSWORD" disabled>
                <input type="button" class="btn btn-danger" id="write-cancel" value="취소" onclick="cancel()">
                <input type="button" class="btn btn-info" id="write-submit" value="수정완료" onclick="checkSubmit()">
            </div>
        </form>
    </div>
</div>
<div id="under-bar">인터넷 프로그래밍 동영상 관리 게시판</div>
</body>
<script type="text/javascript" src="./static/thumbnailPreview.js"></script>
<script type="text/javascript" src="./static/jquery.js"></script>
<script type="text/javascript" src="./static/bootstrap.min.js"></script>
<script type="text/javascript" src="./static/submit.js" charset='utf-8'></script>
</html>