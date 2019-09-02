<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실종리스트</title>
<style type="text/css">
     body{text-align: center}
     table{margin: auto;}
     td,th{padding: 5px}
  </style>
</head>
<body>
<h3>분실 정보&nbsp;<a href="admin?action=admin">[관리자 페이지]</a>로 돌아가기</h3>
<hr>
<table border="1">
	<tr style="background-color: skyblue">
		<th>공고번호</th>
		<th>아이디</th>
		<th>사진</th>
		<th>작성일</th>
		<th>장소</th>
		<th>분실날짜</th>
		<th>사례금</th>
		<th>인계날짜</th>
	</tr>
		<c:forEach items="${list}" var="pet">
			<tr>
				<td>${pet.missing_no }</td>
				<td>${pet.id }</td>
				<td>${pet.missing_pic }</td>
				<td>
				<fmt:formatDate value="${pet.write_date }" pattern="yyyy-MM-dd HH:MM"/>
				</td>
				<td>${pet.missing_place }</td>
				<td>
				<fmt:formatDate value="${pet.missing_date }" pattern="yyyy-MM-dd HH:MM"/>
				</td>
				<td>${pet.tip }</td>
				<td>
				<fmt:formatDate value="${pet.complete_date }" pattern="yyyy-MM-dd HH:MM"/>
				</td>
			</tr>
		</c:forEach>
      
     
</table>
<br>
	<c:if test="${page == 1}">
                        이전
     </c:if>
     
     <c:if test="${page > 1 }">      
       <a href="admin?action=pet&page=${page-1 }">이전</a>
     </c:if>
     
      <c:forEach begin="1" end="${totalPage }"  var="i">
         [<a href="admin?action=pet&page=${i }">${i }</a>]
      </c:forEach>
      
      <c:choose>
        <c:when test="${page < totalPage}">
           <a href="admin?action=pet&page=${page+1 }">다음</a>
        </c:when>
        <c:otherwise>다음</c:otherwise>
      </c:choose>
</body>
</html>