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

x : <input type="text" id="x"><br/>
y : <input type="text" id="y"><br/>
result : <span id="result"></span><br/>
<button id="btnAdd" type="button">+</button>
<button id="btnSub" type="button">-</button>
<button id="btnMul" type="button">*</button>
<button id="btnDiv" type="button">/</button>

</body>
</html>
<script>
$(()=>{
	$("#btnAdd").click(()=>{
		var x = parseInt($("#x").val());
		var y = parseInt($("#y").val());
		$("#result").html(x+y);
	});

	
	
})
</script>





