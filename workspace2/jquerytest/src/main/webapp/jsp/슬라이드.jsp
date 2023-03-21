<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
#panel, #flip{
	padding:5px;
	text-align:center;
	background-color:#8888ff;
	border:solid 1px #c3c3c3;
}

#panel{
	padding:50px;
}

</style>
</head>

<body>
	<div id="flip">Click</div>
	<div id="panel">Hello world !!!</div>
</body>
</html>
<script>
$(function(){
	$("#panel").css("display", "none"); //처음에 안보이게 하고 시작한다 
	//slideUp, Down 이 display속성도 바꾼다. 
	/*$("#flip").click( ()=>{
		$("#panel").slideUp("slow");
	});
	*/
	//내려갔다가 2초 있다가 올라가기 
	$("#flip").click( ()=>{
		$("#panel").slideDown("slow", function(){
			//다 내려오면 이 콜백함수가 호출된다. 
			//자바스크립트에 setTimeout(함수, 시간);
			//뒤에 지정한 시간이 흐른 이후에 한번 앞의 함수를 호출한다 
			//2초마다 계속 발생하고 싶다 setInterval함수를 사용한다 
			setTimeout( ()=>{
				$("#panel").slideUp();
			}, 2000); //2초에 한번 작동한다 
		});
	});
	
})
</script>



