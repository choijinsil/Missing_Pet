<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>회원가입페이지</title>
<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 360px;
  padding: 8% 0 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #ff6375;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #ff3349;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4CAF50;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  background: #ff5467; /* fallback for old browsers */
  background: -webkit-linear-gradient(right, #ff5467, #ff5467);
  background: -moz-linear-gradient(right, #ff5467, #ff5467);
  background: -o-linear-gradient(right, #ff5467, #ff5467);
  background: linear-gradient(to left, #ff6375, #ffc9cf);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}
</style>


</head>
<body>

<div class="login-page">
  <div class="form">

	<h3>회원가입 페이지</h3>
	<form method="post" action="main?action=join">
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" placeholder="아이디를 입력해주세요."></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pass" placeholder="비밀번호 입력해주세요"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" placeholder="이름을 입력해주세요" ></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" placeholder="이메일을 입력해주세요"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text" name="tel" placeholder="연락처를 입력해주세요"></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="address" placeholder="주소를 입력해주세요"></td>
		</tr>
	</table>

	<button type="submit" >가입</button>
	<br><br>
	<button  type="button" onclick="location.href='main?action=loginForm'">취소</button>
	</form>
	
	
  
  </div>
</div>	
</body>
</html>