<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
  String userid = "user01";
  String pwd = "1234";
  
  Class.forName(driver); // 드라이브 파일 로딩
  Connection conn = DriverManager.getConnection(url, userid, pwd); // 디비 접속 연결 객체 생성
  
  	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
  
  // 서버로 넘어오는 값을 받자
  String title = request.getParameter("title");
  String writer = request.getParameter("writer");
  String contents = request.getParameter("contents");
  String sql="";
  
  
  String mode = request.getParameter("mode");
  String seq = request.getParameter("seq");
  String msg="";
  
  if (mode.equals("insert")){
	  sql = "insert into tb_guestbook" 
		  +"(seq, title, writer, contents, wdate, hit) values("
		  + "sq_guest.nextval, "
		  +"'"+title+"', "
		  +"'" +writer+"',"
		  +"'"+contents+"',"
		  +"sysdate, 0)";
	msg = "글이 등록되었습니다";
  }
  else if (mode.equals("modify")){
	  sql = "update tb_guestbook set title='"+title+"'"
			  + ", writer='"+writer+"' "
			  + ", contents='"+contents+"' "
			  + " where seq = "+seq;
	  msg = "글이 수정되었습니다";
  }
  else if (mode.equals("delete")){
	  sql = "delete from tb_guestbook "
			  + " where seq = "+seq;
	  msg = "글이 삭제되었습니다";
  }
  
 
  System.out.println(sql);
  Statement stmt = conn.createStatement();
  boolean result = stmt.execute(sql);
  stmt.close();
  conn.close();
%>

<script>
alert("<%=msg%>");
// 완료 후 list 페이지로 이동
location.href="/myhome4/guestbook/guestbook_list.jsp";
</script>