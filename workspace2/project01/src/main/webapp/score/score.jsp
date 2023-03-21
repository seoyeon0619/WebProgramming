<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Score</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<form name="myform">
	<input type="hidden" name="mode" value="insert">

<div class="container">
	<h1> </h1>
  <h3>성적관리</h3>
  
  <%
  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
  String userid = "user01";
  String pwd = "1234";
  
  Class.forName(driver);
  Connection conn = DriverManager.getConnection(url, userid, pwd);
  
  String sql = "select seq, name, kor, eng, mat, (kor+eng+mat) total, round((kor+eng+mat)/3,2) average, to_char(wdate, 'yyyy-mm-dd') wdate from tb_score";
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(sql);
  %>
  
  <table class="table">
    <thead class="table-dark">
    	<tr>
    		<th>번호</th>
    		<th>이름</th>
    		<th>국어</th>
    		<th>영어</th>
    		<th>수학</th>
    		<th>총점</th>
    		<th>평균</th>
    		<th>날짜</th>
    </thead>
    
    <tbody>
<%
  while(rs.next())
  {
%>
      <tr>
        <td><%=rs.getString("seq")%></td>
        <td><a href="/project01/score/score_view.jsp?seq=<%=rs.getString("seq")%>"><%=rs.getString("name")%></a></td>
        <td><%=rs.getString("kor")%></td>
        <td><%=rs.getString("eng")%></td>
        <td><%=rs.getString("mat")%></td>
        <td><%=rs.getString("total") %></td>
        <td><%=rs.getString("average") %></td>
        <td><%=rs.getString("wdate") %></td>
        <td><% %>
      </tr>
<%
  }
  rs.close();
  stmt.close();
  conn.close();
%>
    </tbody>
  </table>
</div>

<div class="container" style="text-align:right">
	<button type="button" id="btnWrite" class="btn btn-dark">성적등록</button>
</div>
</form>
</body>
</html>
<script>
window.onload=()=>{
	document.getElementById("btnWrite").addEventListener("click", ()=>{
		let frm=document.myform;
		frm.action="/project01/score/score_write.jsp";
	
		frm.method="get";
		frm.submit();
	});
}
</script>


