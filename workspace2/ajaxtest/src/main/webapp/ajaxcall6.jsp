<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxcall</title>
</head>
<body>
	<h1>Ajax 테스트</h1>

	
	<div id="result"></div>
	
	<button type="button" onclick="loadDoc()">JSON결과받아오기</button>
</body>
</html>
<script>
function loadDoc()
{
	let xhttp = new XMLHttpRequest(); 	
	
	xhttp.onload=function(){
		
		data = JSON.parse(this.responseText);
		
		console.log(data);
		
		let result="";
		result += "이름:"+data.username+"<br/>";
		result += "이메일:"+data.email+"<br/>";
		result += "전화번호:"+data.phone+"<br/>";
		
		document.getElementById("result").innerHTML=result;
	}
	
	let url = "ajaxtest/guest.do";
	
	console.log(url);
			
	xhttp.open("GET", url, true);
	
	xhttp.send(); 
}
</script>