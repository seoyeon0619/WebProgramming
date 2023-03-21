package com.kosa.mvc1.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.kosa.mvc1.DBUtil;

@WebServlet("/member.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public MemberController() {
		super();
		
		try {
			Class.forName(DBUtil.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String cmd=request.getParameter("cmd");
		if(cmd==null||cmd.equals(""))
			cmd="member_write";
		if(cmd.equals("idcheck"))
		{
			doIdCheck(request, response);
			
		} else if(cmd.equals("member_write"))
		{
			doWrite(request, response);
			
		} else if(cmd.equals("member_save"))
		{
			doSave(request, response);
		} else if(cmd.equals("member_logon"))
		{
			// jsp로 이동만
			doLogon(request, response);
		} else if(cmd.equals("logon_proc"))
		{
			// 실제 로그온 담담 - 세션에 저장하는 역할
			doLogonProc(request, response);
		} else if(cmd.equals("logout"))
		{
			doLogout(request, response);
		} else if(cmd.equals("findid"))
		{
			doFindid(request, response);
		} else if(cmd.equals("findidproc"))
		{
			doFindidproc(request, response);
		} else if(cmd.equals("findpassword"))
		{
			doFindpassword(request, response);
		} else if(cmd.equals("findpasswordproc"))
		{
			doFindpasswordproc(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	//http://localhost:9000/MVC1/member.do?cmd=idcheck&user_id=test
	protected void doIdCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		MemberDao dao = new MemberDao();
		response.setContentType("application/x-json, charset=utf-8");
		
		if(dao.isDuplicate(user_id)) // id가 이미 존재
			response.getWriter().print( "{\"result\":\"fail\"}");
		else
			response.getWriter().print( "{\"result\":\"success\"}" );
	}
	
	protected void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/member/member_write.jsp");
		rd.forward(request, response);
	}
	
	protected void doSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDao dao = new MemberDao();
		MemberDto dto = new MemberDto();
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String password = request.getParameter("password");
		String email= request.getParameter("email");
		String phone= request.getParameter("phone");
		
		dto.setUSER_ID(user_id);
		dto.setUSER_NAME(user_name);
		dto.setPASSWORD(password);
		dto.setEMAIL(email);
		dto.setPHONE(phone);
		
		response.setContentType("application/x-json, charset=utf-8");
		
		boolean result = dao.insert(dto);
		// DB에 저장, 저장 성공시 true, 실패시 false
		
		if(result) 
			response.getWriter().print( "{\"result\":\"success\"}");
		else
			response.getWriter().print( "{\"result\":\"fail\"}" );
	}
	
	void doLogon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// member/logon.jsp 로 페이지만 이동
		String url="/member/member_logon.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	@SuppressWarnings("unchecked")
	void doLogonProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id=request.getParameter("user_id");
		String password=request.getParameter("password");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.logon(user_id, password);
		
		JSONObject obj = new JSONObject();
		if(dto.getUSER_ID().equals(""))
		{
			// 로그온 실패
			obj.put("result", "fail");
		} else
		{
			// 로그온 성공이므로 세션에 로그온 정보를 저장
			// 서블릿에서 세션객체는 request객체를 통해 얻어야함
			HttpSession session = request.getSession();
			session.setAttribute("user_id", dto.getUSER_ID());
			session.setAttribute("user_name", dto.getUSER_NAME());
			session.setAttribute("email", dto.getEMAIL());
			obj.put("result", "success");
		}
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}
	
	@SuppressWarnings("unchecked")
	void doLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		JSONObject obj = new JSONObject();
		HttpSession session = request.getSession();
		session.invalidate();
		obj.put("result", "success");
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
		}
	
	@SuppressWarnings("unchecked")
	void doFindid(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/findid.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	@SuppressWarnings("unchecked")
	void doFindidproc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_name=request.getParameter("user_name");
		String email=request.getParameter("email");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.findid(user_name, email);
		JSONObject obj = new JSONObject();
		
		if(dto.getUSER_NAME().equals("") & dto.getEMAIL().equals(""))
		{
			obj.put("result", "fail");
		} 
		else
		{
			obj.put("user_id", dto.getUSER_ID());
			obj.put("result", "success");	
		}
		
		response.setContentType("application/x-json, charset=utf-8");
		response.getWriter().print(obj.toJSONString());
	}
	
	@SuppressWarnings("unchecked")
	void doFindpassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/findpassword.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	@SuppressWarnings("unchecked")
	void doFindpasswordproc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id=request.getParameter("user_id");
		String email=request.getParameter("email");
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.findpassword(user_id, email);
		JSONObject obj = new JSONObject();
		
		if(dto.getUSER_ID().equals("") & dto.getEMAIL().equals(""))
		{
			obj.put("result", "fail");
		} 
		else
		{
			obj.put("password", dto.getPASSWORD());
			obj.put("result", "success");	
		}
		
	response.setContentType("application/x-json, charset=utf-8");
	response.getWriter().print(obj.toJSONString());		
	}
	}

