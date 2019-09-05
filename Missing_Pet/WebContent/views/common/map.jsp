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
<style type="text/css">
	.map2{ display:inline; float:left; width: 80%; height: 500px; margin-top: 30px;}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link href="jquery.bxslider/jquery.bxslider.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	  
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script type="text/javascript">

 
 $(document).ready(function() {
	
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
	 
 
 });
	 
</script>

<style type="text/css">
	html,body{
		width:100%;
		height:100%;
	}
</style>
</head>
<body>
	<%
		String wit_place="";
	  if(request.getSession().getAttribute("witInfor_insert")!=null){
			WitnessVO wit_vo=(WitnessVO)request.getSession().getAttribute("witInfor_insert");
			 wit_place=wit_vo.getWit_place();
	  }else if(request.getSession().getAttribute("witInfor_insert")==null){
		     //wit_place="서울특별시 중구 세종대로110"; // 마커로 목격장소찍기전에 마커가 표시될 default값
	  }
	%>

	<a href="/main?action=main">메인으로</a>	

	<div style="height:100%; width:100%; overflow: hidden; margin: 0; padding: 0;">
	<div id="d1" style="width:100%; height:100%; float:left; background:red;"></div> 
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=085fa0431ec49cf3b7687ee83350c1f2&libraries=services"></script>
	<script>
		function witInfo(latLng,detailAddr){	//목격동물 마커를 표시한곳의 위경도와 지번주소값을 넘기기
			
			var latLng=encodeURI(latLng);
			var detailAddr=encodeURI(detailAddr);
			 
			alert(latLng);
			alert(detailAddr);
			
			 document.location.href="/wit?action=witpet&addr="+detailAddr+"&latLng="+latLng;
		}	
		
		var latitude = '${latitude}';//위도
		var longitude = '${longitude}';//경도
		
		var mapContainer = document.getElementById('d1'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
	
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		
		var imageSrc='https://image.flaticon.com/icons/svg/616/616408.svg',
			imageSize=new kakao.maps.Size(64,69),
			imageOption={offset:new kakao.maps.Point(27,69)};
		
		var markerImage=new kakao.maps.MarkerImage(imageSrc,imageSize,imageOption);
			
			var wit_place='<%=wit_place %>';
			var geocoder = new kakao.maps.services.Geocoder();
			
		if(wit_place !="서울특별시 중구 세종대로110"){//세션영역에 저장된 vo안에 getWit_place가 default값인 '서울특별시 중구 세종대로110'이 아니라면 즉, DB에 place데이터값이 들어가있으면
			// 주소-좌표 변환 객체를 생성합니다(주소값을 가지고 위치를 검색해서 중심을이동해준다.)
			
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('<%=wit_place%>', function(result, status) {
			// 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords,
		            image:markerImage
		        });
	
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">목격동물</div>'
		        });
		        infowindow.open(map, marker);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		    
		});
	}else if(wit_place =="서울특별시 중구 세종대로110"){//wit_place가 default값일때 마커위치를 눌렀을때 얻을수있는 도로명주소를 controller로 전달해서 db에 저장
	  geocoder.addressSearch('서울특별시 중구 세종대로110',function(result,status){
		 if(status===kakao.maps.services.Status.OK){
			 var coords=new kakao.maps.LatLng(result[0].y, result[0].x);
			 
			 map.setCenter(coords);
			 
		 }
		  
	  });
		
		
		var marker=new kakao.maps.Marker({
				      image:markerImage	
		});
		var	infowindow=new kakao.maps.InfoWindow({zindex:1});// 클릭한 위치에대한 주소를 표시
			
		kakao.maps.event.addListener(map,'click',function(mouseEvent){
			searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		        	
		            var detailAddr = !!result[0].road_address ?  result[0].road_address.address_name + '' : '';
		            detailAddr += result[0].address.address_name + '';
		           
		           
					
					// 마커를 클릭한 위치에 표시
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);
		           	
		            witInfo(mouseEvent.latLng,detailAddr);// 마커를 클릭한 위치의 경도와 위도값을 가지고 페이지 이동(DB입력위해)
		            
				}
				
			}); //  클릭한곳에 지번주소를alert하고 마커를 표시한다.
			
			
			
		});
		
		
		
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			
		
		}
		
	}
	
	</script>
	<div id="d2" style="width:20%; height:100%; float:right; background:blue; visibility:hidden;">2</div>
	</div>
</body>
</html>