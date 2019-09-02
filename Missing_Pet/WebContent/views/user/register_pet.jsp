<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실종동물등록</title>
<style>
	h3{text-align: center;}
	hr{width: 380px;}
	table{margin: auto; border: 1px solid #BDBDBD; border-radius: 5px; margin-top: 40px;}
	th{text-align: left;}
	td{padding: 20px;}
	div{text-align: center; margin-top: 20px;}
	
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
	
</script>

</head>
<body>
	<h3>실종동물등록</h3><hr style="background-color: yellow">
		<div class="images">
		   <img class="image" id="image1" src="#" alt="your image"/>
		   <img class="image" id="image2" src="#" alt="your image"/>
		   <img class="image" id="image3" src="#" alt="your image"/>
		</div> 
	<form action="pet?action=register" method="post" enctype="multipart/form-data">
	<table>
		<tbody>
			<tr>
				<td>*</td>
				<th>사진</th>
				<td><input type="file" id="imgInput1" name="missing_pic1"></td>
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
				<td><input type="text" name="missing_place"></td>
			</tr>
			<tr>
				<td>*</td>
				<th>실종날짜</th>
				<td><input type="date" name="missing_date"></td>
			</tr>
			<tr>
				<td>*</td>
				<th>실종시간</th>
				<td><input type="time" name="missing_time"></td>
			</tr>
			<tr>
				<td></td>
				<th>코멘트</th>
				<td>
					<textarea rows="10" cols="30" name="comment"></textarea>
				</td>
			</tr>
			<tr>
				<td>*</td>
				<th>보상금</th>
				<td><input name="tip"></td>
			</tr>
			<tr>
				<td>*</td>
				<th>종류</th>
				<td colspan="3">
					<input type="checkbox" name="type" value="강아지"> 강아지
					<input type="checkbox" name="type" value="고양이"> 고양이
					<input type="checkbox" name="type" value="기타"> 기타
				</td>
			</tr>
		</tbody>
	</table>
	<div>
		<button type="submit" id="bt1">등록</button>
		<button type="reset">reset</button>
		<a href="main?action=main">[홈페이지로]</a>
	</div>
	</form>
</body>
</html>