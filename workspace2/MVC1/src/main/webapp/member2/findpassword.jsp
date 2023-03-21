<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>비밀번호찾기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<form name="myform">
	<input type="text" name="idcheck" id="idcheck" value="N">

<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3>비밀번호찾기</h3>
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
      <th>이메일</td>
      <td>
      		<div class="input-group">
    			<input type="email" class="form-control" placeholder="이메일을 입력하세요" name="email" id="email">
  			</div>
      </td>
      </tr>
      
      

    </tbody>
  </table>
</div>
  
<div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark" onclick="goFindpassword()">비밀번호찾기</button>
</div>
</form>
</body>
</html>
<script>
function goFindpassword()
{
let xhttp = new XMLHttpRequest();
let url = "/MVC1/member.do?cmd=findpasswordproc&user_id="+
		document.getElementById("user_id").value
		+"&email="+document.getElementById("email").value;
console.log(url);

xhttp.onload = function(){
	console.log(this.responseText);
	
	let data = JSON.parse(this.responseText);
	if(data.result=="success")
		{
		alert("비밀번호는 "+data.password);
		location.href="<%=CONTEXT%>/member.do?cmd=member_logon";
		}
	else
		alert("일치하는 정보가 없습니다");
}

xhttp.open("GET", url, true);
xhttp.send();

}


</script>

