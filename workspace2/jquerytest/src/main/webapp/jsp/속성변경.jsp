<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
	<h1>속성변경 :  prop:현재 attr:1.4이전버전</h1>
	<p>스타일변경도 가능하나   css함수가 더 쉽다</p> 
	
	<input type="text" id="test1" >
	<button type="button" id="btnChange">속성변경</button>
</body>
</html>
<script>
$( ()=>{
	$("p").prop("style", "color:blue;background-color:yellow");
	//form 태그의 action, method등을 변경하고자 할때 주로 쓴다 
	$("#btnChange").click( ()=>{
		$("#test1").prop("disabled", true);
	})
} )
</script>






