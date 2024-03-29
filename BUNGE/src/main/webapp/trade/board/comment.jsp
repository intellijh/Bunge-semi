<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" import="net.trade.db.CommentRepo,net.trade.db.Comment,com.google.gson.Gson,com.google.gson.JsonObject,java.util.ArrayList"%>
<%
    request.setCharacterEncoding("utf-8");
    response.setContentType("application/json");
    response.setCharacterEncoding("utf-8");

    String query = request.getParameter("query");

    CommentRepo repo = new CommentRepo();

    if (query.equals("insert")){	// 댓글 작성
        Comment comment = new Comment();
        comment.setAuthor(request.getParameter("author"));
        comment.setDesc(request.getParameter("desc"));
        comment.setPassword(request.getParameter("password"));
        comment.setVideoId(Integer.parseInt(request.getParameter("videoId")));

        repo.insertComment(comment);


        JsonObject json = new JsonObject();
        json.addProperty("success",true);

        out.print(json);
    } else if (query.equals("getList")){	// 댓글 리스트 가져오기
        ArrayList<Comment> list = repo.getCommentListByVideoId(Integer.parseInt(request.getParameter("videoId")));
        String json = new Gson().toJson(list);

        response.getWriter().write(json);
    } else if (query.equals("delete")){		// 댓글 삭제
        int id = Integer.parseInt(request.getParameter("id"));
        String password = request.getParameter("password");

        boolean success = repo.deleteComment(id, password);

        JsonObject json = new JsonObject();
        json.addProperty("success",success);

        out.print(json);
    }

    repo.close();
%>