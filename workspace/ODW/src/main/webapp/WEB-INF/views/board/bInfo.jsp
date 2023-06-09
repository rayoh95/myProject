<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function call_confirm(){
		if(confirm("Are you sure that your gonna delete your post?")){
			location.href="${contextPath }/board/delete?num=${boardDto.num}"
		}else{
			return false;
		}
	}
</script>
<title>info</title>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<div class="content" align="center" style="padding-top: 50px">
		<div align="center">
			<h1>게시글 보기</h1>
			<br>
		</div>
		<table style="width: 700px; text-align: center" border="1">
			<colgroup> 
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tr>
				<td>조회수</td>
				<td>${boardDto.readCount }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${boardDto.writer }</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><fmt:formatDate value="${boardDto.regDate }" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${boardDto.title }</td>
			</tr>
			<tr>
				<td colspan="2">
					<img src="${contextPath }/board/image?fileName=${boardDto.image }" />
				</td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td>${boardDto.content }</td>
			</tr>
			<tr>
				<td colspan="2">
					<c:if test="${loginUser eq boardDto.writer }">
						<input type="button" value="수정하기" onclick="location.href='${contextPath }/board/update?num=${boardDto.num}'">
						<button type="button" onclick="call_confirm()">삭제하기</button>
					</c:if>
					<input type="button" value="목록보기" onclick="location.href='${contextPath }/board/boardList'">
				</td>
			</tr>
		</table>
		
		<br><br>
		
		<!-- 댓글 -->
		<hr><br>
		<label>댓글</label>
		<br><br>
		<div>
			<table style="width: 500px; border-spacing: 0 20px;">
				<colgroup> 
				<col width="20%">
				<col width="60%">
				<col width="15%">
				<col width="5%">
				</colgroup>
				<c:forEach var="replyDto" items="${replyList }">
					<tr>
						<td>${replyDto.writer }</td>
						<td>${replyDto.content }</td>
						<td><fmt:formatDate value="${replyDto.regDate }" pattern="yyyy-MM-dd"/></td>
						<c:if test="${loginUser eq replyDto.writer }">
							<td>
								<a href="${contextPath }/reply/update?num=${replyDto.num }">수정</a>
								<a href="${contextPath }/reply/delete?num=${replyDto.num }&bNum=${replyDto.bNum }">삭제</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="4">
						<form action="${contextPath }/reply/write?bNum=${boardDto.num }" method="post" >
							<p><textarea rows="2" cols="100" name="content"></textarea></p>
							<input type="submit" value="댓글 등록" />
						</form>									
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>