<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">

function delete_mymissing(missing_no){ 
	
	if (confirm("정말 삭제 하시겠습니까??") == true){    //확인 
	 		location.href="pet?action=delete_mymissing&missing_no="+missing_no;
	 		return;
		
	}else{   //취소
	 	return;
	}
}

function delete_mywit(wit_no){ 
	
	if (confirm("정말 삭제 하시겠습니까??") == true){    //확인 
	 		location.href="wit?action=delete_mywit&wit_no="+wit_no;
	 		return;
		
	}else{   //취소
	 	return;
	}
}



function  register_upform(missing_no){
	
	location.href="pet?action=register_upform&missing_no="+missing_no;
	
}

function  wit_upform(wit_no){
	
	location.href="wit?action=wit_upform&wit_no="+wit_no;
	
}

</script>

<title>MYPAGE.JSP</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
<h2>게시글관리 MYPOST.JSP</h2>
<a href="main?action=main">[메인]</a>
<a href="main?action=user_mypage">[마이페이지]</a>
<hr>
<section>
<nav>

<h2>MY MISSING</h2>
<table style="width:100%"  border= "1px">
  <tr>
    <th>사진</th>
    <th>공고번호</th> 
    <th>작성일자</th>
    <th>실종일자</th>
    <th>실종장소</th>
    <th>품종</th>
     <th>코멘트</th>
      <th>사례금</th>
       <th>인계날짜</th>
        <th>수정/삭제</th>
  </tr>

 <c:forEach items="${missinglist}" var="missing">   
   <c:set var="pic" value="${missing.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
  <tr>
    <td><img src = "${array[0]}"></td>
    <td>${missing.missing_no}</td>
    <td><fmt:formatDate value="${missing.write_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td><fmt:formatDate value="${missing.missing_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td>${missing.missing_place}</td>
    <td>${missing.missing_type}</td>
    <td>${missing.missing_comment}</td>
    <td>${missing.tip}</td>
    <td>${missing.complete_date }</td>
    <td>
    	<button onClick="register_upform('${missing.missing_no}')">수정</button><br>
        <button type="button" id="btn+${missing.missing_no}"
    onClick="delete_mymissing('${missing.missing_no}')">삭제</button>
    </td>
  </tr>
 </c:forEach>
 
</table>
</nav>
  
<article>
<h2>MY WIT</h2>
<table style="width:100%"  border= "1px">
  <tr>
    <th>사진</th>
    <th>게시번호</th> 
    <th>공고번호</th>
    <th>발견일자</th>
    <th>발견장소</th>
    <th>코멘트</th>
    <th>수정/삭제</th>
  </tr>

<c:forEach items="${witlist}" var="wit">   
   <c:set var="pic" value="${wit.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
  <tr>
    <td><img src = "${array[0]}"></td>
    <td>${wit.wit_no}</td>
    <td>${wit.missing_no}</td>
    <td><fmt:formatDate value="${wit.find_date}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
    <td>${wit.wit_place}</td>
    <td>${wit.wit_comment}</td>
    <td>
    	<button onClick="wit_upform('${wit.wit_no}')">수정</button><br>
        <button type="button" id="btn+${wit.missing_no}"
    onClick="delete_mywit('${wit.wit_no}')">삭제</button>
    </td>
  </tr>
 </c:forEach>
 
</table>

</article>
</section>


</body>
</html>

