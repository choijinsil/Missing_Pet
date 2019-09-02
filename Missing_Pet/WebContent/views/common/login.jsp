<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<h3>로그인 페이지</h3>
	<%-- <c:if test="${user ne 'ok' }"> --%>
	<form action="main?action=login" method="post">
		<input type="text" placeholder="아이디를 입력해주세요." name="id"><br/>
		<input type="password" placeholder="비밀번호를 입력해주세요." name="pass"><br/>
		<br/>
		<input type="submit" value="로그인">
	</form>
	<%-- </c:if> --%>
	<%-- <c:if test="${user eq 'ok' }">
		<strong>회원님 반갑습니다~^^</strong>
	</c:if>
	<br/><br/> --%>
	
	<a>비밀번호나 아이디를 잊으셨나요? 기능은 곧 만들어 드릴게요.</a><br/>
	<a href="main?action=joinForm">회원가입하기</a>
</body>
</html>