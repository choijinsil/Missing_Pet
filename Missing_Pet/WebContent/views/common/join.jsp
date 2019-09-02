<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>회원가입페이지</title>
</head>
<body>
	<h3>회원가입 페이지</h3>
	<form method="post" action="main?action=join">
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pass" value="1111"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="시리"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" value="test@naver.com"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text" name="tel" value="010-0000-0000"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="address" value="경기도 수원시 팔달구 우만동"></td>
		</tr>
	</table>
	<input type="submit" value="가입">
	<button>취소</button>
	</form>
</body>
</html>