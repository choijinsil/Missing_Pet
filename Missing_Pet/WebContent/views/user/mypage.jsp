<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>


<style>
	table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table.type11 th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background:#ff6375 ;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}

.max-small {
 width: 350px;
 height: 350px;
}

.header {
    background: #fff;
    border-bottom: 1px solid #e0e0e0;
    overflow: hidden;
    position: fixed;
    width: 100%;
    left: 0;
    top: 0;
}

.logo {
    display: block;
    float: left;
    padding: 20px 0 20px 30px;
}

.wrap{ width: 1000px; margin: 0 auto; overflow: hidden; margin-left: 0;
} 


#floatMenu {
	position: absolute;
}

</style>
	
	
	
<script type="text/javascript">

function real_check(clicked_name,complete_date){ //(missing_no,null여부)
	
	if (confirm("정말 귀가처리 하시겠습니까??") == true){    //확인 
	 	 
	 	if(!complete_date){ //compelete_date가 null이라면 
	 		location.href="main?action=update_mymissing&missing_no="+clicked_name;
	 		alert("귀가처리완료 !!");
	 		return;
		}else{
			alert("이미 귀가 처리 하셨습니다!!");
			return;
		}
	}else{   //취소
	 	return;
	}
}

function delete_user(){
	if(confirm("정말 탈퇴하시겠습니까?")){
		location.href='main?action=withdraw';
		return;
	}
}

function validate() {
	
	 var name = document.getElementById("name");
     var pass = document.getElementById("pass");
     var email = document.getElementById("email");
     var tel = document.getElementById("tel");
     var address = document.getElementById("address");
	
     if(user_info.name.value=="") {
         alert("이름을 입력해 주세요");
         user_info.name.focus();   
         return;
     }
     
     if(user_info.pass.value=="") {
         alert("비밀번호를 입력해 주세요");
         user_info.pass.focus();   
         return;
     }
     
     if(user_info.email.value=="") {
         alert("이메일을 입력해 주세요");
         user_info.email.focus();   
         return;
     }
     
     if(user_info.tel.value=="") {
         alert("전화번호를 입력해 주세요");
         user_info.tel.focus();  
         return;
     }
     
     if(user_info.address.value=="") {
         alert("주소를 입력해 주세요");
         user_info.address.focus();   
         return;
     }
     
     document.user_info.submit();
     
}


</script>

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>

$(document).ready(function() {

	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#floatMenu").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$("#floatMenu").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();

});
</script>



<title>MYPAGE.JSP</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
*	{box-sizing: border-box;
}

body{ font-family: Arial, Helvetica, sans-serif;
}

/* Create two columns/boxes that floats next to each other */
nav {
	  float: left;
	  width: 25%;
	  height: 300px; /* only for demonstration, should be removed */
	  padding: 20px;
	  }

article {
	  float: left;
	  padding: 20px;
	  width: 75%;
	  height: 300px; /* only for demonstration, should be removed */
	  }

/* Clear floats after the columns */
section:after {
	  content: "";
	  display: table;
	  clear: both;
	  }

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
    }
    }
	
</style>
</head>
<body>

<div class="header">
<div class="wrap">

<a class="logo" style="color: black">MYPAGE입니다.</a>
<a href="main" class="logo" style="color: black;">[메인으로 돌아가기]</a> 
<a href="main?action=user_mypost"  class="logo" style="color: black;">[게시글 관리하기]</a>

</div>
</div>

<section>
<nav>
<br><br><br>
<div id="floatMenu">
<h2>MY INFO</h2>
<form name="user_info" action="/main?action=update_myinfo" method="post">
   <table style="width:100%"  class="type11">
      <tr>
       <th>아이디</th>
      <td><input type="text" name="id" value="${userlist.id}" readonly></td>
      </tr>
      
      <tr>
      <th>비밀번호</th>
      <td><input type="password" id="pass" name="pass" value="${userlist.pass}"></td>
      </tr>
      
      <tr>
      <th>이름</th>
      <td><input type="text" id="name" name="name" value="${userlist.name}"></td>
      </tr>
      
      <tr>
      <th>이메일</th>
      <td><input type="text" id="email" name="email" value="${userlist.email}"></td>
      </tr>
      
      <tr>
      <th>연락처</th>
      <td><input type="text" id="tel" name="tel" value="${userlist.tel}"></td>
      </tr>
      
      <tr>
      <th>주소</th>
      <td><input type="text" id="address" name="address" value="${userlist.address}"></td>
      </tr>
      
      <tr>
      <th>블랙리스트</th>
      <td><input type="text" name="black" value="${userlist.black}" readonly></td>
      </tr>
      
      <tr>
      <td colspan="2"><input type="button" value="수정" onClick="validate()">
      <input type="reset" value="취소">
      <input type="button" value="탈퇴" onclick="delete_user()">
      </td>
      </tr> 
   </table>
</form>
</div>
</nav>
  
<article>
<br><br><br>
<h2>반려동물을 다시 만나셨나요?</h2>
<table style="width:100%"  class="type11" >
   <thead>
  <tr>
    <th>사진</th>
    <th>공고번호</th> 
    <th>작성일자</th>
    <th>실종일자</th>
    <th>품종</th>
    <th>귀가</th>
  </tr>
	</thead>

<tbody>
   <c:forEach items="${missinglist }" var="missing">   
   <c:set var="pic" value="${missing.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
  <tr>
    <td><img src = "${array[0]}" class='max-small'></td>
    <td>${missing.missing_no}</td>
    <td><fmt:formatDate value="${missing.write_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td><fmt:formatDate value="${missing.missing_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td>${missing.missing_type}</td>

    <td><button type="button" id="btn+${missing.missing_no}"
    onClick="real_check('${missing.missing_no}','${missing.complete_date }')">귀가</button></td>
  </tr>

   </c:forEach>
</tbody>   
</table>

</article>
</section>


</body>
</html>


