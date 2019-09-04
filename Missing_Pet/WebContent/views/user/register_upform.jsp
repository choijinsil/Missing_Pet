<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>   
    
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>실종동물등록</title>
<style>
	h3{text-align: center;}
	hr{width: 380px;}
	table{margin: auto; border: 1px solid #BDBDBD; border-radius: 5px; margin-top: 40px;}
	table{margin: auto; border: 1px solid #BDBDBD; border-radius: 5px; margin-top: 10px;}
	th{text-align: left;}
	td{padding: 20px;}
	td{padding: 10px;}
	div{text-align: center; margin-top: 20px;}
	
	
	.wrap{ display:inline; width: 100%; height: 500px; border-radius: 5px;}
	.list{ display:inline; float:left; width:40%; margin-top: 30px;}
	.map{ display:inline; float:left; width: 60%; height: 700px; margin-top: 30px;}
	.image{width: 100px; height: 100px;}
</style>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>



	$(function(){
		
		$("input[name=type]:checkbox").change(function() {
	        var cnt = 1;
	        if( cnt == $("input[name=type]:checkbox:checked").length ) {
	            $(":checkbox:not(:checked)").attr("disabled", "disabled");
	        } else {
	            $("input[name=type]:checkbox").removeAttr("disabled");
	        }
	    });
 	
		
		
	function readURL1(input) {
		
		 if (input.files && input.files[0]) {
			  var reader = new FileReader();
			  
			  reader.onload = function (e) {
			   	$('#image1').attr('src', e.target.result);  
			  }
			  
			  reader.readAsDataURL(input.files[0]);
		 }
	}
	
	function readURL2(input) {
		
		 if (input.files && input.files[0]) {
			  var reader = new FileReader();
			  
			  reader.onload = function (e) {
			   	$('#image2').attr('src', e.target.result);  
			  }
			  
			  reader.readAsDataURL(input.files[0]);
		 }
	}
	
	function readURL3(input) {
		
		 if (input.files && input.files[0]) {
			  var reader = new FileReader();
			  
			  reader.onload = function (e) {
			   	$('#image3').attr('src', e.target.result);  
			  }
			  
			  reader.readAsDataURL(input.files[0]);
		 }
	}
		  
		$("#imgInput1").change(function(){
		   readURL1(this);
		});
		
		$("#imgInput2").change(function(){
		   readURL2(this);
		});
		
		$("#imgInput3").change(function(){
		   readURL3(this);
		});
			
		
	
 	});
	
	$(function(){
		console.log($('#dog').val());
		if($('#dog').val() == '${vo.missing_type}'){
			$('#dog').prop('checked', true);
		}else if($('#cat').val() == '${vo.missing_type}'){
			$('#cat').prop('checked', true);
		}else{
			$('#ect').prop('checked', true);
		}
		
		$('#pic_cancle1').click(function(){
			$('#image1').attr('src','');
		});
		
		$('#pic_cancle2').click(function(){
			$('#image2').attr('src','');
		});
		
		$('#pic_cancle3').click(function(){
			$('#image3').attr('src','');
		});
		
	});
	
	
	
</script>

</head>
<body>
	<div class="wrap">
	<div id="map" class="map"></div>
	<div class="list">
	<h3>실종동물수정</h3><hr style="background-color: yellow">
	
   <c:set var="pic" value="${vo.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
   
		<div class="images">

		   <img class="image" id="image1" src="${array[0]}" alt="your image"/>
		   <button id="pic_cancle1">x</button>
		   <img class="image" id="image2" src="${array[1]}" alt="your image"/>
		    <button id="pic_cancle2">x</button>
		   <img class="image" id="image3" src="${array[2]}" alt="your image"/>
		    <button id="pic_cancle3">x</button>
		</div> 
	
	<form action="pet?action=register" method="post" enctype="multipart/form-data">
	<form action="pet?action=register_update" method="post" enctype="multipart/form-data">
	<table>
		<tbody>
			<tr>
				<td>*</td>
				<th>사진</th>
				<td><input type="file" id="imgInput1" name="missing_pic1"></td>
				<td><input type="file" id="imgInput1" name="missing_pic1" ></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><input type='file' id="imgInput2" name="missing_pic2"/></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><input type='file' id="imgInput3" name="missing_pic3"/></td>
			</tr>
			<tr>
				<td>*</td>
				<th>실종장소</th>
				<td><input type="text" name="missing_place" value=${vo.missing_place }></td>
			</tr>
			<tr>
				<td>*</td>
				<th>실종날짜</th>
			
			<fmt:formatDate value="${vo.missing_date}" pattern="yyyy-MM-dd HH:mm:ss" var="missing_date" />	
			<c:set var="array" value="${fn:split(missing_date,' ')}"></c:set>
				<td><input type="date" name="missing_date" value="${array[0]}"></td>
			</tr>
			<tr>
				<td>*</td>
				<th>실종시간</th>
				<td><input type="time" name="missing_time" value="${array[1]}"></td>
			</tr>
			<tr>
				<td></td>
				<th>코멘트</th>
				<td>
					<textarea rows="10" cols="30" name="comment">${vo.missing_comment }</textarea>
				</td>
			</tr>
			<tr>
				<td>*</td>
				<th>보상금</th>
				<td><input name="tip" value=${vo.tip }></td>
			</tr>
			<tr>
				<td>*</td>
				<th>종류</th>
				<td colspan="3">
				
				
				<input type="checkbox" name="type" id="dog" value="강아지"> 강아지 
				<input type="checkbox" name="type" id="cat" value="고양이"> 고양이
				<input type="checkbox" name="type" id="ect" value="기타"> 기타 	
				
				</td>
			</tr>
		</tbody>
	</table>
	<div>
		<button type="submit" id="bt1">등록</button>
		<button type="submit" id="bt1">수정</button>
		<button type="reset">reset</button>
		<a href="main?action=user_mypost">[내게시글목록으로]</a>
	</div>
	</form>
	<input type="hidden" name="missing_no" value="${vo.missing_no }">
	
	</form>
	</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	</script>
</body>
</html>