<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>receive1.jsp</h1>
<%
	// request 객체 - 클라이언트가 서버한테 요청을 하면 그 요청을 담아서 가져오는 객체
	String userid=request.getParameter("userid");
	String password=request.getParameter("password");
%>
아이디 : <%=userid%><br/>
비밀번호 : <%=password%><br/>

</body>
</html>