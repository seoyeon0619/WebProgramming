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
	
	<button type="button" onclick="loadDoc()">Ajax 호출</button>
</body>
</html>
<script>
function loadDoc()
{
	// 비동기 통신을 담당할 클래스
	let xhttp = new XMLHttpRequest(); 	
	// 비동기 통신담당 객체 생성
	// xhttp객체에는 onload라는 변수(특성)가 있음
	// 이 변수에 통신이 완료한 후, 호출할 함수의 주소를 전달
	// 주의할 점 : 화살표함수 사용불가 (통신내용을 받아올 때 this를 사용해야하는데 화살표함수는 this 사용 불가)
	xhttp.onload=function(){
		// 서버로부터 응답이 완료될 때 이 함수가 호출됨
		document.getElementById("result").innerHTML = this.responseText;
		// this : xhttp 객체 자신 
		// 통신이 완료한 후에 responseText 변수에 서버로부터 전달받은 값이 들어있음
	}
	
	// 서버로 요청
	xhttp.open("GET", "ajax_test.txt",true);
	// GET - 통신방식, GET, POST 중에 선택가능
	// POST는 파라미터 전달방식이 복잡
	// 그래서 보통은 javascript로 ajax를 하지 않고 jquery나 axios같은 라이브러리를 이용해 ajax통신을 함
	// "ajax_test.txt" - 서버의 주소 jsp나 서블릿을 호출할 수 있음
	// true - 비동기 동기여부 보통은 true만 사용
	
	xhttp.send(); // 위 정보를 기반으로 서버와 통신
}
</script>