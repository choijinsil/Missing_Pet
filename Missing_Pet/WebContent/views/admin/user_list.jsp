<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	
	table{
    border-collapse: separate;
    border-spacing: 1px;
    line-height: 1.5;
    margin: auto;
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
	
	body{text-align: center}
    td,th{padding: 5px}
</style>
<meta charset="UTF-8">
<title>회원리스트</title>
  <script>
  	function search_user(){
  		var search_id = document.getElementById('search_id').value;
  		location.href = 'admin?action=search_user&search_id='+search_id;
  	}
  </script>
</head>
<body>
<h3><a href="main?action=main">[메인페이지]</a>&nbsp;<a href="admin?action=pet">[실종정보 목록]</a>&nbsp;<a href="admin?action=wit">[목격정보 목록]</a></h3>
<hr>
<input type="text" placeholder="검색할 아이디나 이름을 입력해주세요" size="50px" id="search_id"> 
<input type="button" value="검색" onclick="search_user()"> 
<input type="button" value="전체 보기" onclick="location.href='admin?action=admin'" style="margin-bottom: 30px;">
<table border="1" class="type11" >
	<tr >
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