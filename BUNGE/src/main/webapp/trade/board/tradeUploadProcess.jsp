<%@ page contentType="text/html;charset=utf-8" import="java.io.*, net.trade.db.TradeDAO, net.trade.db.Trade, com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");

    String realFolder = getServletContext().getRealPath("upload");
    int maxsize = 1024 * 1024 * 1024; // 1GB

    File folder = new File(realFolder);
    if (!folder.exists()) {
        folder.mkdir();
    }

    int redirectId = 0;

    try {
        MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, "UTF-8", new DefaultFileRenamePolicy());

        Trade trade = new Trade();
        trade.setTitle(multi.getParameter("title"));
        trade.setSellerID(multi.getParameter("sellerID"));
        trade.setDescription(multi.getParameter("desc"));
        trade.setImageID(multi.getFilesystemName("file")); // Get uploaded file name

        TradeDAO dao = new TradeDAO();
        redirectId = dao.insertTrade(trade);
        dao.close();
    } catch (IOException e) {
        System.out.println("파일 전송 오류: " + e);
    }

    response.sendRedirect("view.jsp?id=" + redirectId);
%>
