package info.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import common.action.Action;
import common.action.ActionForward;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InfoBoardFileDownAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			String filename = request.getParameter("filename");
			
			String savepath = "boardupload";
			
			//boardupload의 실제 경료. 오라클에서 파일을 관리하는 실제 경로
			ServletContext context = request.getServletContext();
			String downloadpath = context.getRealPath(savepath);
			
			//운영체제마다 파일 경로 구분자가 다른데,
			//OS 따른 경로 차이를 신경쓰지 않고, 파일 경로를 설정한다.
			String filepath = downloadpath + File.separator + filename;
			System.out.println("filepath : " + filepath);
//filepath : C:\semi\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\BUNGE\boardupload\긍정 해동의 힘.jpg

			
			byte[] b = new byte[4096];
			
			//바이너리 파일 <-> 텍스트 파일
			String mimetype = context.getMimeType(filepath);
			System.out.println("mimetype" + mimetype); //mimetypeimage/jpeg

			
			if (mimetype == null)
				mimetype = "application/octet-stream";
				
			response.setContentType(mimetype);
			
			String encoding = new String(filename.getBytes("utf-8"), "ISO-8859-1");
			System.out.println("encoding : " + encoding);
//encoding : ê¸ì  í´ëì í.jpg
//encoding : sample4.jpg
			
			response.setHeader("Content-Disposition", "attachment; filename=" + encoding);
			
			try (
				 BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
				 BufferedInputStream in = new BufferedInputStream(new FileInputStream(filepath));
				) {
				
				int numRead;
				while ((numRead = in.read(b, 0, b.length)) != -1) {
					out.write(b, 0, numRead);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return null;
	} //execute end
} //class end