<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="myform">
		x : <input type="text" name="xvalue"/><br/>
		y : <input type="text" name="yvalue"/><br/>
		
		<button type="button" onclick="goSend()">더하기</button>
	</form>
</body>
</html>

<!-- 자바스크립트는 html이 아님. 그래서 <script>~</script>사이에 코드를 두어야함 -->
<script>
// 함수만들기 - 모든 함수는 function으로 시작
// 자바스크립트는 변수를 선언하지 않아도 사용 가능
// 변수앞에서는 var 또는 let 접두어만 가능
function goSend(){
	//form 객체에 대한 참조 가져오기
	var frm = document.myform; //document.form의 name속성
	frm.action = "/myhome2/JSP/result1.jsp";
	frm.method="POST";
	frm.submit(); // 서버로 정보 전송
}
</script>