<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="net.trade.db.*,java.io.File"%>
<script>
<%
	request.setCharacterEncoding("utf-8");

	int id = Integer.parseInt(request.getParameter("id"));
	String password = request.getParameter("password");
	TradeDAO dao = new TradeDAO();
	
	if(dao.passwordCheck(id, password)){	// 비밀번호 체크
		Video video = repo.selectOneVideoById(id);
		ServletContext context = getServletContext();
		String realFolder = context.getRealPath("upload");
		
		// 기존 비디오, 썸네일 경로
		File videoFile = new File(realFolder+"/"+video.getVideo());
		File thumbnailFile = new File(realFolder+"/"+video.getThumbnail());
		
		// 기존 비디오 썸네일 삭제
		videoFile.delete();
		thumbnailFile.delete();
		
		// DB에서 삭제
		dao.deleteVideo(id);
		%> 
			alert('삭제가 완료되었습니다');
			location.href="index.jsp";
		<%
	} else {
		%>	
			alert('비밀번호가 다르거나 존재하지 않는 비디오입니다.');
			history.back();
		<%
	}
		
	dao.close();
%>
</script>
