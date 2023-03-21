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
	<h1>이벤트 연습하기</h1>
</body>
</html>
<script>
$(document).ready(  ()=>{
	$("h1").click(()=>{
		console.log("click 이벤트 발생");
	});
	
	
	$("h1").mouseenter(()=>{
		console.log("mouseenter 이벤트 발생");
	});
	
	//leave  위쪽에 
	$("h1").hover(function(){
		console.log("hover 이벤트 발생");
		$(this).css("background-color", "gray");
	});
	
	$("h1").mouseleave(function(){
		console.log("mouseleave 이벤트 발생");
		$(this).css("background-color", "white");
	});
	

});


</script>



