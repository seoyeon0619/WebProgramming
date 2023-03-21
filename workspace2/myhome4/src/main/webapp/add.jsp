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
	<input type="hidden" name="operator" id="operator">
	x : <input type="text" name="x"> <br/>
	y : <input type="text" name="y"> <br/>
	
	<button type="text" id="btnAdd">더하기</button>
	<button type="text" id="btnSub">빼기</button>
	<button type="text" id="btnMul">곱하기</button>
	<button type="text" id="btnDiv">나누기</button>
	</form>
</body>
</html>

<script>
	window.onload=()=>{
		let btnAdd = document.getElementById("btnAdd");
		btnAdd.addEventListener("click", goSend); // 함수의 주소 전달
		btnSub.addEventListener("click", goSend);
		btnMul.addEventListener("click", goSend);
		btnDiv.addEventListener("click", goSend);
	}
	
	function goSend(e)
	{
		if(e.target==btnAdd)
			document.getElementById("operator").value = "1";
		
		else if(e.target==btnSub)
			document.getElementById("operator").value = "2";
		
		else if(e.target==btnMul)
			document.getElementById("operator").value = "3";
		
		else if(e.target==btnDiv)
			document.getElementById("operator").value = "4";
		
		let frm = document.myform; 
		
		if(frm.x.value.trim()=="")
		{
			alert("숫자를 입력하세요")
			frm.x.focus(); 
			return false;
		}
		
		if(frm.y.value.trim()=="")
		{
			alert("숫자를 입력하세요")
			frm.y.focus(); 
			return false;
		}
		
		frm.method="get"; 
		frm.action="/myhome4/cal"; 
		frm.submit(); 
	}
</script>