<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- script src="/jquerytest/js/jquery-3.6.3.min.js"></script -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
	<h1>jquery test 1</h1>
	<h1>jquery test 2</h1>
	<h1 id="test1">jquery test 3</h1>
	<h1 id="test1">jquery test 4</h1>
	<h1 class="test1">jquery test 5</h1>
	<h1 class="test1">jquery test 6</h1>
	<h1 class="test1">jquery test 7</h1>
	
	<button type="button" id="btnClick1">태그로 접근하기</button><br/>
	<button type="button" id="btnClick2">id로 접근하기</button><br/>
	<button type="button" id="btnClick3">클래스로 접근하기</button><br/>

</body>
</html>
<script >
	$(document).ready( ()=>{
		
		$("#btnClick1").click(()=>{
			$("h1").html("태그로 접근하기");
		});
		
		$("#btnClick2").click(()=>{
			$("#test1").html("아이디로 접근하기"); //첫번째것만 영향을 받는다 
		});
		
		$("#btnClick3").click(()=>{
			$(".test1").html("클래스로 접근하기"); //첫번째것만 영향을 받는다 
		});
		
		$("h1").click( function(){
			$(this).html("this로 접근하기 ")
		})
		
	});
</script>





