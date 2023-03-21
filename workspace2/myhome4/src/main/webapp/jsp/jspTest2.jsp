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
	String slimit = request.getParameter("limit");
	int i;
	int limit = Integer.parseInt(slimit);
	for(i=1; i<=limit; i++)
	{
		out.println("i= " + i + "<br/>");
	}
%>
</body>
</html>