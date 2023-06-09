<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
	* {margin:0;}
	.navdiv {width:100%; background-color:gray; position: fixed;}
	nav {background-color:gray; width:1000px;}
	nav ul {list-style:none; display:flex; justify-content:end;}
	nav ul li {padding:25px;}
	
	nav ul li a {text-decoration:none; color:white;}
	nav ul li a:hover{
		color:black;
		transition:all 0.25s;
		padding-bottom:3px;
	}
	.content{margin-top:50px;}
	#logout{margin-left:100px; font-size:12px; color:black;}

</style>

</head>
<body>
	<div class="navdiv">
		<nav>
			<ul>
			 	<li>
			 		<a href="${contextPath }/main">HOME</a>
			 	</li>
			 	<li>
				 	<a href="${contextPath }/board/boardList">BOARD</a>
			 	</li>
			 	<li>
			 		<a href="${contextPath }/member/myPage">MYPAGE</a>
			 	</li>
			 	<li>
			 		<a href="${contextPath }/like/receiveList">LIKELIST</a>
			 	</li>
			 	<li>
			 		<a href="#">CHAT</a>
			 	</li>
			 	<li id="logout">
			 		<p align="right"><a href="${contextPath }/member/logout">logout</a></p>
			 	</li>
			</ul>
		</nav>
	</div>
</body>
</html>