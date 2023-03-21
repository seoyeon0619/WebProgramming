<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>score_view</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<%
 // seq파라미터값 받아서 조회수 증가하고 데이터 가져오기
  String seq = request.getParameter("seq");
 
  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
  String userid = "user01";
  String pwd = "1234";
  
  Class.forName(driver);
  Connection conn = DriverManager.getConnection(url, userid, pwd);
  
  String sql = "select * from tb_score"
		  + " where seq="+ seq;
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(sql);
  // ----------------------------------------------------
  String name="";
  String kor="";
  String eng="";
  String mat="";
  String wdate="";
  
  if(rs.next())
  {
	name = rs.getString("name");  
	kor = rs.getString("kor");  
	eng= rs.getString("eng");  
	mat = rs.getString("mat");  
	wdate = rs.getString("wdate");  
  }
  rs.close();
  stmt.close();
  conn.close();
  %>
<form name="myform">
	<input type="hidden" name="mode" value="modify">
	<input type="hidden" name="seq" value="<%=seq %>">
	

<div class="container">
<h1> </h1>
<h3>성적</h3>

	<table class="table">
	<colgroup>
	  	<col width="25%">
	  	<col width="25%">
	  	<col width="25%">
	  	<col width="25%">
  </colgroup>

    <tbody>
    <tr>
      <th>이름</td>
      <td><%=name %></td>
    </tr>
    
    <tr>
      <th>국어</td>
      <td><%=kor%></td>
    </tr>
      
     <tr>
      <th>영어</td>
      <td><%=eng%></td>
    </tr>
    
    <tr>
      <th>수학</td>
      <td><%=mat%></td>
    </tr>
    </tbody>
  </table>
</div>

<div class="container" style="text-align:left">
	<button type="button" id="btnModify" class="btn btn-secondary">수정</button>&nbsp;&nbsp;
	<button type="button" id="btnDelete" class="btn btn-secondary">삭제</button>&nbsp;&nbsp;
	<button type="button" id="btnList" class="btn btn-dark">목록</button>
</div>
</form>
</body>
</html>

<script>
window.onload=()=>{
	document.getElementById("btnModify").addEventListener("click", goModify);
	document.getElementById("btnDelete").addEventListener("click", goDelete);
	document.getElementById("btnList").addEventListener("click", goList);
}

function goModify(){
	let frm = document.myform;
	frm.action = "/project01/score/score_write.jsp";
	frm.submit();
}

function goList(){
	location.href="/project01/score/score_list.jsp";	
}

function goDelete()
{
	if(confirm("삭제하시겠습니까?"))
	{
		let frm = document.myform;
		frm.mode.value = "delete";
		frm.action = "/project01/score/score_proc.jsp";
		frm.submit();
	}
}
</script>