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
<form name="myform" id="myform" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cmd" id="cmd">
	<input type="hidden" name="seq" id="seq" value="<%=seq%>">
	
<!-- 메뉴 -->

<%@include file="/include/navbar.jsp" %>


<div class="container mt-3">
  <h3>게시판</h3>
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
        	 	<input type="hidden" name="writer" id="writer"
        	 	 value="<%=session.getAttribute("user_id")%>"
        	 	>
			    <input type="text" class="form-control" placeholder="이름을 입력하세요"
			    name="user_name" id="user_name" readonly 
			    value="<%=session.getAttribute("user_name")%>" >
			    
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
      
       <tr>
        <th>이미지</td>
        <td>
        	 <div class="input-group">
			    <input type="file" class="form-control" 
			    placeholder="이미지를 선택하세요"
			    name="image" id="image">
			 </div>
        </td>
      </tr>
    </tbody>
  </table>
 </div>


 <div class="container" style="text-align:right">
	<button type="button" class="btn text-white"
	id="btnSave" style="background-color:skyblue">저장</button>
 </div>

 </form>
  
</body>
</html>
<script>
$(()=>{
	$("#btnSave").click(()=>{
		
		//url, data:{user_id:"test", passwor:"1234"}
		//서버로 전송할 파라미터를 읽어와서  data를 만들어준다 
		//1.직렬화 : 객체를 네트워크나 파일로 그대로 전송하는 기술
		//2.FormData  객체를 사용
		
		
		$("#cmd").val("save2"); //ajax통신에 맞춰서
		
		//serialize 이 함수는 id로 접근한다. 그래서 태그에 id가 있어야 한다 
		//파일첨부는 안된다. 
		//let param = $("#myform").serialize();
		//console.log( param );
		 
		//$("#myform") - 객체 배열
		//const formData = new FormData( $("#myform")[0]);
		//console.log(formData);  //키값하고 값의 형태로 저장한다 
		
		const formData = new FormData( document.myform );
		console.log(formData);  //키값하고 값의 형태로 저장한다 
		//keys() 함수는 키값만 배열형태로 가져온다 
		//of  개체배열로 부터 개체를 하나씩 가져오는 연산자
		for(key of formData.keys())
		{
			console.log(key, formData.get(key));
		}
		
		
		
		$.ajax({
			url:"<%=CONTEXT%>/gallery.do",
			data:formData,
			dataType:"JSON",     //받아올 데이터 타입이 json이다. 
			type:"POST",         //파일전송이라 반드시 POST  로
			enctype:"multipart/form-data", //파일전송방식으로 보낸다는 의미임
			processData:false,
			contentType:false
		})
		.done( (response)=>{
			console.log(response);
			if(response.result=="success")
			{
				alert("글이 등록되었습니다");	
				location.href="<%=CONTEXT%>/gallery.do?cmd=list&pg=0";
			}
		})
		.fail( (response, status, error)=>{
			console.log( status );
		})
	})
})
</script>





