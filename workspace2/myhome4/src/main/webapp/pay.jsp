<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pay</title>
</head>
<body>
<form name="myform">
	이름 : <input type="text" name="name"> <br/>
	주당 근무시간 : <input type="text" name="weektime"> <br/>
	시간당 단가 : <input type="text" name="timepay"> <br/>
	
	<button type="button" id="result">결과확인</button>
	</form>
</body>
</html>
<script>
window.onload=()=>{
	let btnResult = document.getElementById("result");
	btnResult.addEventListener("click", (e)=>{
		e.preventDefault();
		
		let frm = document.myform; 
	
		if(frm.name.value.trim()=="")
		{
			alert("이름을 입력하세요")
			frm.name.focus(); 
			return false;
		}
		
		if(frm.weektime.value.trim()=="")
		{
			alert("주당 근무시간을 입력하세요")
			frm.weektime.focus(); 
			return false;
		}
		
		if(frm.timepay.value.trim()=="")
		{
			alert("시간당 단가를 입력하세요")
			frm.timepay.focus(); 
			return false;
		}
		
		frm.method="get"; 
		frm.action="/myhome4/pay";
		frm.submit(); 
		
	})
}
</script>