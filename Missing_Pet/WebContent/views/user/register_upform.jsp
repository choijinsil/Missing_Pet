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
	div{text-align: center;}
	
	.header{float: left; position: absolute;}
	.wrap{ display:inline; width: 100%; height: 500px; border-radius: 5px;}
	.list{ display:inline; float:left; width:40%; margin-top: 30px;}
	.image{width: 100px; height: 100px;}
	
	.map_wrap{ display:inline; float:left; width: 60%; height: 700px; margin-top: 30px;}
	.title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;
    		background:rgba(255,255,255,0.8);z-index:1;padding:5px;margin-top:30px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
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
	<a class="header" href="main?action=user_mypost">[내게시글목록으로]</a>
	<div class="wrap">
	<div class="map_wrap">
		    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		    <div class="hAddr">
		        <span class="title">지도중심기준 행정동 주소정보</span>
		        <span id="centerAddr"></span>
		    </div>
		</div>
	<div class="list">
	<h3>실종동물수정</h3><hr style="background-color: yellow">
	
   <c:set var="pic" value="${vo.missing_pic}"></c:set>
   <c:set var="array" value="${fn:split(pic,',')}"></c:set>
   
		<div class="images">

		   <img class="image" id="image1" src="${array[0]}" alt="your image" />
		   <img class="image" id="image2" src="${array[1]}" alt="your image"/>
		   <img class="image" id="image3" src="${array[2]}" alt="your image"/>
		</div> 
	<form action="pet?action=register_update" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="hidden_pic1" value="${array[0]}">
	    <input type="hidden" name="hidden_pic2" value="${array[1]}">
	    <input type="hidden" name="hidden_pic3" value="${array[2]}">
	<table>
		<tbody>
			<tr>
				<td>*</td>
				<th>사진</th>
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
		<button type="submit" id="bt1">수정</button>
		<button type="reset">reset</button>
	</div>
	
	<input type="hidden" name="missing_no" value="${vo.missing_no }">
	<div id="clickLatlng"></div>
	</form>
	</div>
	</div>
	
	<c:set var="place" value="${vo.missing_place}"></c:set>
	<c:set var="arr" value="${fn:split(place,',')}"></c:set>
	<input type="hidden" id="latitude" value="${arr[0]}">
	<input type="hidden" id="longitude" value="${arr[1]}">
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043&libraries=services"></script>
	<script>
		var container = document.getElementById('map');
		
		var latitude = document.getElementById('latitude').value;//위도
	     var longitude = document.getElementById('longitude').value;//경도
		
		var options = {
			center: new kakao.maps.LatLng(latitude, longitude),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {       
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다"C:/Users/Playdata/Desktop/web/2/index4.html"
		    marker.setPosition(latlng);
		    
		    /* var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다'; */
		    
		    var message = latlng.getLat() +',' +latlng.getLng();
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = '<input type=hidden name=missing_place value=' +message +'>';
		    
		    
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">법정동 주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';

		            // 마커를 클릭한 위치에 표시합니다 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);

		            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        }   
		    });
		});
		
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}

		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');

		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		                infoDiv.innerHTML = result[i].address_name;
		                break;
		            }
		        }
		    }    
		}
		</script>
</body>
</html>