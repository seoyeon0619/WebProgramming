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
		
		//console.log(e);
		//console.log(e.target);
		let frm = document.myform; 
	
		if(frm.name.value.trim()=="")
		{
			alert("이름을 입력하세요")
			frm.name.focus(); 
			return false;
		}
		
		if(frm.kor.value.trim()=="")
		{
			alert("국어 점수를 입력하세요")
			frm.kor.focus(); 
			return false;
		}
		
		if(frm.eng.value.trim()=="")
		{
			alert("영어 점수를 입력하세요")
			frm.eng.focus(); 
			return false;
		}
		
		if(frm.math.value.trim()=="")
		{
			alert("수학 점수를 입력하세요")
			frm.math.focus(); 
			return false;
		}
		
		frm.method="get"; 
		frm.action="/myhome4/scoreResult";
		frm.submit(); 
		
	})
}
</script>