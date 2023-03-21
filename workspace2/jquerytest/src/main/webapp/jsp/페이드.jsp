<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("#btnFadeIn").click(function(){
    $("#div1").fadeIn();  //기본시간
    $("#div2").fadeIn("slow"); //천천히 
    $("#div3").fadeIn(5000, ()=>{
    	alert("완료");
    }); //시간, 1000이 1초임 3초동안 나타나라
  });
  
  $("#btnFadeOut").click(function(){
    $("#div1").fadeOut();  //기본시간
    $("#div2").fadeOut("slow"); //천천히 
    $("#div3").fadeOut(5000, ()=>{
    	alert("완료");
    }); //시간, 1000이 1초임 3초동안 나타나라
  });
	  
  
  
  
});
</script>
</head>
<body>

<p>Demonstrate fadeIn() with different parameters.</p>

<button type="button" id="btnFadeIn">Click to fade in boxes</button><br><br>
<button type="button" id="btnFadeOut">Click to fade out boxes</button><br><br>

<div id="div1" style="width:80px;height:80px;display:none;background-color:red;"></div><br>
<div id="div2" style="width:80px;height:80px;display:none;background-color:green;"></div><br>
<div id="div3" style="width:80px;height:80px;display:none;background-color:blue;"></div>

</body>
</html>
