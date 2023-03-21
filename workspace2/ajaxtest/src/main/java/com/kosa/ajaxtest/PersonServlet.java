package com.kosa.ajaxtest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/person.do")
public class PersonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PersonServlet() {
        super();
    }
    
	@SuppressWarnings("unchecked") 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			JSONArray array = new JSONArray();
		
			JSONObject obj = new JSONObject();
			obj.put("username", "홍길동");
			obj.put("email", "hong@ddd.com");
			obj.put("phone", "010-0000-0000");
			array.add(obj);
			
			obj = new JSONObject();
			obj.put("username", "김길동");
			obj.put("email", "kim@ddd.com");
			obj.put("phone", "010-0000-1111");
			array.add(obj);
			
			obj = new JSONObject();
			obj.put("username", "이길동");
			obj.put("email", "lee@ddd.com");
			obj.put("phone", "010-0000-2222");
			array.add(obj);
			
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/x-json, charset=utf-8");
			response.getWriter().print(array.toJSONString());
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
