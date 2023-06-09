<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var validateMemberId = false;

	$().ready(function() {
		
		$("#btnOverlapped").click(function(){
			
		    var memberId = $("#memberId").val();
		    if (memberId == ''){
		   		alert("ID를 입력하세요");
		   		return;
		    }
		   
		    $.ajax({
		       type : "post",
		       url : "${contextPath}/member/overlapped",
		       data : {"id" : memberId},
		       success : function(isOverLapped){
		          if (isOverLapped == "false"){
		          	alert("사용할 수 있는 ID입니다.");
		          	validateMemberId = true;
		          }
		          else {
		          	alert("사용할 수 없는 ID입니다.");
		          	validateMemberId = false;
		          }
		       }
		    });
		});	
		
	});
	
	function checkValidationField() {
		if (!validateMemberId) {
			alert("아이디를 확인해주세요.");
			return false;
		}
		else if (memberPw.value == "") {
			alert("비밀번호는 필수 항목입니다.");
			return false;
		}
	}
</script>
<script>
	function pwdChk() {
		var pwd1 = document.getElementById("memberPw");
		var pwd2 = document.getElementById("pwd2");
		var label = document.getElementById("label");
		
		console.log(pwd1);
		console.log(pwd2);
		
		if(pwd1.value != pwd2.value) {
			label.innerHTML = "비밀번호가 일치하지 않습니다."
			pwd2.value = ""
			pwd2.focus()
		} else {
			label.innerHTML = ""
		}
	}
</script>
<script>
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {

	        	var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            if (data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            if (extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            if (fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	
	            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('roadAddress').value = fullRoadAddr;
	            document.getElementById('numberAddress').value = data.jibunAddress;
	
	        }
	    }).open();
	}
</script>
<script>
	function readURL(input){
		var file = input.files[0]	
		if(file != ''){
			var reader = new FileReader();	
			reader.readAsDataURL(file);		
			reader.onload = function(e){
				document.getElementById("preview").src = e.target.result
			}
		}
	}
</script>
<title>join</title>
</head>
<body>
	<form action="${contextPath}/member/join" enctype="multipart/form-data" method="post" onsubmit="return checkValidationField()">
		<h3>회원가입</h3>
		<table border="1">
			<tr>
				<td>프로필</td>
				<td>
					<img src="#" id="preview" width="150px" height="150px">
					<input type="file" onchange="readURL(this)" name="file"><br>
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
		            <input type="text" name="memberId" id="memberId" maxlength="15" placeholder="아이디를 입력하세요." />&emsp;
		            <input type="button" id="btnOverlapped" value="중복확인" />
		        </td>
		    </tr>
	        <tr>
		        <td>비밀번호</td>
		        <td><input type="password" name="memberPw" id="memberPw" placeholder="비밀번호를 입력하세요." /></td>
	        </tr>
	        <tr>
	        	<td>비밀번호 확인</td>
	        	<td><input type="password" id="pwd2" onchange="pwdChk()" placeholder="비밀번호 확인" ><label id="label" style="color:red;"></label><br></td>
	        </tr>             
		    <tr>
		        <td>성별</td>
		        <td>
		        	<input type="radio" name="memberGender" value="male" checked /> 남성&emsp;&emsp;&emsp;
					<input type="radio" name="memberGender" value="female" />여성
		        </td>
	        </tr>
	        <tr>
	        	<td>키</td>
	        	<td>
	        		<select name="memberHeight" >
						<c:forEach var="height" begin="100" end="200">
							<option value="${height}" selected>${height}</option>
						</c:forEach>
					</select> cm
				</td>
	        </tr>                             
	        <tr>
		        <td>생년월일</td>
		        <td>
	                <select name="memberBirthY" >
						<c:forEach var="year" begin="1" end="100">
							<option value="${1922 + year}" selected>${1922 + year}</option>
						</c:forEach>
					</select> 년 
					<select name="memberBirthM">
					  	<c:forEach var="month" begin="1" end="12">
						   <option value="${month}">${month }</option>
					  	</c:forEach>
					</select> 월  
					<select name="memberBirthD">
						<c:forEach var="day" begin="1" end="31">
							<option value="${day}" selected>${day}</option>
						</c:forEach>
					</select> 일 &emsp;
		        </td>
	        </tr>                        
	        <tr>
		        <td>핸드폰 번호</td>
		        <td>
		        	<select name="hp1" >
						<option>없음</option>
						<option selected value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
					</select> - 
					<input size="10px" type="text" name="hp2"> - 
					<input size="10px" type="text" name="hp3">
					<input id="smsstsYn" type="checkbox" name="smsstsYn"  value="Y" checked/>
	                스프링에서 발송하는 SMS 소식을 수신합니다.
		        </td>
	        </tr>                         
	        <tr>
		        <td>이메일</td>
		        <td>
		        	<input type="email" name="email" >  
	                <input id="emailstsYn" type="checkbox" name="emailstsYn" value="Y" checked/>
	                스프링에서 발송하는 E-mail을 수신합니다.
		        </td>
	        </tr>                              
	        <tr>
		        <td>주소</td>
		        <td>
		        	<input type="text" placeholder="우편번호 입력" id="zipcode" name="zipcode" >
	                <input type="button" onclick="javascript:execDaumPostcode()" value="검색">
	                <br> <br>
	                도로명 주소 : <input type="text" name="roadAddress" id="roadAddress"> <br>
					지번 주소 : <input type="text"  name="numberAddress" id="numberAddress"> <br>
					나머지 주소: <input type="text" name="remainAddress" id="remainAddress"/>
		        </td>
	        </tr>                                    
	        <tr>
		        <td colspan="2" align="center">
		        	<input type="submit" value="회원가입하기"  >
		        </td>
		    </tr>
		    <tr>
		        <td colspan="2" align="center">
		        	이미 회원가입이 되어있다면 ? <a href="${contextPath}/member/login"><strong>로그인하기</strong></a>
		        </td>
	        </tr>                            
	     </table>
     </form>
</body>
</html>