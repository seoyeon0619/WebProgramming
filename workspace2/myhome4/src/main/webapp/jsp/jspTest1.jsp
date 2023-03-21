<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	for(int i=1; i<=10; i++)
	{
		out.println("i=" + i + "<br/>");
	}
	// 이 구간에는 함수, 클래스 선언 불가
%>
</body>
</html>