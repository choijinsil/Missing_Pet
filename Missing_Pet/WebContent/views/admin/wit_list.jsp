<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목격리스트</title>
<style type="text/css">
     body{text-align: center}
     table{margin: auto;}
     td,th{padding: 5px}
     .max-small {
 	 width: 300px;
 	 height: 300px;
	 }
</style>
</head>
<body>
<h3>[신고 정보]&nbsp;<a href="admin?action=admin">[관리자 페이지]</a>로 돌아가기</h3>
<hr>
<table border="1">
	<tr style="background-color: skyblue">
		<th>게시번호</th>
		<th>사진</th>
		<th>발견일자</th>
		<th>발견장소</th>
		<th>설명</th>
	</tr>
		<c:forEach items="${list}" var="wit">
		<c:set var="pic" value="${wit.missing_pic}"></c:set>
  		<c:set var="array" value="${fn:split(pic,',')}"></c:set>
			<tr>
				<td>${wit.wit_no }</td>
				<td><img src="${array[0] }" class='max-small'></img></td>
				<td>
				<fmt:formatDate value="${wit.find_date }" pattern="yyyy-MM-dd HH:MM"/>
				</td>
				<td>${wit.wit_place }</td>
				<td>${wit.wit_comment }</td>
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