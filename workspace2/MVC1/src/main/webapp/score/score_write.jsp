<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.kosa.mvc1.score.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scoreWrite</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>

<%
//forward  로 페이지 이동이 되면 이전 페이지에서 받았던 파라미터도 가져온다 
String cmd=request.getParameter("cmd");
String seq=request.getParameter("seq");
ScoreDto dto = (ScoreDto)request.getAttribute("dto");
if(dto==null) //cmd=list -> cmd=write 로 온경우에는  dto 가 없다.
{
	dto=new ScoreDto(); //비어있는 개체를 하나 만든다. 
}
%>

<form name="myform" method="post">
	<input type="hidden" name="cmd">
	<input type="hidden" name="seq" value="<%=seq%>">

<%@include file="/include/navbar.jsp" %>

<div class="container mt-3">
  <h3>성적등록</h3>
  <p></p>
  

   <table class="table">
   	<colgroup>
   		<col width="30%">
   		<col width="*">
   	</colgroup>
    <tbody>
      <tr>
        <th>이름</td>
        <td>
        	 <div class="input-group">
        	
			    <input type="text" class="form-control" placeholder="이름을 입력하세요"
			    name="name" id="name" value="<%=dto.getName()%>">
			 </div>
        </td>
      </tr>
      <tr>
        <th>국어</td>
        <td>
        	 <div class="input-group">
			    <input type="text" class="form-control" placeholder="국어점수를 입력하세요"
			    name="kor" id="kor" value="<%=dto.getKor()%>" >
			 </div>
        </td>
      </tr>
      
      <tr>
        <th>영어</td>
        <td>
        	 <div class="input-group">
			    <input type="text" class="form-control" placeholder="영어점수를 입력하세요"
			    name="eng" id="eng" value="<%=dto.getEng()%>" >
			 </div>
        </td>
      </tr>
      
      <tr>
        <th>수학</td>
        <td>
        	 <div class="input-group">
			    <input type="text" class="form-control" placeholder="수학점수를 입력하세요"
			    name="mat" id="mat" value="<%=dto.getMat()%>" >
			 </div>
        </td>
      </tr>

      
    </tbody>
  </table>
 </div>


 <div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark"
	id="btnSave">저장</button>
 </div>

 </form>
  
</body>
</html>
<script>
window.onload=()=>{
	let btnSave = document.getElementById("btnSave");
	btnSave.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/score.do";
		<%if(cmd.equals("write")){%>
		frm.cmd.value="save";
		<%}else{%>
		frm.cmd.value="update";
		<%}%> 
		frm.submit();
	})
}
</script>
