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
<button id="btnClick" type="button">나타났다 사라졌다합니다.</button><br/>
<p>toggle연습</p>
</body>
</html>
<script>
$( ()=>{
	$("#btnClick").click( ()=>{
		$("p").toggle();
	})
});
</script>



