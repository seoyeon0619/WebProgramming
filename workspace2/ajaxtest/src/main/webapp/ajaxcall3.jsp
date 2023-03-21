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
	x : <input type="text" id="xvalue"><br/>
	y : <input type="text" id="yvalue"><br/>
	
	<div id="result"></div>
	
	<button type="button" onclick="loadDoc()">Ajax 호출</button>
</body>
</html>
<script>
function loadDoc()
{
	let xhttp = new XMLHttpRequest(); 	
	xhttp.onload=function(){
		document.getElementById("result").innerHTML = this.responseText;
	}
	
	// get방식일 경우, receive1.jsp?xvalue=5&yvalue=8 형태로 url 생성
	let params = "xvalue="+document.getElementById("xvalue").value
				+"&yvalue="+document.getElementById("yvalue").value;
	console.log(params); // url 확인용 코드
			
	xhttp.open("POST", "receive1.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(params); 
}
</script>