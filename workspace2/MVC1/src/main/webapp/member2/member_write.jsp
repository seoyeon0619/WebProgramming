<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

<form name="myform">
	<inpurt type="text" name="idcheck" id="idcheck" value="N">

<%@include file="/include/navbar.jsp" %>

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
      <th>아이디</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="아이디를 입력하세요" name="user_id" id="user_id">
    			<a href="#none" onclick="goIdCheck()"><span class="input-group-text">중복확인</span></a>
  			</div>
      </td>
      </tr>
    <tr>
      <th>이름</td>
      <td>
      		<div class="input-group">
    			<input type="text" class="form-control" placeholder="이름을 입력하세요" name="user_name" id="user_name">
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
      
      <tr>
      <th>비밀번호 확인</td>
      <td>
      		<div class="input-group">
    			<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="password2" id="password2">
  			</div>
      </td>
      </tr>
      
      <tr>
      <th>전화번호</td>
      <td>
      		<div class="input-group">
    			<input type="tel" class="form-control" placeholder="전화번호를 입력하세요" name="phone" id="phone">
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
	<button type="button" class="btn btn-dark" onclick="goSave()">회원가입</button>
</div>
</form>
</body>
</html>
<script>
function goIdCheck()
{
	let user_id =document.getElementById("user_id").value;
	
	// 체이닝 기술 객체().함수호출().함수호출().....
	$.ajax( {
		url:"<%=CONTEXT%>/member.do",
		data:{cmd:"idcheck", user_id:user_id},
		dataType:"JSON",
		method:"POST"
	})
	.done( (response)=>{
		// 괄호안에 통신이 성공적으로 이루어졌을 때 처리할 함수 전달
		// 응답을 받아서 처리해야 함
		// 응답이 dataType:"JSON" 으로 보내면 JSON객체를 전달 받음 (자동 parsing)
	console.log(response);
	if(response.result=="success")
		{
		alert("사용가능한 아이디입니다");
		$("#idcheck").val("Y");
		// 사용하지 못하도록 막아버림
		$("#user_id").prop("disabled", true);
		}
	else
		{
		alert("이미 존재하는 아이디입니다");
		}
	}) 
	
	.fail( (request, status, error)=>{
		console.log(request);
		console.log(status);
		console.log(error);
		// 괄호안에 통신이 문제가 생겼을 경우 처리할 함수 전달
		// ajax는 기본이 비동기 처리라서 반환값 사용 가능
		// 일을 수행하고 난 후, done에 전달된 함수를 호출하고 실패 시 fail에 전달된 함수 실행
	}) 

}

function goSave()
{
	if($("#idcheck").val()=="N")
	{
		alert("아이디 중복체크를 하세요");
		$("#user_id").focus();
		return false;
	}
	
	let user_id= $("#user_id").val();
	let password= $("#password").val();
	let email= $("#email").val();
	let user_name= $("#user_name").val();
	let phone= $("#phone").val();
	
	$.ajax({
		url:"<%=CONTEXT%>/member.do",
		data:{cmd:"member_save", user_id:user_id, email:email,
			password:password, user_name:user_name, phone:phone},
			dataType:"JSON",
			method:"POST"
	})
	.done((response)=> {
		if(response.result=="success")
		{
			alert("회원가입되었습니다");
			location.href="<%=CONTEXT%>/index.jsp";
		}
		else
			{
			alert("회원가입실패");
			}
	})
	.fail((response, status, error)=>{
		console.log(status)
	});
	
}
</script>

