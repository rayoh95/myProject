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
<title>receiveList</title>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<div class="content" align="center">
		<c:choose>
			<c:when test="${empty likeReceiveList}">
				<tr>
					<td colspan="5"><strong>좋아요를 보낸 이성이 없습니다.</strong></td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="memberDto" items="${likeReceiveList}">
					<a href="${contextPath }/member/info?memberId=${memberDto.memberId}"><img src="${contextPath }/member/profile?fileName=${memberDto.profileImage }" /></a><br>
					<a href="${contextPath }/member/info?memberId=${memberDto.memberId}">${memberDto.memberId}</a><br>
					${memberDto.memberHeight } cm<br>
					가입일 : <fmt:formatDate value="${memberDto.joinDate}" pattern="yyyy-MM-dd" /><br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>