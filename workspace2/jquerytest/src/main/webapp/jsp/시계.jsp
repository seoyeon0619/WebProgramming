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
	font-size:30pt;
}

</style>
</head>
<body>
	
<body>
	<div id="flip">시계시작과종료</div>
	<div id="panel">Hello world !!!</div>
</body>
</html>

<script>

//전역변수 - 함수의 영역이 아니라 함수 영역밖에서 존재하는 변수 
//          자바라면  static  변수여야 한다 
let timer1=null;
$(()=>{
	$("#flip").click ( ()=>{
		//setInterval(함수, 시간) 시간마다 함수가 호출된다. 
		//timer1변수는  click내에서만 존재하는 지역변수라 
		//이 함수가 종료하면 사라진다.
		if(timer1!=null) //이미 시작하고 있는 시계가 있다 
		{
			clearTimeout(timer1); //종료하고, 종료해도 timer1이 null이 되지는 않는다
			timer1=null; //초기화를 직접 하자 
		}
		else
		{
			timer1 = setInterval(()=>{
				today = new Date(); //현재날짜와 시간 구하기
				hour = today.getHours();
				minutes = today.getMinutes();
				seconds = today.getSeconds();
				
				currentTime = hour+"시 " + minutes + "분 " + seconds + "초";
				$("#panel").html(currentTime);
				
			}, 1000);
		}
	});
	
	//반환값이 - 핸들, 객체 식별값  
}); 
</script>






