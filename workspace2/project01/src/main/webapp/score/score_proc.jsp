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
  String name = request.getParameter("name");
  String kor = request.getParameter("kor");
  String eng = request.getParameter("eng");
  String mat = request.getParameter("mat");
  String sql="";
  
  String mode = request.getParameter("mode");
  String seq = request.getParameter("seq");
  String msg="";
  
  if (mode.equals("insert")){
  sql = "insert into tb_score" 
		  +"(seq, name, kor, eng, mat, wdate) values("
				  + "sq_score.nextval, "
				  +"'"+name+"', "
				  +"'"+kor+"',"
				  +"'"+eng+"',"
				  +"'"+mat+"',"
				  +"sysdate)";
  msg = "성적이 등록되었습니다";
  }
  else if (mode.equals("modify")){
	  sql = "update tb_score set name='"+name+"'"
			  + ", kor='"+kor+"' "
			  + ", eng='"+eng+"' "
			  + ", mat='"+mat+"' "
			  + " where seq = "+seq;
	  msg = "성적이 수정되었습니다";
  }
  else if (mode.equals("delete")){
	  sql = "delete from tb_score "
			  + " where seq = "+seq;
	  msg = "성적이 삭제되었습니다";
  }
  
  System.out.println(sql);
  
  Statement stmt = conn.createStatement();
  boolean result = stmt.execute(sql);
  stmt.close();
  conn.close();
%>

<script>
alert("<%=msg%>");
location.href="/project01/score/score.jsp";
</script>