package com.yeon.shop.index;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.yeon.shop.index.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/shop.do")
public class ShopController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MultipartRequest multi = null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		ServletContext ctx = request.getServletContext();
		
		String savePath = ctx.getRealPath("/upload/shop");
		int sizeLimit = 1024*1024*20;
		
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

	void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ShopDto dto = new ShopDto();
		ShopDao dao = new ShopDao();
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/shop/shop_list.jsp");
		rd.forward(request, response);
	}
	
	void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/shop/shop_write.jsp");
		rd.forward(request, response);
	}

	void doSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파일 업로드 처리
		String name = multi.getParameter("name");
		String price = multi.getParameter("price");
		String size = multi.getParameter("size");
		
		// tag의 name속성
		String filename = multi.getFilesystemName("image");
		String originalFilename = multi.getOriginalFileName("image");
		System.out.println(filename);
		System.out.println(originalFilename);
		
		ShopDto dto = new ShopDto();
		dto.setPro_name(name);
		dto.setPro_price(price);
		dto.setPro_size(size);
		dto.setPro_image(filename);
		
		ShopDao dao = new ShopDao();
		dao.insert(dto);
		
		String url = request.getContextPath() + "/shop.do?cmd=list";
		response.sendRedirect(url);
	}
	
	void doSave2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("name"));
		System.out.println(request.getParameter("price"));
		System.out.println(request.getParameter("size"));
		
		//파일 업로드해야 한다 
		String name = multi.getParameter("name");
		String price = multi.getParameter("price");
		String size = multi.getParameter("size");
		
		//tag의 name 속성
		String filename = multi.getFilesystemName("image");
		String originalFilename = multi.getOriginalFileName("image");
		
		System.out.println(filename);
		System.out.println(originalFilename);
		
		ShopDto dto = new ShopDto();
		dto.setPro_name(name);
		dto.setPro_price(price);
		dto.setPro_size(size);
		dto.setPro_image(filename);
		
		ShopDao dao =new ShopDao();
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
		ShopDao dao = new ShopDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		
		String url = "/shop/shop_view.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
				
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	

}
