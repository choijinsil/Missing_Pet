<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세정보</title>
<style type="text/css">
     body{text-align: center}
     table{margin: auto;}
     td{padding: 5px}
     .skyblue{background-color: skyblue;
              width: 80px;
              text-align: left}
  </style>
  <script type="text/javascript">
  		function deleteInfo(){
  			alert("정말 삭제하시겠습니까?");
  			location.href = 'main?action=delete&id=${user.id}';
  		}
  </script>
</head>
<body>
<h3>회원 상세정보</h3>
<hr>
[<a href="admin?action=admin">회원 목록으로</a>]<br><br>
<form action="admin?action=update" method="post">
<table border="1">
<tr>
		<tr>
         <td class="skyblue">아이디</td>
         <td><input type="text" name="id"
                    value="${user.id }" readonly></td>
      </tr>
      <tr>
         <td class="skyblue">이름</td>
         <td><input type="text" name="name" value="${user.name }" readonly></td>
      </tr>
      <tr>
         <td class="skyblue">이메일</td>
         <td><input type="text" name="email"  value="${user.email }" readonly></td>
      </tr>
      <tr>
         <td class="skyblue">연락처</td>
         <td><input type="text" name="tel"  value="${user.tel }" readonly></td>
      </tr>
      <tr>
         <td class="skyblue">주소</td>
         <td><input type="text" name="address"  value="${user.address }" readonly></td>
      </tr>
      <tr>
      	 <td class="skyblue">블랙리스트</td>
      	 <td>
					<select name="black">
						<option selected>${user.black }</option>
						<c:choose>
							<c:when test="${user.black eq 'Y'}">
								<option>N</option>
							</c:when>
							<c:otherwise>
								<option>Y</option>
							</c:otherwise>
						</c:choose>
					</select>
				</td>
      </tr>
      <tr>
         <td colspan="2">
           <input type="submit" value="수정">
           <input type="reset" value="취소">
           <input type="button" value="삭제" onclick="deleteInfo()"/>
         </td>
      </tr>
</table>
</form>
</body>
</html>