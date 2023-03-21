<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kosa.mvc1.gallery.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
String seq = request.getParameter("seq");
%>
<form name="myform">
	<input type="hidden" name="seq" value="<%=seq%>">
	<input type="hidden" name="cmd">
	
<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3>Photo</h3>
  <p></p>
  
  <table class="table">
  <colgroup>
  	<col width="15%">
  	<col width="18%">
  	<col width="15%">
  	<col width="18%">
  	<col width="15%">
  	<col width="18%">
  </colgroup>
    <tbody>
    <%
    GalleryDto dto = (GalleryDto)request.getAttribute("dto");	
    %>
    <tr>
      <th>제목</td>
      <td colspan="5"><%=dto.getTitle()%></td>
      </tr>
      
      <tr>
      <th>작성자</td>
      <td><%=dto.getUser_name()%></td>
      <th>작성일</td>
      <td><%=dto.getWdate()%></td>
      <th>조회수</td>
      <td><%=dto.getHit()%></td>
      </tr>
      
      <tr>
      <th>내용</td>
      <td colspan="5" style="word-break:break-all"><%=dto.getContents().replace("\n", "<br/>")%></td>
      </tr>
      
      <tr>
      <th>이미지</td>
      <td><%=dto.getImage()%></td>
      <td colspan="6">
      <img 
      	src="<%=CONTEXT%>/upload/gallery/<%=dto.getImage()%>"
      	alt = "<%=dto.getTitle() %>" style=" width:50% ">
      	</td>
      </tr>
    </tbody>
  </table>
</div>

<div class="container" style="text-align:right">
	<button type="button" class="btn btn-dark" id="btnList">목록</button>&nbsp;&nbsp;
	<!--  세션에서 널을 가져올경우 호출 못함, equals 호출 여부를 따지기 위해 -->
	<%if(dto.getWriter().equals(session.getAttribute("user_id"))){ %>
	<button type="button" class="btn btn-dark" id="btnModify">수정</button>&nbsp;&nbsp;
	<button type="button" class="btn btn-dark" id="btnDelete">삭제</button>
	<%} %>
</div>

</form>
</body>
</html>

<script>
window.onload=()=>{
	let btnList = document.getElementById("btnList"); 
	btnList.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/gallery.do";
		frm.cmd.value="list";
		frm.submit();
	});
	
	<%if(dto.getWriter().equals(session.getAttribute("user_id"))){ %>
	let btnModify = document.getElementById("btnModify");
	btnModify.addEventListener("click", ()=>{
		var frm = document.myform;
		frm.action="<%=CONTEXT%>/gallery.do";
		frm.cmd.value="modify";
		frm.submit();
	});
	<%}%>
	
}
</script>


