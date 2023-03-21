package com.kosa.mvc1.guestbook;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kosa.mvc1.common.BaseDto;

@WebServlet("/guestbook.do")
public class GuestbookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GuestbookController() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("cmd");
		GuestbookDao dao = new GuestbookDao(); // 모델단
		// Servlet이 Controller 역할
		
		if(cmd==null || cmd.equals(""))
			cmd="list"; // 아무것도 없을 때 기본 값 부여
		if(cmd.equals("list"))
		{	
			doList(request, response);
		}
		else if(cmd.equals("view"))
		{
			doView(request, response);
		}
		else if(cmd.equals("write")) // 페이지이동
		{
			doWrite(request, response);
		}
		else if(cmd.equals("save")) // 디비 저장
		{
			doSave(request, response);
		}
		else if(cmd.equals("modify")) // 수정
		{
			doModify(request, response);
		}
		else if(cmd.equals("update"))
		{
			doUpdate(request, response);
		}
		else if(cmd.equals("delete"))
		{
			doDelete(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestbookDao dao = new GuestbookDao();
		// request객체에 데이터를 저장해서 보냄
		// setAttribute("객체참조명", 객체정보);
		// jsp에서는 getAttribute("객체참조명"); 형태로 값을 읽음
		// getAttribute는 Object 타입으로 다운캐스팅해서 전달
		// 사용전에 upcasting으로 받아야 함
		// setParameter 라는 함수는 없음
		// 값 넣으려면 setAttribute 만 가능
			// 사용법 - Hashmap처럼 키와 값 쌍의 형태로 저장
		
		
		
		// jsp - 강제 다운캐스팅 상황 Object -> List<GuestbookDto>
		// List<GuestbookDto> list = (List<GuestbookDto>)request.getAttribute("list");
		
		//jsp 
		GuestbookDto dto = new GuestbookDto();
		String pg = request.getParameter("pg");
		String searchOpt = request.getParameter("searchOpt");
		String searchKey = request.getParameter("searchKey");
		
		// pg값을 전달받지 못한 경우 0으로 
		if(pg==null || pg.equals(""))
			pg="0";
		
		// null값 처리 
		if(searchOpt==null)
			searchOpt = "";
		if(searchKey==null)
			searchKey="";
		
		dto.setPg(Integer.parseInt(pg)); 
		dto.setSearchOpt(searchOpt);
		dto.setSearchKeyword(searchKey);
		
		request.setAttribute("totalCnt", dao.getTotalCnt(dto));
		request.setAttribute("list", dao.getList(dto));
		
		String url="/guestbook/guestbook_list.jsp";
		// 다른 페이지로 이동할 때 사용
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
		//forward함수 사용 - 페이지 이동 시 기존의 request와 response 객체가 가지고 있는 값을 가지고 이동
	}
	
	void doView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestbookDao dao = new GuestbookDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		String url="/guestbook/guestbook_view.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
}
	
	void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url="/guestbook/guestbook_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
}
	
	void doSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestbookDao dao = new GuestbookDao();
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String contents = request.getParameter("contents");
		GuestbookDto dto = new GuestbookDto();
		dto.setTitle(title);
		dto.setWriter(writer);
		dto.setContents(contents);
		
		dao.insert(dto);
		String url = request.getContextPath()+"/guestbook.do?cmd=list";
		
		// forward 사용 불가 
		// DB에서 데이터 읽어와서 jsp로 넘기는 이중작업을 해야함
		// 그리고 request객체에 전달받은 데이터를 날려버려야 함
		// 그래야 한번만 저장
		// 등록하고 마지막은 절대로 forward가 아닌 sendRedirect 사용해야함!
		response.sendRedirect(url);
}
	void doModify(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		GuestbookDao dao = new GuestbookDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		//jsp로 이동하기 
		String url="/guestbook/guestbook_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	void doUpdate(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException{
		GuestbookDao dao = new GuestbookDao();
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String contents = request.getParameter("contents");
		String seq= request.getParameter("seq");
		
		
		GuestbookDto dto = new GuestbookDto();
		dto.setTitle(title);
		dto.setWriter(writer);
		dto.setContents(contents);
		dto.setSeq(seq);
		
		dao.update(dto);
		String url = request.getContextPath()+"/guestbook.do?cmd=list";
		response.sendRedirect(url);
	}
	
//	void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
//		GuestbookDao dao = new GuestbookDao();
//	}
	
}
