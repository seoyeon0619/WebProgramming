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
	<h1>jquery test</h1>
	
	<button type="button" id="btnClick">click</button>
	
</body>
</html>
<script >
	//javascript 의 window.onload에 대응한다. 
	//문서 전체가 메모리로 로딩되고 나면 이부분이 호출된다.
	//자바스크립트 : document.getElementById, ~~~~~
	//$("셀렉터")     document.getElementById =>  $("#btnClick")
	//$("h1")  태그 셀렉터 
	//value   속성 -> val() 
	//innerHTML 속성 -> html()
	
	$(document).ready( ()=>{
		$("#btnClick").click(()=>{
			$("h1").html("jquery는 재밌다");
		})
	});
</script>





