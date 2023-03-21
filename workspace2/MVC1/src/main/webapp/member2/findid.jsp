<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>아이디찾기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

<form name="myform">
	<input type="text" name="idcheck" id="idcheck" value="N">

<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3>아이디찾기</h3>
  <p></p>
  
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
    			<input type="text" class="form-control" placeholder="이름을 입력하세요" name="user_name" id="user_name">
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
	<button type="button" class="btn btn-dark" onclick="goFindid()">아이디찾기</button>
</div>

<div class="container" id="findid" style="text-align:center" ></div>
</form>
</body>
</html>
<script>
function goFindid()
{
	data={
			cmd:"findidproc",
			user_name:$("#user_name").val(),
			email:$("#email").val()
		}
		
		$.ajax({
			url:"<%=CONTEXT%>/member.do",
			data:data,
			dataType:"JSON",
			method:"POST"
		})
		
		.done((response)=>{
			if(response.result=="success")
			{
				$("#findid").html("아이디는"+response.user_id+"입니다");
			}
			else
			{
				alert("일치하는 정보가 없습니다");
			}
		})
		
		.fail((request, status, error)=>{
		console.log(request);
		console.log(status);
		console.log(error);
	})
}


</script>

