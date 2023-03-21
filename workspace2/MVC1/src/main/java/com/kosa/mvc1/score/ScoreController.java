package com.kosa.mvc1.score;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kosa.mvc1.guestbook.GuestbookDao;
import com.kosa.mvc1.guestbook.GuestbookDto;


@WebServlet("/score.do")
public class ScoreController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ScoreController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("cmd");
		
		ScoreDao dao = new ScoreDao();
		
		if(cmd==null || cmd.equals(""))
			cmd="list";
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
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ScoreDao dao = new ScoreDao();
		request.setAttribute("list", dao.getList());
		String url="/score/score_list.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	void doView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ScoreDao dao = new ScoreDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		String url="/score/score_view.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);

}
	void doWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url="/score/score_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
}
	
	void doSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ScoreDao dao = new ScoreDao();
		String name = request.getParameter("name");
		String kor = request.getParameter("kor");
		String eng = request.getParameter("eng");
		String mat = request.getParameter("mat");
		ScoreDto dto = new ScoreDto();
		dto.setName(name);
		dto.setKor(kor);
		dto.setEng(eng);
		dto.setMat(mat);
		
		dao.insert(dto);
		String url = request.getContextPath()+"/socre.do?cmd=list";
		response.sendRedirect(url);
}
	void doModify(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException
	{
		ScoreDao dao = new ScoreDao();
		String seq = request.getParameter("seq");
		
		request.setAttribute("dto", dao.getView(seq));
		
		//jsp로 이동하기 
		String url="/score/score_write.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
	
	void doUpdate(HttpServletRequest request, 
	          HttpServletResponse response) throws ServletException, IOException{
		ScoreDao dao = new ScoreDao();
		String name = request.getParameter("name");
		String kor = request.getParameter("kor");
		String eng = request.getParameter("eng");
		String mat = request.getParameter("mat");
		String seq= request.getParameter("seq");
		
		
		ScoreDto dto = new ScoreDto();
		dto.setName(name);
		dto.setKor(kor);
		dto.setEng(eng);
		dto.setMat(mat);
		dto.setSeq(seq);
		
		dao.update(dto);
		String url = request.getContextPath()+"/score.do?cmd=list";
		response.sendRedirect(url);
	}
}




