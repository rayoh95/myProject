<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script>	
	function likeAble(id) {
		
		var btnId = "btnLike" + id;
		var likeChk = confirm("will you send like?");
	    
	   	if (likeChk) {
	   		document.getElementById(btnId).style.backgroundColor = "#008CBA";
	   		document.getElementById(btnId).style.color = "white";
    		document.getElementById(btnId).style.cursor = "default";
	   		document.getElementById(btnId).disabled = "disabled";
	    		
	    	$.ajax({
	    		type : "post",
	    		url : "${contextPath}/like/send",
	    		data : {
	    			"likeReceive" : id
	    		},
	    		success : function(){
	    			alert("like sended successfuly.");
	    		}
	    	});
	    }
	}
</script>
<title>info</title>
</head>
<style>
	.button {
		background-color: white;
	 	border: 2px solid #008CBA;
	  	color: black;
	  	padding: 14px 50px;
	  	text-align: center;
	  	text-decoration: none;
	  	display: inline-block;
	  	font-size: 16px;
	  	margin: 4px 4px;
	  	transition-duration: 0.4s;
	  	cursor: pointer;
	}
	.buttonAbled:hover {
  		background-color: #008CBA;
  		color: white;
	}
	.buttonDisabled {
		background-color: #008CBA;
		color: white;
		cursor: default;
	}
</style>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<div class="content" align="center">
		<img src="${contextPath }/member/profile?fileName=${memberDto.profileImage }" /><br>
		${memberDto.memberId }<br>
		${year - memberDto.memberBirthY + 1 } 세<br>
		${memberDto.memberHeight } cm<br>
		${memberDto.roadAddress } ${memberDto.remainAddress }<br>
		<c:choose>
			<c:when test="${send eq 'true'}">
				<button class="button buttonDisabled" disabled>좋아요</button><br>
			</c:when>
			<c:otherwise>
				<button class="button buttonAbled" id="btnLike${memberDto.memberId }" onclick="likeAble('${memberDto.memberId}')">좋아요</button><br>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>