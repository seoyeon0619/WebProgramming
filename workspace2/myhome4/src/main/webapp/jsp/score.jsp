<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>score</title>
</head>
<body>
<form name="myform">
	이름 : <input type="text" name="name"> <br/>
	국어 : <input type="text" name="kor"> <br/>
	영어 : <input type="text" name="eng"> <br/>
	수학 : <input type="text" name="math"> <br/>
	
	<button type="button" id="result">결과</button>
	</form>
</body>
</html>

<script>
window.onload=()=>{
	let btnResult = document.getElementById("result");
	btnResult.addEventListener("click", (e)=>{
		e.preventDefault();
		
		let frm = document.myform; 
	
		frm.method="post"; 
		frm.action="/myhome4/jsp/score_proc.jsp";
		frm.submit(); 
		
	})
}
</script>