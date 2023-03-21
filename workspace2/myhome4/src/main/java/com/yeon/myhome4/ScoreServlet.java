package com.yeon.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/scoreResult")
public class ScoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sName = request.getParameter("name");
		String sKor = request.getParameter("kor");
		String sEng = request.getParameter("eng");
		String sMath = request.getParameter("math");
		
		int nKor = Integer.parseInt(CommonUtil.nullToVal(sKor, "0"));
		int nEng = Integer.parseInt(CommonUtil.nullToVal(sEng, "0"));
		int nMath = Integer.parseInt(CommonUtil.nullToVal(sMath, "0"));
		int total = nKor + nEng + nMath ;
		float avg = total/3 ;
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<meta charset='utf-8'>");
		out.println("<h1>" + String.format("%s님의 총점은 %d점이고 평균은 %.1f입니다", sName, total, avg) + "</h1>");
		out.println("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
