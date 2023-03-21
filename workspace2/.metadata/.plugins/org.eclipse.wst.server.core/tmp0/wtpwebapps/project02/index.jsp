<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.yeon.shop.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>♡ SHOP ♡</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<form name="myform" id="myform">
	<input type="hidden" name="cmd" id="cmd">
	<input type="hidden" name="pg" id="pg">
	
	
<%@include file="/include/navbar.jsp" %>

<div class="container">
	<h1> </h1>
  <h3 style="color:Skyblue">SHOP</h3>
  </div>
  
<%
	List<ShopDto> list = 
	 (List<ShopDto>)request.getAttribute("list");
	int totalCnt = (int)request.getAttribute("totalCnt");

%>

<%
for(int i=0; i<list.size(); i++) {
	ShopDto dto = list.get(i);
	String url = CONTEXT+ "/shop.do?cmd=view&seq="+dto.getSeq();
	
	if(i%4==0){
%>
	<div class="row"> <!-- 이미지 4개당 한번씩 등장해야 한다 -->
<%}%>
	  <div class="col-sm-3">
	    <div class="thumbnail">
	      <a href="<%=url%>">
	        <img 
	        src="<%=CONTEXT%>/upload/gallery/<%=dto.getImage()%>" 
	        alt="<%=dto.getTitle()%>" style="width:60%">
	        <div class="caption">
	          <p><%=dto.getTitle()%></p>
	        </div>
	      </a>
	    </div>
	  </div>
	<%if(i%4==3 || i==list.size()-1) {%>
	<!-- 세 번째까지는 사진 넣고, 네번째에 end row -->
	</div> <!--  end row -->
 <%} 
 }%>

  <div class="container" style="text-align:center">
	<%=Pager.makeTag(request, totalCnt, 12) %>
 </div>

<div class="container" style="text-align:right">
	<button type="button" class="btn text-white" style="background-color:Skyblue" id="btnWrite">상품등록</button>
</div>
</form>
</body>
</html>

<script>
$(()=>{
	$("#btnWrite").click(()=>{
		let frm = $("#myform");
		$("#cmd").val("write");//cmd파라미터에 save 
		frm.prop("action", "<%=CONTEXT%>/shop.do");
		//action속성에 url주는 방식, jquery방식 
		frm.submit();
	})
})

function goPage(page)
{
	var frm = document.myform;
	frm.pg.value = page; //필요한 파라미터들에 모두 값 넣고
	frm.cmd.value="list";
	frm.action="<%=CONTEXT%>/shop.do";
	frm.submit();
}


</script>

    