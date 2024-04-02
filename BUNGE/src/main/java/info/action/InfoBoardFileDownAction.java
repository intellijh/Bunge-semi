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
			
			ServletContext context = request.getServletContext();
			String downloadpath = context.getRealPath(savepath);
			
			String filepath = downloadpath + File.separator + filename;
			System.out.println("filepath : " + filepath);
			
			byte[] b = new byte[4096];
			
			String mimetype = context.getMimeType(filepath);
			System.out.println("mimetype" + mimetype);
			
			if (mimetype == null)
				mimetype = "application/octet-stream";
				
			response.setContentType(mimetype);
			
			String encoding = new String(filename.getBytes("utf-8"), "ISO-8859-1");
			System.out.println("encoding : " + encoding);
			
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