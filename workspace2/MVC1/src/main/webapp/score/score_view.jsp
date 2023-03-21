<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kosa.mvc1.score.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>scoreView</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
String seq = request.getParameter("seq");
%>
<form name="myform">
	<input type="hidden" name="seq" value="<%=seq%>">
	<input type="hidden" name="cmd">
	
<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3>성적 상세 보기</h3>
  <p></p>
  
  <table class="table">

    <tbody>
    <%
    ScoreDto dto = (ScoreDto)request.getAttribute("dto");	
    %>
    <tr>
      <th>이름</td>
      <td><%=dto.getName()%></td>
      <th>국어</td>
      <td><%=dto.getKor()%></td>
      <th>영어</td>
      <td><%=dto.getEng()%></td>
      <th>수학</td>
      <td><%=dto.getMat()%></td>
     </tr>
    </tbody>
  </table>
</div>

<div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark" id="btnList">목록</button>&nbsp;&nbsp;
	<button type="button" class="btn btn-dark" id="btnModify">수정</button>&nbsp;&nbsp;
	<button type="button" class="btn btn-dark" id="btnDelete">삭제</button>
</div>

</form>
</body>
</html>

<script>
window.onload=()=>{
	let btnList = document.getElementById("btnList");
	btnList.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/score.do";
		frm.cmd.value="list";
		frm.submit();
	});
	
	let btnModify = document.getElementById("btnModify");
	btnModify.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/score.do";
		frm.cmd.value="modify";
		frm.submit();
	});
	
}
</script>


