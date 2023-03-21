<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.yeon.myhome4.CommonUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String username = CommonUtil.nullToVal(request.getParameter("name"), "");
	int nKor = Integer.parseInt(CommonUtil.nullToVal(request.getParameter("kor"), "0"));
	int nEng = Integer.parseInt(CommonUtil.nullToVal(request.getParameter("eng"), "0"));
	int nMath = Integer.parseInt(CommonUtil.nullToVal(request.getParameter("math"), "0"));
	int nTotal = nKor + nEng + nMath;
	float avg = nTotal / 3.0f;
	
	%>
	<%=username%>의 총점은 <%=nTotal%>이고, 평균은 <%=avg%>입니다.
</body>
</html>