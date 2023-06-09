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
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {

	        	var fullRoadAddr = data.roadAddress;
	            var extraRoadAddr = ''; 
	
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
	
	            document.getElementById('zipcode').value = data.zonecode;
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
<title>update</title>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<form class="content" action="${contextPath}/member/update" enctype="multipart/form-data" method="post">
		<table border="1">
			<tr>
				<td>프로필</td>
				<td>
					<img src="${contextPath }/member/profile?fileName=${memberDto.profileImage }" id="preview" width="150px" height="150px">
					<input type="file" onchange="readURL(this)" name="file"><br>
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
		            <input type="text" name="memberId" id="memberId" maxlength="15" value="${memberDto.memberId }" readonly />&emsp;
		        </td>
		    </tr>
	        <tr>
		        <td>비밀번호 확인</td>
		        <td><input type="password" name="memberPw" placeholder="비밀번호를 입력하세요." /></td>
	        </tr>                
		    <tr>
		        <td>성별</td>
		        <td>
		        	<c:choose>
		        		<c:when test="${memberDto.memberGender eq 'male'}">
				        	<input type="radio" name="memberGender" value="male" checked /> 남성&emsp;&emsp;&emsp;
							<input type="radio" name="memberGender" value="female" />여성
						</c:when>
						<c:otherwise>
							<input type="radio" name="memberGender" value="male" /> 남성&emsp;&emsp;&emsp;
							<input type="radio" name="memberGender" value="female" checked />여성
						</c:otherwise> 
		        	</c:choose>
		        </td>
	        </tr>
	        <tr>
	        	<td>키</td>
	        	<td>
	        		<select name="memberHeight" >
						<c:forEach var="height" begin="100" end="200">
							<option value="${height}" <c:if test="${memberDto.memberHeight eq height }"> selected </c:if>>${height}</option>
						</c:forEach>
					</select> cm
				</td>
	        </tr>                             
	        <tr>
		        <td>생년월일</td>
		        <td>
	                <select name="memberBirthY" >
						<c:forEach var="year" begin="1" end="100">
							<option value="${1922+year}" <c:if test="${memberDto.memberBirthY eq 1922+year}"> selected </c:if>>${ 1922+year}</option>
						</c:forEach>
					</select> 년 
					<select name="memberBirthM">
					  	<c:forEach var="month" begin="1" end="12">
						   <option value="${month}" <c:if test="${memberDto.memberBirthM eq month}"> selected </c:if>>${month }</option>
					  	</c:forEach>
					</select> 월  
					<select name="memberBirthD">
						<c:forEach var="day" begin="1" end="31">
							<option value="${day}" <c:if test="${memberDto.memberBirthD eq day}"> selected </c:if>>${day}</option>
						</c:forEach>
					</select> 일 &emsp;
		        </td>
	        </tr>                        
	        <tr>
		        <td>핸드폰 번호</td>
		        <td>
		        	<select name="hp1" >
						<option>없음</option>
						<option <c:if test="${memberDto.hp1 eq '010' }"> selected </c:if> value="010">010</option>
						<option <c:if test="${memberDto.hp1 eq '011' }"> selected </c:if> value="011">011</option>
						<option <c:if test="${memberDto.hp1 eq '019' }"> selected </c:if> value="019">019</option>
					</select> - 
					<input size="10px" type="text" name="hp2" value="${memberDto.hp2}"> - 
					<input size="10px" type="text" name="hp3" value="${memberDto.hp3}">
					<input id="smsstsYn" type="checkbox" name="smsstsYn" <c:if test="${memberDto.smsstsYn == 'y'}"> checked</c:if>/>
	                스프링에서 발송하는 SMS 소식을 수신합니다.
		        </td>
	        </tr>                         
	        <tr>
		        <td>이메일</td>
		        <td>
		        	<input type="email" name="email" value="${memberDto.email}">  
	                <input id="emailstsYn" type="checkbox" name="emailstsYn" <c:if test="${memberDto.emailstsYn == 'y'}"> checked</c:if>/>
	                스프링에서 발송하는 E-mail을 수신합니다.
		        </td>
	        </tr>                              
	        <tr>
		        <td>주소</td>
		        <td>
		        	<input type="text" placeholder="우편번호 입력" name="zipcode" value="${memberDto.zipcode }" >
	                <input type="button" onclick="javascript:execDaumPostcode()" value="검색">
	                <br><br><br>
	                도로명 주소 : <input type="text" name="roadAddress" id="roadAddress" value="${memberDto.roadAddress }"> <br>
					지번 주소 : <input type="text"  name="numberAddress" id="numberAddress" value="${memberDto.numberAddress }"> <br>
					나머지 주소: <input type="text" name="remainAddress" id="remainAddress" value="${memberDto.remainAddress }"/>
		        </td>
	        </tr>                                    
	        <tr>
		        <td colspan="2" align="center">
		        	<input type="submit" value="수정하기"  >
		        </td>
		    </tr>                    
	     </table>
     </form>

</body>
</html>