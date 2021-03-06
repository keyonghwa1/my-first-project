﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<!DOCTYPE html>
<html>
	<link rel="stylesheet" type="text/css" href="../css/reset.css">
	<link rel="stylesheet" type="text/css" href="../css/member_insert_form.css">
	<link rel="stylesheet" href="../css/index.css"/>
		
	<head>
		<meta charset="UTF-8">
		<title>회원가입 페이지</title>
	
		<script src="../js/httpRequest.js"></script>
			
		<script>
			var b_idCheck = false;
		
			function send( f ){
				
				var id = f.id.value.trim();
				var pwd = f.pwd.value.trim();
				var name = f.name.value.trim();
				var phone = f.phone.value.trim();
				
				//유효성 체크
				if( !b_idCheck ){
					alert("아이디 중복체크를 먼저 하세요");
					return;
				}			
				
				f.action = "member_insert.korea";
				f.method = "POST";
				f.submit();
				
			} //send()
			
			function check_id(){
				
				var id = document.getElementById("id").value.trim();
				
				if( id == '' ){
					alert("아이디를 입력하세요");
					return;
				}
				
				//id를 Ajax를 통해서 서버로 전송
				var url = "check_id.korea";
				
				//id에 @#와 같은 특수문자가 포함되어 있는 경우를 대비하여 인코딩하여 보낸다.
				var param = "id=" + encodeURIComponent(id);
				
				sendRequest(url, param, resultFn, "GET");
				
			}//check_id()
			
			function resultFn(){
				
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					//도착한 데이터를 읽는다.
					var data = xhr.responseText;
					
					//도착한 데이터를 JSON표기법으로 파싱
					var json = eval( data );
					
					if( json[0].result == 'no' ){
						alert( json[1].id + "은 이미 사용중인 아이디 입니다." );
						return;
					}
					
					alert( json[1].id + "는 사용 가능한 아이디 입니다." );
					
					b_idCheck = true;
					
					//사용 가능한 아이디라는것이 판별 되었으면, 더이상 변경이 불가능하도록 비활성화 처리
					document.getElementById("id").readOnly = true;
				}
				
			}//resultFn()
			
			
		</script>	
	</head>

	<body>
		
		<form>	
			<table>
				
				<caption>:::회원가입:::</caption>
				
				<tr>
					<th>아이디</th>
					<td>
						<input name="id" id="id">
						<input class="btnoverlap" type="button" value="중복체크" onclick="check_id();">
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd">
					</td>
				</tr>
				
				<tr>
					<th>이름</th>
					<td>
						<input name="name">
					</td>
				</tr>
				
				<tr>
					<th>전화번호</th>
					<td>
						<input name="phone">
					</td>
				</tr>
				
				<tr class="btn">
					<td colspan="2">
						<input class="btncom" type="button" value="가입하기" onclick="send( this.form );">
						<input class="btncom btnreset" type="button" value="되돌아가기" onclick="location.href='member_login.jsp'">
					</td>
				</tr>
			</table>
			
		</form>
		
	</body>


</html>






