<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String xvalue = request.getParameter("xvalue");
String yvalue = request.getParameter("yvalue");
int x = Integer.parseInt(xvalue);
int y = Integer.parseInt(yvalue);
%>
<%=String.format("%d + %d = %d", x, y, x+y)%>