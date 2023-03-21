<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%
// 공통변수변수선언
String CONTEXT=request.getContextPath();
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
   	<a class="navbar-brand" href="<%=CONTEXT%>/index.jsp">
      <img src="<%=CONTEXT%>/images/icon.png" alt="Logo" style="width:40px;" class="rounded-pill">
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      </a><span class="navbar-toggler-icon"></span></a>
    </button>
    
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="<%=CONTEXT%>/guestbook.do?cmd=list&pg=0">SHOP</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=CONTEXT%>/gallery.do?cmd=list&pg=0">MY PAGE</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>  
        
    
    <%if(session.getAttribute("user_id")==null || session.getAttribute("user_id").equals("")){ %>
     <ul class="navbar-nav justify-content-end">
      <li class="nav-item"><a class="nav-link" href="<%=CONTEXT%>/member.do?cmd=member_logon">Login</a></li>
      <li class="nav-item"><a class="nav-link" href="<%=CONTEXT%>/member.do?cmd=member_write">Sign Up</a></li>
     </ul>
    <%}else { %>
     <ul class="navbar-nav justify-content-end">
     	<li class="nav-item"><a class="nav-link" href="#none"><%=session.getAttribute("user_name")%></a></li>
     	<li class="nav-item"><a class="nav-link" href="#none" onclick="goLogout()">Logout</a></li>
     	
     </ul>
     <%} %>
  </div>
</nav>

<script>
function goLogout()
{
let xhttp = new XMLHttpRequest();
let url = "/MVC1/member.do?cmd=logout";

xhttp.onload = function(){
	console.log(this.responseText);
	let data = JSON.parse(this.responseText);
	alert("로그아웃되었습니다");
	location.href="/MVC1/index.jsp";
	}

xhttp.open("GET", url, true);
xhttp.send();
}
</script>