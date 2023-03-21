<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>guestbook_write</title>
  <meta charset="utf-8">
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
  sql = "select * from tb_guestbook"
		  + " where seq="+ seq;
  
  ResultSet rs = stmt.executeQuery(sql);
  // ----------------------------------------------------
  String title="";
  String writer="";
  String contents="";
  String wdate="";
  String hit="";
  
  if(rs.next())
  {
	title = rs.getString("title");  
	writer = rs.getString("writer");  
	contents = rs.getString("contents");  
	wdate = rs.getString("wdate");  
	hit = rs.getString("hit");  
  }
  rs.close();
  stmt.close();
  conn.close();
  %>
<form name="myform">
	<input type="hidden" name="seq" value="<%=seq %>">
	<input type="hidden" name="mode" value="<%=mode%>">

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
   	<a class="navbar-brand" href="#">
      <img src="/myhome2/images/p.png" alt="Logo" style="width:40px;" class="rounded-pill">
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>  
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Dropdown</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Link</a></li>
            <li><a class="dropdown-item" href="#">Another link</a></li>
            <li><a class="dropdown-item" href="#">A third link</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
	<h1> </h1>
  <h3>Navbar With Dropdown</h3>
  <p>This example adds a dropdown menu in the navbar.</p>
  
  
  <table class="table">
  <colgroup>
  	<col width="30%">
  	<col width="*">
  </colgroup>
    <tbody>
    <tr>
      <th>제목</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="제목을 입력하세요" name="title" id="title" value="<%=title%>">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>작성자</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="이름을 입력하세요" name="writer" id="writer" value="<%=writer%>">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>내용</td>
      <td>
      		<div class="input-group">
    			<textarea class="form-control" placeholder="내용을 입력하세요" name="contents" id="contents" rows="5"><%=contents%></textarea>
  			</div>
      </td>
      </tr>
    </tbody>
  </table>
</div>
  

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
		frm.action="/myhome4/guestbook/guestbook_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	<%}else{%>
	btnModify.addEventListener("click", (e)=>{
		e.preventDefault();
		let frm=document.myform;
		frm.action="/myhome4/guestbook/guestbook_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	<%} %>	
	btnDelete.addEventListener("click", (e)=>{
		e.preventDefault();
		let frm=document.myform;
		frm.action="/myhome4/guestbook/guestbook_proc.jsp";
		frm.method="post";
		frm.submit();
	});
	
}
</script>

