<%@page import="beans.missing.vo.WitnessVO"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map(바탕은 카카오맵, ajax로 실종동물,목격동물 정보 보이는 창 띄우기)</title>
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
	
	.map_wrap{ display:inline; float:left; width: 100%; height: 700px; margin-top: 30px;}
	.title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;
    		background:rgba(255,255,255,0.8);z-index:1;padding:5px;margin-top:30px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>

	$(function(){
	/*
	$.ajax({
			url:"wit_info.jsp",
			dataType:"html",
			
			type:"post",
			success:function(result){
				$("#d2").html(result);
			}		
		});
	
	
	$('#img').on("click", function() {
		 var visi=$('#d2').attr("style").split(";")[4];
		 var state=visi.split(":")[1];
		 if(state=="hidden"){
			 	$('#d2').attr("style", "width:20%; height:100%; float:right; background:blue; visibility:visibility;");
				$('#d1').attr("style", "width:80%; height:100%; float:left; background:red;");
			return true;
		 }else
			 $('#d2').attr("style", "width:20%; height:100%; float:right; background:blue; visibility:hidden;");
			$('#d1').attr("style", "width:100%; height:100%; float:left; background:red;");
			 
	});
	*/				
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
		    </div>
		</div>
			<div id="clickLatlng"></div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043&libraries=services"></script>
	<script>
	
		function witInfo(latLng,detailAddr){	//목격동물 마커를 표시한곳의 위경도와 지번주소값을 넘기기
			
			var latLng=encodeURI(latLng);
			var detailAddr=encodeURI(detailAddr);
			 
			
			 document.location.href="/wit?action=witpet&addr="+detailAddr+"&latLng="+latLng+"&missing_no="+'${missing_no}';
		}
	
		var container = document.getElementById('map');
		
		var latitude = '${latitude}'//위도
	     var longitude = '${longitude}';//경도
		
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
		    
		    
		    var message = latlng.getLat() +',' +latlng.getLng();
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = '<input type=hidden name=missing_place value=' +message +'>';
		    
		    
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            //var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            //detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            var detailAddr = result[0].address.address_name;
		            
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
		            
		            witInfo(mouseEvent.latLng,detailAddr);// 마커를 클릭한 위치의 경도와 위도값을 가지고 페이지 이동(DB입력위해)
		        }   
		    });
		
		});
		
		var imageSrc='https://image.flaticon.com/icons/svg/616/616408.svg',
		imageSize=new kakao.maps.Size(64,69),
		imageOption={offset:new kakao.maps.Point(27,69)};
	
		var markerImage=new kakao.maps.MarkerImage(imageSrc,imageSize,imageOption);	
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker({
			image:markerImage
		}); // 클릭한 위치를 표시할 마커입니다
		
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