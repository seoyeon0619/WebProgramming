<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서연:)</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&family=Rubik+Bubbles&display=swap" rel="stylesheet">
<style>
        div{
        text-align : center;
        margin-top : 100px;
        }
        
        p{
        font-size : 100pt;
        color: #e0d2ff;
        }
        

        
        a{
            width: 200px;
            height: 120px;
            padding: 10px 10px;
            background-color: #e0d2ff;
            font-size: 15pt;
        }

        a:link {
            color: red;
            text-decoration: none;
        }
        a:hover {
             background-color: rgb(88, 88, 88);
             color: aliceblue;
        }

        a:active {
            background-color: hsl(331, 100%, 69%);
        } 
    </style>
</head>
<body>
<style>
        body, h1, h2, h3, h4, h5, h6, p, span {
          font-family: 'Gaegu', cursive;
        }
</style>
<div>

<%
	// 자바 코드를 둘 수 있음
	String hello = "이서연";
	
%>
<p><%=hello%></p>
<div>
	<a href="<%=request.getContextPath()%>/자기소개.jsp">자기소개</a>
	<a href="https://www.notion.so/LEE-SEO-YEON-85d648049b734e288d59e1462d20465b">Notion</a>
	<a href="https://kangnam.ac.kr/">학교홈페이지</a>
	<a href="<%=request.getContextPath()%>/일기쓰기.jsp">일기쓰기</a>
</div>
</div>
</body>
</html>