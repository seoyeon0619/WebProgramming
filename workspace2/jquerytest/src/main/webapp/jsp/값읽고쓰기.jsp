<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>
<body>
<form id="myform" name="myform">
	<input type="hidden" name="seq" id="seq"></br/>
	이름 : <input type="text" name="username" ></br/>
	이메일 : <input type="text" name="email" ></br/>
	
	나이:<br/>
		<input type="radio" name="age" value="10"> 10대
		<input type="radio" name="age" value="20"> 20대
		<input type="radio" name="age" value="30"> 30대
		<input type="radio" name="age" value="40"> 40대
		<input type="radio" name="age" value="50"> 50대
		<input type="radio" name="age" value="60"> 60대 
	<br/><br/>
	
	관심분야<br/>
		<input type="checkbox" name="interest" value="1"> 프로그래밍
		<input type="checkbox" name="interest" value="2"> 웹프로그래밍
		<input type="checkbox" name="interest" value="3"> 데이터베이스
		<input type="checkbox" name="interest" value="4"> 빅데이터
		<input type="checkbox" name="interest" value="5"> 머신러닝
		<input type="checkbox" name="interest" value="6"> 딥러닝<br/>
	
	좋아하는색<br/>
	<select name="color">
		<option value="">==선택하세요==</option>
		<option value="red">red</option>
		<option value="green">green</option>
		<option value="blue">blue</option>
		<option value="cyan">cyan</option>
		<option value="magenta">magenta</option>
	</select>
	
	<br/><br/>
	<textarea name="intro" cols="30" rows="10"></textarea>	
	 <br/><br/>	
	<button id="btnRegister" type="button">등록</button>
	
</form>
</body>
</html>

<script>
$(()=>{
	//name 속성을 이용해 값을 넣기 
	$("input[type=hidden][name=seq]").val(10);
	$("input[type=text][name=username]").val("홍길동");
	$("input[type=text][name=email]").val("hong@ddd.com");
	
	$("input[type=radio][name=age]").eq(1).prop("checked", true);
	
	$("input[type=checkbox][name=interest]").eq(0).prop("checked", true);
	$("input[type=checkbox][name=interest]").eq(2).prop("checked", true);

	$("select[name=color]").val("blue");
	$("textarea[name=intro]").val("자기소개입니다.\n저는 긍정적이고 ~");
	
	
	$("#btnRegister").click(()=>{
		
		console.log( $("input[type=hidden][name=seq]").val()) ;
		console.log($("input[type=text][name=username]").val());
		console.log($("input[type=text][name=email]").val());
		
		//선택된 항목의 값 출력하기 
		console.log( $("input[type=radio][name=age]:checked").val());
		
		//checkbox는 선택된 항목이 배열로 온다. 그래서 변수하나두고 값을 모아
		//와야 한다 
		let interest="";
		$("input[type=radio][name=interest]:checked").each( function(){
			 interest += $(this).val()+",";
		});
		console.log( $("select[name=color]").val());	
		console.log($("textarea[name=intro]").val());
	
	});
	
});

</script>








