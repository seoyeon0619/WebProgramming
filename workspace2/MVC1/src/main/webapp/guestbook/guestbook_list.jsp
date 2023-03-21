<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.kosa.mvc1.guestbook.*" %>
<%@ page import="com.kosa.mvc1.common.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<%
String pg=request.getParameter("pg");
String searchOpt=request.getParameter("searchOpt");
String searchKey=request.getParameter("searchKey");
if(pg==null || pg.equals(""))
	pg="0";
if(searchOpt==null) searchOpt="";
if(searchKey==null) searchKey="";

%>
<form name="myform">
	<input type="hidden" name="cmd" id="cmd"/>
	<input type="hidden" name="pg" id="pg"/>
	<input type="hidden" name="searchOpt" id="searchOpt"/>
	
<%@include file="/include/navbar.jsp" %>

<div class="container mt-3">
  <h3 style="color:pink">GuestBook</h3>
  <p></p>
  
  <div class="input-group mt-3 mb-3">
    <button type="button" class="btn dropdown-toggle text-white" data-bs-toggle="dropdown" style="background-color:pink">
      <span id="select">Select</span>
    </button>
    
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#none" onclick="goSelect('1')">Title</a></li>
      <li><a class="dropdown-item" href="#none" onclick="goSelect('2')">Contents</a></li>
      <li><a class="dropdown-item" href="#none" onclick="goSelect('3')">Title + Contents</a></li>
    </ul>
    
    <input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchKey" id="searchKey" value="<%=searchKey%>">
    <div class="input-group-append">
    	<button class="btn text-white" type="button" onclick="goSearch()" style="background-color:pink">Search</button>
    </div>
  </div>
  
  <table class="table">
  <colgroup>
  	<col style="width:8%">
  	<col style="width:*%">
  	<col style="width:12%">
  	<col style="width:14%">
  	<col style="width:12%">
  </colgroup>
  
    <thead class="table-dark">
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
    </thead>
    
    <tbody>
    <%
    int totalCnt = (int)request.getAttribute("totalCnt");
    List<GuestbookDto> list = (List<GuestbookDto>)request.getAttribute("list");
    
    // 다운 캐스팅
    for(GuestbookDto dto : list) {
    	String url = CONTEXT+"/guestbook.do?cmd=view&seq="+dto.getSeq();
    %>
      <tr>
        <td><%=totalCnt-dto.getRnum()+1%></td>
        <td><a href="<%=url%>"><%=dto.getTitle()%></a></td>
        <td><%=dto.getUser_name()%></td>
        <td><%=dto.getWdate()%></td>
        <td><%=dto.getHit()%></td>
      </tr>
      <%} %>
    </tbody>
  </table>
</div>
  
  <div class="container" style="text-align:center" >
  <%=Pager.makeTag(request, totalCnt, 10) %>
 </div>

<div class="container" style="text-align:right">
	<button type="button" class="btn text-white" id="btnWrite" style="background-color:pink">글쓰기</button>
</div>
</form>
</body>
</html>
<script>
let titles=["Select", "Title", "Contents", "Title + Contents"];

window.onload=()=>{
	// 자바스크립트에서 자바코드 사용 가능
	let sel = '<%=searchOpt%>';
	console.log(sel);
	if(sel=="")
		$("#select").html(titles[0]);
	else
		$("#select").html(titles[sel]);
	
	let btnWrite = document.getElementById("btnWrite");
	btnWrite.addEventListener("click", ()=>{
		
		// 로그인안하면 글쓰기를 못하도록
		let user_id = '<%=session.getAttribute("user_id")%>';
		console.log( user_id);
		if( user_id=="null" || user_id=="")
		{
			alert("로그온을하세요")	;
			//로그온 페이지로 이동하기 
			location.href="<%=CONTEXT%>/member.do?cmd=member_logon";
			return;
		}
		
		let frm = document.myform;
		frm.action = "<%=CONTEXT%>/guestbook.do";
		frm.cmd.value = "write";
		frm.submit();
	})
}

function goPage(page)
{
	var frm = document.myform;
	frm.pg.value = page; // 필요한 파라미터 모두 값 넣기
	frm.cmd.value="list";
	frm.action="<%=CONTEXT%>/guestbook.do";
	frm.submit();
}

function goSelect(sel)
{
	// li태그는 value가 없으므로 hidden태그에 값을 저장
	$("#searchOpt").val(sel);
	let titles = ["", "Title", "Contents", "Title + Contents"];
	$("#select").html(titles[sel]);
	
}

function goSearch()
{
	var frm = document.myform;
	// 현재 페이지 정보가 32페이지일 때, 페이지는 첫번째 페이지로 이동 
	frm.pg.value = 0; 
	frm.cmd.value="list";
	frm.action="<%=CONTEXT%>/guestbook.do";
	frm.submit();
}
</script>


