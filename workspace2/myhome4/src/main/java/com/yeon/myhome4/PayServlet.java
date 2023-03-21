package com.yeon.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/pay")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sName = request.getParameter("name");
		String sWeekTime = request.getParameter("weektime");
		String sTimePay = request.getParameter("timepay");
		
		int nWeekTime = Integer.parseInt(CommonUtil.nullToVal(sWeekTime, "0"));
		int nTimePay = Integer.parseInt(CommonUtil.nullToVal(sTimePay, "0"));
		int nPay = nWeekTime * nTimePay ;
		float nPlus = 0;
		if(nWeekTime >= 20) {
			nPlus = (float) (nTimePay * 0.5 * (nWeekTime-20)) ;
		} 
		float nTotal = nPay + nPlus;
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<meta charset='utf-8'>");
		out.println("<h1>" + String.format("%s님의 근무시간은 %d시간이고 기본급은 %d원, 수당은 %.0f원입니다<br/> 합산 %.0f원입니다", 
											sName, nWeekTime, nPay, nPlus, nTotal) + "</h1>");
		out.println("</html>");
	}

	
}
