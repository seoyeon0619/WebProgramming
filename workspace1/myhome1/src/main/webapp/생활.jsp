<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        a{
            width: 200px;
            height: 120px;
            padding: 10px 10px;
            background-color: hsl(0, 100%, 91%);
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
	<a href="<%=request.getContextPath()%>/일기쓰기.jsp">일기쓰기</a>
</body>
</html>