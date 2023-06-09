<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<script src="${contextPath }/resources/jquery/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("form").submit(function(){
			
			if ($("#title").val() == ""){
				alert("제목을 입력하세요.");
				$("#title").focus();
				return false;
			}

			var checkY = confirm("등록하시겠습니까?");
			if (checkY) {
				return true;
			}
					
		});
		
	});
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
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	<br><br>
	<div class="content" align="center" style="padding-top: 100px">
		<form action="${contextPath}/board/write" enctype="multipart/form-data" method="post" >
			<div align="center">
				<h2>게시글 쓰기</h2>
				<br>
			</div>
			<table border="1" style="width:600px;" >
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<tr>
					<td align="center">제목</td>
					<td><input type="text" id="title" name="title" size="70"/></td>
				</tr>
				<tr>
					<td align="center">파일첨부</td>
					<td>
						<img src="#" id="preview" width="150px" height="150px">
						<input type="file" onchange="readURL(this)" name="file">
					</td>
				</tr>
				<tr>
					<td align="center">글내용</td>
					<td><textarea  rows="10" cols="50" name="content" ></textarea></td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<input type="submit" value="글쓰기" />
						<input type="reset"  value="다시작성" />
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>