<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.kosa.mvc1.guestbook.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookList</title>
</head>
<body>
	<h1>Guestbook</h1>
	
	<%
	List<GuestbookDto> list = (List<GuestbookDto>)request.getAttribute("list");
	%>
	<table>
	<%
	for(GuestbookDto dto : list)
	{
	%>
		<tr>
			<td><a href="/MVC1/guestbook.do?cmd=view&seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a></td>
			<td><%=dto.getWriter()%></td>
			<td><%=dto.getContents()%></td>
			<td><%=dto.getWdate()%></td>
			<td><%=dto.getHit()%></td>
		</td>
	<%	
	}
	%>
	</table>
</body>
</html>