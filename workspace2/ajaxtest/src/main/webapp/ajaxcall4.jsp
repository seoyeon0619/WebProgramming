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
		// String -> Json 객체로 전황
		data = JSON.parse(this.responseText);
		
		console.log(data);
		
		let result="";
		result += "이름:"+data.username+"<br/>";
		result += "이메일:"+data.email+"<br/>";
		result += "전화번호:"+data.phone+"<br/>";
		
		document.getElementById("result").innerHTML=result;
	}
	
	let url = "receive2.jsp"; // 결과를 json형태로 보냄
	// json은 데이터 형식이 {"키1": "값1", "키2" : "값2"} 
	// 그밖에 html등의 태그도 없어야 함 
	// 딱 json 데이터만 전송해야함
	
	console.log(url);
			
	xhttp.open("GET", url, true);
	
	xhttp.send(); 
}
</script>