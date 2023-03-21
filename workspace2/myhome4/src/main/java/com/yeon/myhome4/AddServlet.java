package com.yeon.myhome4;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddServlet
 */
@WebServlet("/cal")
public class AddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sX = request.getParameter("x");
		String sY = request.getParameter("y");
		String operator = CommonUtil.nullToVal(request.getParameter("operator"), "1");
		System.out.println(operator);
		
		int nX = Integer.parseInt(sX);
		int nY = Integer.parseInt(sY);
		int nZ = nX + nY;
		
		if(operator.equals("1"))
		{
			nZ = nX + nY;
			operator="+";
		}
		else if(operator.equals("2"))
		{
			nZ = nX - nY;
			operator="-";
		}
		else if(operator.equals("3")) 
		{
			nZ = nX * nY;
			operator="*";
		}
		else 
		{
			nZ = nX / nY;
			operator="/";
		}
			
		PrintWriter out = response.getWriter();
		
		out.println("<h1>" + String.format("%d %s %d = %d", nX, operator, nY, nZ) + "</h1>");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
