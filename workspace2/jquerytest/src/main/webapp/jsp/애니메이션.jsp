<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<div id="box" style="background:#98bf21;height:100px;width:100px;position:absolute;"></div>
</body>
</html>
<script>
$(()=>{
	$("#box").click( ()=>{
		/*$("#box").animate(
		{
			left:"500px",
			top:"150px",
			opacity:"0.2"			
		}, 3000); //3초에 걸쳐서 투명해지기	
		*/		
		$("#box").animate(
		{
			left:"500px",
			opacity:"0.2"			
		}, 3000, ()=>{
			$("#box").animate(
			{
				top:"250px",			
			}, 3000)
		});
	})
	
})
</script>