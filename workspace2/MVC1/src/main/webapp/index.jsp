<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.kosa.mvc1.index.*"%>
<%@ page import = "com.kosa.mvc1.guestbook.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script></head>

<body>
<%
String seq = request.getParameter("seq");
%>
<% 
List<IndexDto> list = (List<IndexDto>)request.getAttribute("list"); 
%>
<form name="myform">
	<input type="hidden" name="seq" value="<%=seq%>">
<div class="container"> 
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
	<%for(int i=0; i<list.size(); i++) {%>
	 	<li data-target="#myCarousel" data-slide-to="<%=i%>"
	 	<%if (i==0){%>class="active" <%}%>></li>
	<%}%>
    </ol>


    <!-- Wrapper for slides -->
    <div class="carousel-inner">
 <%for(int i=0; i<list.size(); i++) {
	 String activeClass="";
	 IndexDto dto = list.get(i);
	 if(i==0)
		 activeClass = "item active";
	 else
		 activeClass = "item";
	 
	 String url = request.getContextPath()
			 + "/upload/gallery/"
			 + dto.getImage();
	String link = request.getContextPath()+"/gallery.do?cmd=view&seq="
			+dto.getSeq();

 %>
    <div class="<%=activeClass%>">
    <a href="<%=link %>">
   	<img 
    	src="<%=url%>" 
    	alt="<%=dto.getImage()%>" style="width:100%; height:600px">
	</a>
      </div>
<%} %>
    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  
  <div class="container" style="margin-top:15px" >
<%
	List<IndexDto2> guestList = (List<IndexDto2>)request.getAttribute("guestList");
	
	for(int i = 0; i < guestList.size(); i++){
		IndexDto2 dto2 = guestList.get(i);
		
	String link = request.getContextPath()+"/guestbook.do?cmd=view&seq="
				+dto2.getSeq();
%>

<% if(i%3==0) { %>
	  <div class="row">
<%} %>
	    <div class="col-sm-4">
	      <a href="<%=link %>">
	      <h3><%=dto2.getTitle() %></h3>
	      <p><%=dto2.getUser_name() %></p>
	      </a>
	    </div>
<% if(i%3==2 || i==guestList.size()-1) { %>
	    </div>
<%} %>
<%} %>
	  </div>
</div>
</form>
</body>
</html>





