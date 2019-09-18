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
	table{margin: auto; border: 1px solid #BDBDBD; border-radius: 5px; margin-top: 10px;}
	th{text-align: left;}
	td{padding: 20px;}
	div{text-align: center;}
	
	.header{position: absolute; float: left;}
	.wrap{ display:inline; width: 100%; height: 500px; border-radius: 5px; position: absolute; margin-top: 20px;}
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
		   $('#file2').show();
		});
		
		$("#imgInput2").change(function(){
		   readURL2(this);
		   $('#file3').show();
		});
		
		$("#imgInput3").change(function(){
		   readURL3(this);
		});
			
		$("#searchCenter").on("change", function() {
			
			var center=$("#searchCenter").val();
			 changeCenter(center);
			
		});
		
		
 	});
	
</script>

</head>
<body>
	<a class="header" href="main?action=main">[홈페이지로]</a>
	<div class="wrap">
		<div class="map_wrap">
		    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		    <div class="hAddr">
		        <span class="title">지도중심기준 행정동 주소정보</span>
		        <span id="centerAddr"></span>
		        <span><input type="text" id="searchCenter" style="width:219px; text-align: center" placeholder="지도중심좌표 이동" ></span>
		    </div>
		</div>
		<div class="list">
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
							<td><span id="file2" style="display: none"><input type='file' id="imgInput2" name="missing_pic2"/></span></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td><span id="file3" style="display: none"><input type='file' id="imgInput3" name="missing_pic3"/></span></td>
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
			</div>
			<div id="clickLatlng"></div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01fbf10c2ff64d32622233895840cd27&libraries=services"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.566826, 126.9786567),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// input창에 client가 주소를 입력시 change이벤트가 발생해서 text박스에 있는 주소값으로 지도중심으로 바꾸기
		function changeCenter(center){
			
			var center=center;
			var geocoder=new kakao.maps.services.Geocoder();
			
			//주소로 좌표를 검색
			geocoder.addressSearch(center,function(result,status){
				var coords=new kakao.maps.LatLng(result[0].y,result[0].x);
			
				map.setCenter(coords);
			});
			
		}
		
		
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