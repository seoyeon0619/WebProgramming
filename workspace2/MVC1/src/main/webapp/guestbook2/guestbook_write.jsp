<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookWrite</title>
</head>
<body>
	<form name="myform" action="/MVC1/guestbook.do?cmd=save" method="post">
		제목 : <input type="text" name="title"/><br/>
		작성자 : <input type="text" name="writer"/><br/>
		내용 : <input type="text" name="contents"/><br/>
		<input type="submit" value="등록"/>
		<!--  submit 버튼 사용시 form태그의 action속성과 method 지정해야함 -->
	</form>
</body>
</html>