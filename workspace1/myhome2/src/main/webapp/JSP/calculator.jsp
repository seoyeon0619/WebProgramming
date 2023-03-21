<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>calculator.jsp</h1>
	
	<form name="myform">
		<input type="hidden" name="operator"/>
		x : <input type="text" name="xvalue"/><br/>
		y : <input type="text" name="yvalue"/><br/>
		
		<button type="button" onclick="goSend('1')">+</button>&nbsp;
		<button type="button" onclick="goSend('2')">-</button>&nbsp;
		<button type="button" onclick="goSend('3')">×</button>&nbsp;
		<button type="button" onclick="goSend('4')">÷</button>&nbsp;
	</form>
</body>
</html>

<script>

function goSend(oper){
	var frm = document.myform; 
	frm.operator.value = oper;
	frm.action = "<%=request.getContextPath()%>/JSP/result2.jsp";
	frm.method="POST";
	frm.submit(); 
}
</script>