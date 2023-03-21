<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kosa.mvc1.score.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>scoreList</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<form name="myform">
	<input type="hidden" name="cmd" />
	
<%@include file="/include/navbar.jsp" %>

<div class="container mt-3">
  <h3>성적확인</h3>
  <p></p>
  
  <div class="input-group mt-3 mb-3">
    <button type="button" class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown">
      Dropdown button
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#">Link 1</a></li>
      <li><a class="dropdown-item" href="#">Link 2</a></li>
      <li><a class="dropdown-item" href="#">Link 3</a></li>
    </ul>
    <input type="text" class="form-control" placeholder="Username">
    <div class="input-group-append">
    	<button class="btn btn-dark" type="button">GO</button>
    </div>
  </div>
  
  <table class="table">
  
    <thead class="table-dark">
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>국어</th>
        <th>영어</th>
        <th>수학</th>
        <th>날짜</th>
      </tr>
    </thead>
    
    <tbody>
    <%
    List<ScoreDto> list = (List<ScoreDto>)request.getAttribute("list");
    
    // 다운 캐스팅
    for(ScoreDto dto : list) {
    	String url = CONTEXT+"/score.do?cmd=view&seq="+dto.getSeq();
    %>
      <tr>
        <td><%=dto.getSeq()%></td>
        <td><a href="<%=url%>"><%=dto.getName()%></a></td>
        <td><%=dto.getKor()%></td>
        <td><%=dto.getEng()%></td>
        <td><%=dto.getMat()%></td>
        <td><%=dto.getWdate()%></td>
      </tr>
      <%} %>
    </tbody>
  </table>
</div>
  
  <div class="container" style="text-align:center">
  <ul class="pagination justify-content-center">
    <li class="page-item"><a class="page-link" href="#">Fist</a></li>
    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item"><a class="page-link" href="#">5</a></li>
    <li class="page-item"><a class="page-link" href="#">6</a></li>
    <li class="page-item"><a class="page-link" href="#">7</a></li>
    <li class="page-item"><a class="page-link" href="#">8</a></li>
    <li class="page-item"><a class="page-link" href="#">9</a></li>
    <li class="page-item"><a class="page-link" href="#">Next</a></li>
    <li class="page-item"><a class="page-link" href="#">Last</a></li>
  </ul>
 </div>

<div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark" id="btnWrite">성적등록</button>
</div>
</form>
</body>
</html>
<script>
window.onload=()=>{
	let btnWrite = document.getElementById("btnWrite");
	btnWrite.addEventListener("click", ()=>{
		let frm = document.myform;
		frm.action = "<%=CONTEXT%>/score.do";
		frm.cmd.value = "write";
		frm.submit();
	})
}
</script>


