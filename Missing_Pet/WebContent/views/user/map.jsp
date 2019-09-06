<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실종동물정보페이지</title>
	<style>
		.wrap{ display:inline; width: 100%; height: 500px; border-radius: 5px;}
		.map{ display:inline; float:left; width: 80%; height: 600px; margin-top: 30px;}
		.list{ display:inline; float:left; height: 500px; width: 20%; margin-top: 10px;}
		
		.main{color:#0B3861; font-size: 12px bold; position: absolute; margin-left: 100px;}
		#div1{position: absolute; }
		
		table{border: solid #D8D8D8 5px; border-radius: 5px;}
		td{padding: 30px;}
		th{text-align: left;}
		.img{width: 70px; height: 70px; margin: auto; border-bottom: 3px solid #e0e0e0; cursor: pointer;}
		
		#table{margin: auto; border: 1px solid #BDBDBD; border-radius: 5px; margin-top: 40px;}
		textarea{width: 180px; height: 100px;}
		h3{text-align: center;}
		
		 .hidden
        {
            display: none;
        }
        .bold
        {
            font-weight: bold;
        }
        .DivCss
        {
            background-color: #FFFFCC; border: thin dotted #000000; padding: 2px; margin: 0px; width: 200px;
        }
        
        .session { width: 100px; height: 100px; }
        #section0 .swiper-container { width: 20%; height: 20%; z-index: 20; left:0; top:0; margin-top: 20px;}
		
		.img_wrap{ margin: 0 auto; overflow: hidden; }
		.h1{ width: 100%; margin: 0 2.0% 20px;  float: left;}
		.h1 .top{ height: 300px; background-size: cover; border-bottom: 3px solid #e0e0e0; cursor: pointer;}
		
		
		
		 .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px; margin-top: 50px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	
	<!-- swiper js& css-->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/css/swiper.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script>
	<script>
        $(function () {
        	
            var toggleStyleSwitcher = function () {
                $('#div1').addClass('bold');
            };
            
            $('#list').addClass('hidden');
 
            $('#bt').click(function (event) {
                $('#list').toggleClass('hidden');
            });
            
            var mySwiper = new Swiper ('.swiper-container', {
            	slidesPerView : 1,
			    direction: 'horizontal',
			    loop: true,
			    pagination: '.swiper-pagination',
			    nextButton: '.swiper-button-next',
			    prevButton: '.swiper-button-prev',
			    
			});
        });
    </script>
		
</head>
	<%
		List<String> latLng=(List<String>)request.getSession().getAttribute("latLng");
	%>
<body>
	<c:set var="pic" value="${vo.missing_pic}"></c:set>
	<c:set var="array" value="${fn:split(pic,',')}"></c:set>
	<div class="wrap">
		<div id="map" class="map"></div>
		<div id="div1">
		<button id="bt">실종동물</button>
	</div>
	<div class="main">
		<a href="main?action=main">[메인으로]</a>
		<c:choose>
			<c:when test="${loginId == null || loginId == vo.id}">
				<a href="wit?action=wit&map_id=${vo.id}&missing_no=${vo.missing_no}&missing_place=${vo.missing_place}" style="display: none;">목격신고</a>
			</c:when>
			<c:otherwise>
				<a href="wit?action=wit&map_id=${vo.id}&missing_no=${vo.missing_no}&missing_place=${vo.missing_place}">목격신고</a>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="section" id="section0">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide my_slide">
					<div class="img_wrap">
						<div class="article">
								<div class="h1">
									<div class="top" style="background-image:url('${array[0]}');"></div>		
								</div>
						</div>
					</div>
				</div>
				<div class="swiper-slide my_slide">
					<div class="img_wrap">
						<div class="article">
								<div class="h1">
									<div class="top" style="background-image:url('${array[1]}');"></div>		
								</div>
						</div>
					</div>
				</div>
				<div class="swiper-slide my_slide">
					<div class="img_wrap">
						<div class="article">
								<div class="h1">
									<div class="top" style="background-image:url('${array[2]}');"></div>		
								</div>
						</div>
					</div>
				</div>
			</div>
				<div class="swiper-pagination"></div>
    			<div class="swiper-button-prev"></div>
   				<div class="swiper-button-next"></div>
		</div>
    </div>
		<div id="list" class="list">
			<table>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<font class="a">${vo.id}</font>
					</td>
				</tr>
				<tr>
					<th>품종</th>
					<td>
						<font class="a">${vo.missing_type}</font>
					</td>
				</tr>
				<tr>
					<th>코멘트</th>
					<td>
						<font class="a">${vo.missing_comment}</font>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<font class="a">${vo.tel}</font>
					</td>
				</tr>
				<tr>
					<th>사례금</th>
					<td>
						<font class="a">${vo.tip}</font>
					</td>
				</tr>
			</tbody>
			</table>
		</div>
	</div>
	
	<div class="hAddr">
        <span class="title">지도중심기준 행정동 주소정보</span>
        <span id="centerAddr"></span>
	</div>
	<c:set var="place" value="${vo.missing_place}"></c:set>
	<c:set var="arr" value="${fn:split(place,',')}"></c:set>
	<input type="hidden" id="latitude" value="${arr[0]}">
	<input type="hidden" id="longitude" value="${arr[1]}">
	
	
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043&libraries=services"></script>
   <script type="text/javascript">
      var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
      
      var latitude = document.getElementById('latitude').value;//위도
      var longitude = document.getElementById('longitude').value;//경도
      
      var options = { //지도를 생성할 때 필요한 기본 옵션
         center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
         level: 3 //지도의 레벨(확대, 축소 정도)
      };
      
      var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
      
	  
	  
	  // 마커가 표시될 위치입니다 
	  var markerPosition  = new kakao.maps.LatLng(latitude, longitude); //중심
		
	 //목격동물 마커표시
	 var list= eval('<%=latLng%>');
	  
	 var imageSrc = "https://image.flaticon.com/icons/svg/1688/1688000.svg";
	  
	 for (var i = 0; i < list.length; i ++) {
		    
		    // 목격동물마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 목격동물마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 목격동물 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: list[i].positions, // 마커를 표시할 위치
		        title:list[i].number,
		        image : markerImage // 마커 이미지 
		    });
		}
	  	
	  
	 var imageSrc2="https://image.flaticon.com/icons/svg/25/25607.svg";
	 var imageSize2=new kakao.maps.Size(30,35);
	 var markerImage2=new kakao.maps.MarkerImage(imageSrc2,imageSize2);
	  
	  // 마커를 생성합니다
	  var marker = new kakao.maps.Marker({
	      position: markerPosition,
	      image:markerImage2
	  });


	  // 마커가 지도 위에 표시되도록 설정합니다
	  marker.setMap(map);
      
	  
   </script>
</body>
</html>