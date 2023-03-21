<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="en">
<head>
  <title>logon</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<form name="myform">
	<inpurt type="text" name="idcheck" id="idcheck" value="N">

<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3>Logon</h3>
  <p></p>
  
  <table class="table">
  <colgroup>
  	<col width="30%">
  	<col width="*">
  </colgroup>
    <tbody>
    
    <tr>
      <th>아이디</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="아이디를 입력하세요" name="user_id" id="user_id">
  			</div>
      </td>
      </tr>
    
      <tr>
      <th>비밀번호</td>
      <td>
      		<div class="input-group">
    			<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="password" id="password">
  			</div>
      </td>
      </tr>
      
      

    </tbody>
  </table>
</div>
  
<div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark" onclick="goLogon()">Logon</button>
</div>
</form>
</body>
</html>
<script>
function goLogon()
{
let xhttp = new XMLHttpRequest();
let url = "/MVC1/member.do?cmd=logon_proc&user_id="+
		document.getElementById("user_id").value
		+"&password="+document.getElementById("password").value;
console.log(url);

xhttp.onload = function(){
	console.log(this.responseText);
	
	let data = JSON.parse(this.responseText);
	if(data.result=="success")
		{
		alert("로그온 성공");
		location.href="<%=CONTEXT%>/index.jsp";
		}
	else
		alert("아이디나 비밀번호가 일치하지 않습니다");
}

xhttp.open("GET", url, true);
xhttp.send();

}


</script>

