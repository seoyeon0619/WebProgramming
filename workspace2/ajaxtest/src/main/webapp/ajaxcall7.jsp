<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxcall</title>
</head>
<body>
	<h1>Ajax 테스트</h1>
	
	<table style="width:40%; margin:auto">
		<colgroup>
			<col width="33%">
			<col width="33%">
			<col width="33%">
		</colgroup>
		<thead>
			<tr>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody id="tbody"></tbody>
	</table>

	<div id="result"></div>
	
	<button type="button" onclick="loadDoc()">JSON결과받아오기</button>
</body>
</html>
<script>
function loadDoc()
{
	let xhttp = new XMLHttpRequest(); 	
	
	xhttp.onload=function(){
		// String -> Json 객체로 전황
		data = JSON.parse(this.responseText);
		let tbody = document.getElementById("tbody");
		
		// 배열의 요소마다 호출
		deleteAll(); // 기존의 데이터 모두 삭제		
		data.forEach( (item)=>{
			let row = tbody.insertRow( tbody.rows.length);
			// 테이블의 마지막 행 추가
			let cell1 = row.insertCell(0); // 0번 칼럼추가
			let cell2 = row.insertCell(1); // 1번 칼럼추가
			let cell3 = row.insertCell(2); // 1번 칼럼추가
			
			cell1.innerHTML = item.username;
			cell2.innerHTML = item.email;
			cell3.innerHTML = item.phone;
		});
	}
	
	let url = "/ajaxtest/person.do"; 
	console.log(url);
			
	xhttp.open("GET", url, true);
	
	xhttp.send(); 
}

function deleteAll()
{
	let tbody = document.getElementById("tbody");
	for(i=tbody.rows.length-1; i>=0; i--)
		{
		tbody.deleteRow(i);
		}
}
</script>