package com.kosa.ajaxtest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/guest.do")
public class GuestbookController extends HttpServlet { 
	private static final long serialVersionUID = 1L;
    public GuestbookController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String result = "{\"username\":\"홍길동\", \"email\":\"ddd@com\"}";
		// 태그 안됨
		response.setContentType("application/x-json, charset=utf-8");
		PrintWriter writer = response.getWriter();
		writer.print(result);*/
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/x-json, charset=utf-8");
		GuestbookDao dao = new GuestbookDao();
		List<GuestbookDto> list = dao.getList();
		JSONArray array = new JSONArray();
		
		for(GuestbookDto dto: list)
		{
			JSONObject object=new JSONObject();
			
			object.put("seq", dto.getSeq());
			object.put("title", dto.getTitle());
			object.put("contents", dto.getContents());
			object.put("writer", dto.getWriter());
			object.put("wdate", dto.getWdate());
			object.put("hit", dto.getHit());
			
			array.add(object);
		}
		PrintWriter writer = response.getWriter();
		writer.print(array.toJSONString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
