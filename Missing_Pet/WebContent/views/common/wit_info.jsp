<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="jquery.bxslider/jquery.bxslider.css" rel="stylesheet" />
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

  <script>
    $(document).ready(function(){
      $('.slider').bxSlider();
    });
  </script>

</head>
<body>
 
  <!-- 
	<c:forEach items="${sessionScope.nameList }" var="list">
		<img  src="${list }" id="img">
		
	</c:forEach>
  -->
	
  <table border="1">
	
	<thead>
	 <tr>
	 	<th style="border:none">목격동물 정보</th>
	 </tr>
	 
	</thead>
	<tbody>
	
		<ul class="slider">
		<c:forEach items="${sessionScope.nameList }" var="list">
			<li>
			<img  src="${list }">
			</li>
		</c:forEach>
	    </ul>
	    
	  	<form name="wit_info" id="wit_info">
	  <tr><td>목격번호:</td><td><input type="text" name="wit_no" value="${witInfor_insert.getWit_no()}" readonly></td> </tr>	
	  <tr><td>발견날짜:</td><td><input type="text" name="wit_date" value="${witInfor_insert.getFind_date()}"readonly></td> </tr>
	  <tr><td>위치정보:</td><td><input type="text" name="wit_place" value="${witInfor_insert.getWit_place()}" readonly></td> </tr>
	  <tr><td>코멘트:</td><td><textarea rows="5" cols="20" name="comment" readonly>${witInfor_insert.getWit_comment()}</textarea></td> </tr>
      <tr><td>회원ID:</td><td><input type="text" name="id" value="${witInfor_insert.getId() }" readonly></td> </tr>
      <tr><td>신고번호:</td><td><input type="text" name="missing_no" value="${witInfor_insert.getMissing_no()}" readonly></td> </tr>
	  		
	  	</form>	   
  	 
  	</tbody>
  </table>		  
</body>
</html>