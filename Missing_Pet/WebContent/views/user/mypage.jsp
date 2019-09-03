<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>

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
		location.href='main?action=withdraw'
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
<h2>MYPAGE.JSP</h2>
<a href="main">메인으로 돌아가기</a>
<hr>
<section>
<nav>
<h2>MY INFO</h2>
<form name="user_info" action="/main?action=update_myinfo" method="post">
   <table style="width:100%" border= "1px">
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
      <input type="reset" value="취소"></td>
      <input type="reset" value="취소"> 
      <input type="button" value="탈퇴" onclick="delete_user()">
      </td>
      </tr> 
   </table>
</form>
</nav>
  
<article>
<h2>반려동물을 다시 만나셨나요?</h2>
<a href="main?action=user_mypost">게시글 관리하기</a>
<table style="width:100%"  border= "1px">
  <tr>
    <th>사진</th>
    <th>공고번호</th> 
    <th>작성일자</th>
    <th>실종일자</th>
    <th>품종</th>
    <th>귀가</th>
  </tr>
	

   <c:forEach items="${missinglist }" var="missing">   
   <c:set var="pic" value="${missing.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
  <tr>
    <td><img src = "${array[0]}"></td>
    <td>${missing.missing_no}</td>
    <td><fmt:formatDate value="${missing.write_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td><fmt:formatDate value="${missing.missing_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td>${missing.missing_type}</td>

    <td><button type="button" id="btn+${missing.missing_no}"
    onClick="real_check('${missing.missing_no}','${missing.complete_date }')">귀가</button></td>
  </tr>

   </c:forEach>
</table>

</article>
</section>


</body>
</html>


