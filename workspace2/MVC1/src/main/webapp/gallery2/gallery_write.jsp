<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.kosa.mvc1.guestbook.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
</head>
<body>

<%
//forward  로 페이지 이동이 되면 이전 페이지에서 받았던 파라미터도 가져온다 
String cmd=request.getParameter("cmd");
String seq=request.getParameter("seq");
GuestbookDto dto = (GuestbookDto)request.getAttribute("dto");
if(dto==null) //cmd=list -> cmd=write 로 온경우에는  dto 가 없다.
{
	dto=new GuestbookDto(); //비어있는 개체를 하나 만든다. 
}
%>

<form name="myform" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cmd">
	<input type="hidden" name="seq" value="<%=seq%>">
<!-- 메뉴 -->

<%@include file="/include/navbar.jsp" %>


<div class="container mt-3">
  <h3></h3>
  <p></p>
  

   <table class="table">
   	<colgroup>
   		<col width="30%">
   		<col width="*">
   	</colgroup>
    <tbody>
      <tr>
        <th>제목</td>
        <td>
        	 <div class="input-group">
        	
			    <input type="text" class="form-control" placeholder="제목을 입력하세요"
			    name="title" id="title" value="<%=dto.getTitle()%>">
			 </div>
        </td>
      </tr>
      <tr>
        <th>작성자</td>
        <td>
        	 <div class="input-group">
        	 	<input type="hidden" name="writer" id="writer" value="<%=session.getAttribute("user_id")%>">
			    <input type="text" class="form-control" placeholder="이름을 입력하세요"
			    name="user_name" id="user_name" value="<%=session.getAttribute("user_name")%>"> 
			 </div>
        </td>
      </tr>
      <tr>
        <th>내용</td>
        <td>
        	 <div class="input-group">
			    <textarea class="form-control" placeholder="내용 입력하세요"
			    name="contents" id="contents" rows="5"><%=dto.getContents()%></textarea>
			 </div>
        </td>
      </tr>
      <th>이미지</td>
        <td>
        	 <div class="input-group">
			    <input type="file" class="form-control" placeholder="이미지를 선택하세요" name="image" id="image">
			 </div>
        </td>
      </tr>
      
    </tbody>
  </table>
 </div>


 <div class="container" style="text-align:right">
	<button type="button" class="btn text-white" id="btnSave" style="background-color:pink">저장</button>
 </div>

 </form>
  
</body>
</html>
<script>
window.onload=()=>{
	let btnSave = document.getElementById("btnSave");
	btnSave.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/gallery.do";
		<%if(cmd.equals("write")){%>
		frm.cmd.value="save";
		<%}else{%>
		frm.cmd.value="update";
		<%}%> 
		frm.submit();
	})
}
</script>
