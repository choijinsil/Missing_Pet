<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<style type="text/css">
     body{text-align: center}
     table{margin: auto;}
     td,th{padding: 5px}
  </style>
</head>
<body>
<h3><a href="main?action=main">[메인페이지]</a>&nbsp;<a href="admin?action=pet">[실종정보 목록]</a>&nbsp;<a href="admin?action=wit">[목격정보 목록]</a></h3>
<hr>
<input type="text" placeholder="검색할 이름이나 아이디를 입력해주세요" size="50px" name="search_user"> <input type="button" value="검색" onclick="location.href='admin?action=search_user'">
<table border="1">
	<tr style="background-color: skyblue">
		<th>아이디</th>
		<th>이름</th>
		<th>이메일</th>
		<th>연락처</th>
		<th>주소</th>
		<th>블랙리스트 여부</th>
	</tr>
		<c:forEach items="${list}" var="user">
			<tr>
				<td><a href="admin?action=edit&id=${user.id} ">${user.id }</a></td>
				<td>${user.name }</td>
				<td>${user.email }</td>
				<td>${user.tel }</td>
				<td>${user.address }</td>
				<c:if test="${user.black eq 'N'}">
					<td>${user.black }</td>
				</c:if>
				<c:if test="${user.black eq 'Y'}">
					<td><font color="red">${user.black }</font></td>
				</c:if>
			</tr>
		</c:forEach>
      
     
</table>
<br>
	<c:if test="${page == 1}">
                        이전
     </c:if>
     
     <c:if test="${page > 1 }">      
       <a href="admin?action=admin&page=${page-1 }">이전</a>
     </c:if>
     
      <c:forEach begin="1" end="${totalPage }"  var="i">
         [<a href="admin?action=admin&page=${i }">${i }</a>]
      </c:forEach>
      
      <c:choose>
        <c:when test="${page < totalPage}">
           <a href="admin?action=admin&page=${page+1 }">다음</a>
        </c:when>
        <c:otherwise>다음</c:otherwise>
      </c:choose>
</body>
</html>