<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function call_confirm(){
		if(confirm("Are you sure that your gonna delete your account?")){
			location.href="${contextPath }/member/delete"
		}else{
			return false;
		}
	}
</script>
<title>myPage</title>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<div class="content" align="center">
		<img src="${contextPath }/member/profile?fileName=${memberDto.profileImage }" /><br>
		${memberDto.memberId }<br>
		${year - memberDto.memberBirthY + 1 } 세<br>
		${memberDto.memberHeight } cm<br>
		${memberDto.roadAddress } ${memberDto.remainAddress }<br>
		<button type="button" onclick="location.href='${contextPath}/member/update'">프로필 수정</button>
		<button type="button" onclick="call_confirm()">회원탈퇴</button>
	</div>
</body>
</html>