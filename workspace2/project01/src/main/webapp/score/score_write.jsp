<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>성적등록</title>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
 // seq파라미터값 받아서 조회수 증가하고 데이터 가져오기
  String seq = request.getParameter("seq");
  String mode = request.getParameter("mode");
 
  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
  String userid = "user01";
  String pwd = "1234";
  
  Class.forName(driver);
  Connection conn = DriverManager.getConnection(url, userid, pwd);
  //----------------------------------------------------
  // insert, update, delete
  String sql = "";
  
  Statement stmt = conn.createStatement();
  // ----------------------------------------------------
  sql = "select * from tb_score"
		  + " where seq="+ seq;
  
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
	eng = rs.getString("eng");  
	mat = rs.getString("mat");  
	wdate = rs.getString("wdate");  
  }
  rs.close();
  stmt.close();
  conn.close();
  %>
<form name="myform">
	<input type="hidden" name="seq" value="<%=seq %>">
	<input type="hidden" name="mode" value="<%=mode%>">

<div class="container">
<h1></h1>
 <table class="table">
  <colgroup>
  	<col width="30%">
  	<col width="*">
  </colgroup>
    <tbody>
    
    <tr>
      <th>이름</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="이름을 입력하세요" 
    			name="name" id="name" value="<%=name%>">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>국어</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="국어점수를 입력하세요" 
    			name="kor" id="kor" value="<%=kor%>">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>영어</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="영어점수를 입력하세요" 
    			name="eng" id="eng" value="<%=eng%>">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>수학</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="수학점수를 입력하세요" 
    			name="mat" id="mat" value="<%=mat%>">
  			</div>
      </td>
      </tr>
      
    </tbody>
  </table>
  
<div class="container" style="text-align:right">
<%if(mode.equals("insert")){ %>
	<button type="button" class="btn btn-dark" id="btnSend">등록</button>
<%}else{ %>	
	<button type="button" class="btn btn-dark" id="btnModify">수정</button>
<%} %>
	&nbsp;&nbsp;
	<button type="button" class="btn btn-dark" id="btnList">목록</button>
</div>
</form>
</body>
</html>
<script>
window.onload=()=>
{
	let btnSend = document.getElementById("btnSend");
	let btnModify = document.getElementById("btnModify");
	let btnDelete = document.getElementById("btnDelete");
	
	<%if(mode.equals("insert")){%>
	btnSend.addEventListener("click", (e)=>{
		e.preventDefault();
		let frm=document.myform;
		frm.action="/project01/score/score_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	<%}else{%>
	btnModify.addEventListener("click", (e)=>{
		e.preventDefault();
		let frm=document.myform;
		frm.action="/project01/score/score_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	<%} %>	
	btnDelete.addEventListener("click", (e)=>{
		e.preventDefault();
		let frm=document.myform;
		frm.action="/project01/score/score_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	
}
</script>