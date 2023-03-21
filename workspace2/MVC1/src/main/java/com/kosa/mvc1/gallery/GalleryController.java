package com.kosa.mvc1.gallery;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/gallery.do")
public class GalleryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MultipartRequest multi = null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글처리
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		ServletContext ctx = request.getServletContext();
		
		//상대적경로를 적으면 실제경로를 알려줌
		String savePath = ctx.getRealPath("/upload/gallery");
		int sizeLimit = 1024*1024*20; // 파일크기 최대 20MB
		
		System.out.println(request.getMethod());
		System.out.println(request.getContentType());
		
		String method = request.getMethod();
		String contentType = request.getContentType();
		String cmd = "";
		if(contentType == null ||! contentType.startsWith("multipart"))
		{
			cmd = request.getParameter("cmd");
			if(cmd==null || cmd.equals(""))
				cmd="list";
		}
		else
		{
			// DefaultFileRenamePolicy() : 파일명 중복시 어떻게 처리할 것인가
			// 파일명 마음대로 바꿈
			multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
			cmd = multi.getParameter("cmd");
		}
		System.out.println("*****"+ cmd);
		//System.out.println("@@@@@"+multi.getParameter("cmd"));
		
		if(cmd.equals("list"))
		{
			doList(request, response);
		}
		else if(cmd.equals("write"))
		{
			doWrite(request, response);
		}
		else if(cmd.equals("save"))
		{
			doSave(request, response);
		}
		else if(cmd.equals("save2"))
		{
			doSave2(request, response);
		}
		
		else if(cmd.equals("view"))
		{
			doView(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GalleryDto dto = new GalleryDto();
		GalleryDao dao = new GalleryDao();
		
		String pg = request.getParameter("pg");
		// 파라미터값 읽어와서
		if(pg==null || pg.equals(""))
			pg="0"; // 기본값 0으로 채움, request.getParameter는 반환값이 String
		// 정수로 변환하여 dto 객체에 전달
		
		dto.setPg(Integer.parseInt(pg));
		request.setAttribute("totalCnt", dao.getTotalCnt(dto));
		request.setAttribute("list", dao.getList(dto));
		
		RequestDispatcher rd = request.getRequestDispatcher("/gallery/gallery_list.jsp");
		rd.forward(request, response);
	}
	void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/gallery/gallery_write.jsp");
		rd.forward(request, response);
	}
	void doSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파일 업로드 처리
		String title = multi.getParameter("title");
		String writer = multi.getParameter("writer");
		String contents = multi.getParameter("contents");
		
		// tag의 name속성
		String filename = multi.getFilesystemName("image");
		String originalFilename = multi.getOriginalFileName("image");
		System.out.println(filename);
		System.out.println(originalFilename);
		
		GalleryDto dto = new GalleryDto();
		dto.setTitle(title);
		dto.setContents(contents);
		dto.setWriter(writer);
		dto.setImage(filename);
		
		GalleryDao dao = new GalleryDao();
		dao.insert(dto);
		
		String url = request.getContextPath() + "/gallery.do?cmd=list";
		response.sendRedirect(url);
	}
	
	void doSave2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("title"));
		System.out.println(request.getParameter("writer"));
		System.out.println(request.getParameter("contents"));
		
		//파일 업로드해야 한다 
		String title = multi.getParameter("title");
		String writer = multi.getParameter("writer");
		String contents = multi.getParameter("contents");
		
		//tag의 name 속성
		String filename = multi.getFilesystemName("image");
		String originalFilename = multi.getOriginalFileName("image");
		
		System.out.println(filename);
		System.out.println(originalFilename);
		
		GalleryDto dto = new GalleryDto();
		dto.setTitle(title);
		dto.setContents(contents);
		dto.setWriter(writer);
		dto.setImage(filename);
		
		GalleryDao dao =new GalleryDao();
		dao.insert(dto);
			
		JSONObject obj = new JSONObject();//JSON으로 전송하기 위한 
		//전용 객체를 생성한다 
		
		obj.put("result", "success");//키와 값 쌍의 형태로 저장한다 
		//서버에서 클라이언트로 응답을 보낼때  html, text, json 등으로 보낼 수 있다
		//보통 아무말 없으면 text 로 받고, <html>태그가 있으면 
		//html로 받고 json이나 이미지, 동영상등 지정할 수 있는 타입이 
		//아주 많다. 
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}
	

	void doView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GalleryDao dao = new GalleryDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		
		String url = "/gallery/gallery_view.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
				
	}
	
	

}
