<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&family=Rubik+Bubbles&display=swap" rel="stylesheet">
<style>
p.round3{
	text-align : center;
	font-size : 50px;
	color : #ffffff;
  	border: 2px solid rgb(255, 208, 231);
  	border-radius: 100px;
  	padding : 30px;
  	magin : auto;
  	background-color : rgb(255, 208, 231)
	}
	
body{
	text-align : center;
}

button{
	padding : 10px;
}

</style>

</head>
<body>
<style>
        body, h1, h2, h3, h4, h5, h6, p, span {
          font-family: 'Gaegu', cursive;
        }
</style>

<p class="round3">오늘의 일기 :)</p>

오늘의 날짜 : <input type="date"><br/>
<h3></h3>

        <input type="checkbox" name="lan2" id="sel1" value="1"> 
		<label for="sel1">맑음 🌞</label>
        <input type="checkbox" name="lan2" id="sel2" value="2">
        <label for="sel2">구름 ☁</label>
        <input type="checkbox" name="lan2" id="sel3" value="3">
        <label for="sel3">비 💧</label> 
        <input type="checkbox" name="lan2" id="sel4" value="4">
        <label for="sel4">눈 ❄</label></br>
        <h3></h3>

        <input type="radio" name="lan2" id="sel1" value="1"> 
		<label for="sel1">기분좋아 😍</label>
        <input type="radio" name="lan2" id="sel2" value="2">
        <label for="sel2">그냥구래 😐</label>
        <input type="radio" name="lan2" id="sel3" value="3">
        <label for="sel3">우울행 😥</label> 
        <input type="radio" name="lan2" id="sel4" value="4">
        <label for="sel4">화가나 🤬</label>

<h3></h3>

	<textarea name="" id="" cols="100" rows="15"></textarea><br/>

<button>저장</button>
</body>
</html>