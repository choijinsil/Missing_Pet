<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실종동물정보 입력창</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

 $(function() {
	 $("#uploadFile1").change(function() {
			
			readURL1(this);
			
		});
		$("#uploadFile2").change(function() {
		
			readURL2(this);
			
		});

		$("#uploadFile3").change(function() {
			
			readURL3(this);
		});
	 
	 
	 
	 function readURL1(input){
			if(input.files && input.files[0]){
				var reader=new FileReader();
				
				reader.onload=function(e){
					$('#img1').attr('src',e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			
		}

		function readURL2(input){
			if(input.files && input.files[0]){
				var reader=new FileReader();
				
				reader.onload=function(e){
					$('#img2').attr('src',e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			
		}

		function readURL3(input){
			if(input.files && input.files[0]){
				var reader=new FileReader();
				
				reader.onload=function(e){
					$('#img3').attr('src',e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
			
		}

		function textArea_val(){
			
			form=$('fileForm');
			form.action=form.action+"?comment="+form["comment"];
		
			return true;
			
		}
		
 });
	
</script>
</head>
<body>
  <img src="#" id="img1">
	 <img src="#" id="img2">
	 <img src="#" id="img3">
  <table border="1">
	
	<thead>
	 <tr>
	 	<th style="border:none">목격동물 정보입력</th>
	 </tr>
	 
	</thead>
	<tbody>
	   
	  	<form name="fileForm" id="fileForm" method="post" action="wit?action=fileUp" enctype="multipart/form-data" onsubmit="textArea_val()" >
	  
	  <tr><td>사진:</td><td><input type="file" name="uploadFile1" id="uploadFile1">  <input type="file" name="uploadFile2" id="uploadFile2" > <input type="file" name="uploadFile3" id="uploadFile3"></td></tr>  
	  <tr><td>발견날짜:</td><td><input type="date" name="wit_date"></td> </tr>
	  <tr><td>발견시간:</td><td><input type="time" name="wit_time"></td> </tr>
	  <tr><td>위치정보:</td><td><input type="text" name="wit_place" ></td> </tr>
	  <tr><td>코멘트:</td><td><textarea rows="5" cols="20" name="comment"></textarea></td> </tr>
      <tr><td style="border:none"><button  name="input" type="submit"  >등록하기</button></td></tr>
	  		
	  	</form>	   
  	 
  	</tbody>
  </table>		  
  
	
</body>
</html>