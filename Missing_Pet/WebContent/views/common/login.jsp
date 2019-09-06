<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
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
  	<h3>로그인 페이지</h3>

    <form class="login-form" action="main?action=login" method="post">
		<input type="text" placeholder="아이디를 입력해주세요." name="id"><br/>
		<input type="password" placeholder="비밀번호를 입력해주세요." name="pass"><br/>
		<br/>
		<button type="submit">LOGIN</button>
	<br/><br/>
    <button type="button" onclick="location.href='main?action=joinForm'">Create an account</button>	
    <br/><br/>
    <button type="button" onclick="location.href='main'">main</button>	
    </form>

  </div>
</div>
</body>










