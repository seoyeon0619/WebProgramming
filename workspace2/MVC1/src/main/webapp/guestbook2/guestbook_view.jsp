<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kosa.mvc1.guestbook.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookView</title>
</head>
<body>
<%
	GuestbookDto dto = (GuestbookDto)request.getAttribute("dto");	
%>
<ul>
	<li><%=dto.getTitle()%>
	<li><%=dto.getWriter()%>
	<li><%=dto.getContents()%>
	<li><%=dto.getWdate()%>
	<li><%=dto.getHit()%>
</ul>
</body>
</html>