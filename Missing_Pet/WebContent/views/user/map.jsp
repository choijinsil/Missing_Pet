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
	    
	    
	    .dot {overflow:hidden;float:left;width:12px;height:12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
		.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
		.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
		.number {font-weight:bold;color:#ee6152;}
		.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
		.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
		.distanceInfo .label {display:inline-block;width:50px;}
		.distanceInfo:after {content:none;}
		
		
		.node {
		    position: absolute;
		    background-image: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/sign-info-64.png);
		    cursor: pointer;
		    width: 64px;
		    height: 64px;
		}
		
		
		.tracker {
		    position: absolute;
		    margin: -35px 0 0 -30px;
		    display: none;
		    cursor: pointer;
		    z-index: 3;
		}
		
		.icon {
		    position: absolute;
		    left: 6px;
		    top: 9px;
		    width: 48px;
		    height: 48px;
		    background-image: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/sign-info-48.png);
		}
		
		.balloon {
		    position: absolute;
		    width: 60px;
		    height: 60px;
		    background-image: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/balloon.png);
		    -ms-transform-origin: 50% 34px;
		    -webkit-transform-origin: 50% 34px;
		    transform-origin: 50% 34px;
		}
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
   
	//마커 트래커 표시 ------------------------------------------------------------------------------------------------------
   /**
    * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
    * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
    */
   function MarkerTracker(map, target) {
       // 클리핑을 위한 outcode
       var OUTCODE = {
           INSIDE: 0, // 0b0000
           TOP: 8, //0b1000
           RIGHT: 2, // 0b0010
           BOTTOM: 4, // 0b0100
           LEFT: 1 // 0b0001
       };
       
       // viewport 영역을 구하기 위한 buffer값
       // target의 크기가 60x60 이므로 
       // 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
       var BOUNDS_BUFFER = 30;
       
       // 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
       // 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
       // 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
       // 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
       var CLIP_BUFFER = 40;

       // trakcer 엘리먼트
       var tracker = document.createElement('div');
       tracker.className = 'tracker';

       // 내부 아이콘
       var icon = document.createElement('div');
       icon.className = 'icon';

       // 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
       var balloon = document.createElement('div');
       balloon.className = 'balloon';

       tracker.appendChild(balloon);
       tracker.appendChild(icon);

       map.getNode().appendChild(tracker);

       // traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
       tracker.onclick = function() {
           map.setCenter(target.getPosition());
           setVisible(false);
       };

       // target의 위치를 추적하는 함수
       function tracking() {
           var proj = map.getProjection();
           
           // 지도의 영역을 구합니다.
           var bounds = map.getBounds();
           
           // 지도의 영역을 기준으로 확장된 영역을 구합니다.
           var extBounds = extendBounds(bounds, proj);

           // target이 확장된 영역에 속하는지 판단하고
           if (extBounds.contain(target.getPosition())) {
               // 속하면 tracker를 숨깁니다.
               setVisible(false);
           } else {
               // target이 영역 밖에 있으면 계산을 시작합니다.
               
               // TooltipMarker의 위치
               var pos = proj.containerPointFromCoords(target.getPosition());
               
               // 지도 중심의 위치
               var center = proj.containerPointFromCoords(map.getCenter());

               // 현재 보이는 지도의 영역의 남서쪽 화면 좌표
               var sw = proj.containerPointFromCoords(bounds.getSouthWest());
               
               // 현재 보이는 지도의 영역의 북동쪽 화면 좌표
               var ne = proj.containerPointFromCoords(bounds.getNorthEast());
               
               // 클리핑할 가상의 내부 영역을 만듭니다.
               var top = ne.y + CLIP_BUFFER;
               var right = ne.x - CLIP_BUFFER;
               var bottom = sw.y - CLIP_BUFFER;
               var left = sw.x + CLIP_BUFFER;

               // 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
               var clipPosition = getClipPosition(top, right, bottom, left, center, pos);
               
               // 클리핑된 좌표를 tracker의 위치로 사용합니다.
               tracker.style.top = clipPosition.y + 'px';
               tracker.style.left = clipPosition.x + 'px';

               // 말풍선의 회전각을 얻습니다.
               var angle = getAngle(center, pos);
               
               // 회전각을 CSS transform을 사용하여 지정합니다.
               // 브라우저 종류에따라 표현되지 않을 수도 있습니다.
               // http://caniuse.com/#feat=transforms2d
               balloon.style.cssText +=
                   '-ms-transform: rotate(' + angle + 'deg);' +
                   '-webkit-transform: rotate(' + angle + 'deg);' +
                   'transform: rotate(' + angle + 'deg);';

               // target이 영역 밖에 있을 경우 tracker를 노출합니다.
               setVisible(true);
           }
       }

       function extendBounds(bounds, proj) {
           // 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
           // 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
           // 픽셀 단위인 화면 좌표로 변환해야 합니다.
           var sw = proj.pointFromCoords(bounds.getSouthWest());
           var ne = proj.pointFromCoords(bounds.getNorthEast());

           // 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
           sw.x -= BOUNDS_BUFFER;
           sw.y += BOUNDS_BUFFER;

           ne.x += BOUNDS_BUFFER;
           ne.y -= BOUNDS_BUFFER;

           // 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
           // extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
           return new kakao.maps.LatLngBounds(
                           proj.coordsFromPoint(sw),proj.coordsFromPoint(ne));
           
       }


       // Cohen–Sutherland clipping algorithm
       // 자세한 내용은 아래 위키에서...
       // https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
       function getClipPosition(top, right, bottom, left, inner, outer) {
           function calcOutcode(x, y) {
               var outcode = OUTCODE.INSIDE;

               if (x < left) {
                   outcode |= OUTCODE.LEFT;
               } else if (x > right) {
                   outcode |= OUTCODE.RIGHT;
               }

               if (y < top) {
                   outcode |= OUTCODE.TOP;
               } else if (y > bottom) {
                   outcode |= OUTCODE.BOTTOM;
               }

               return outcode;
           }

           var ix = inner.x;
           var iy = inner.y;
           var ox = outer.x;
           var oy = outer.y;

           var code = calcOutcode(ox, oy);

           while(true) {
               if (!code) {
                   break;
               }

               if (code & OUTCODE.TOP) {
                   ox = ox + (ix - ox) / (iy - oy) * (top - oy);
                   oy = top;
               } else if (code & OUTCODE.RIGHT) {
                   oy = oy + (iy - oy) / (ix - ox) * (right - ox);        
                   ox = right;
               } else if (code & OUTCODE.BOTTOM) {
                   ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
                   oy = bottom;
               } else if (code & OUTCODE.LEFT) {
                   oy = oy + (iy - oy) / (ix - ox) * (left - ox);     
                   ox = left;
               }

               code = calcOutcode(ox, oy);
           }

           return {x: ox, y: oy};
       }

       // 말풍선의 회전각을 구하기 위한 함수
       // 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
       function getAngle(center, target) {
           var dx = target.x - center.x;
           var dy = center.y - target.y ;
           var deg = Math.atan2( dy , dx ) * 180 / Math.PI; 

           return ((-deg + 360) % 360 | 0) + 90;
       }
       
       // tracker의 보임/숨김을 지정하는 함수
       function setVisible(visible) {
           tracker.style.display = visible ? 'block' : 'none';
       }
       
       // Map 객체의 'zoom_start' 이벤트 핸들러
       function hideTracker() {
           setVisible(false);
       }
       
       // target의 추적을 실행합니다.
       this.run = function() {
           kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
           kakao.maps.event.addListener(map, 'zoom_changed', tracking);
           kakao.maps.event.addListener(map, 'center_changed', tracking);
           tracking();
       };
       
       // target의 추적을 중지합니다.
       this.stop = function() {
           kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
           kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
           kakao.maps.event.removeListener(map, 'center_changed', tracking);
           setVisible(false);
       };
   }
   
   
   
   //실종동물 마커 표시 ------------------------------------------------------------------------------------------------------
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
	  
	  
	  
	//중심좌표의 주소를 지도 상단에 표시 ------------------------------------------------------------------------------------------------------
	
		// 주소-좌표 변환 객체를 생성합니다
	    var geocoder = new kakao.maps.services.Geocoder();
	  
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
	  
	  
		
   //목격동물 마커 표시 ------------------------------------------------------------------------------------------------------
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
		    
		    var markerTracker = new MarkerTracker(map, marker);
		    markerTracker.run();
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
      
  	  var markerTracker = new MarkerTracker(map, marker);
	  
	  markerTracker.run();
	  
	  
	//실종동물 원 표시 ------------------------------------------------------------------------------------------------------
		  var circle = new kakao.maps.Circle({
		      center : new kakao.maps.LatLng(latitude, longitude),  // 원의 중심좌표 입니다 
		      radius: 300, // 미터 단위의 원의 반지름입니다 
		      strokeWeight: 5, // 선의 두께입니다 
		      strokeColor: '#75B8FA', // 선의 색깔입니다
		      strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		      strokeStyle: 'dashed', // 선의 스타일 입니다
		      fillColor: '#CFE7FF', // 채우기 색깔입니다
		      fillOpacity: 0.7  // 채우기 불투명도 입니다   
		  }); 
	
		  // 지도에 원을 표시합니다 
		  circle.setMap(map);
		  
		
		  
		  
	//선 표시 ------------------------------------------------------------------------------------------------------		  
		  var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
		  var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
		  var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
		  var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
		  var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

		  // 지도에 클릭 이벤트를 등록합니다
		  // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
		  kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

		      // 마우스로 클릭한 위치입니다 
		      var clickPosition = mouseEvent.latLng;

		      // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
		      if (!drawingFlag) {

		          // 상태를 true로, 선이 그리고있는 상태로 변경합니다
		          drawingFlag = true;
		          
		          // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
		          deleteClickLine();
		          
		          // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
		          deleteDistnce();

		          // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
		          deleteCircleDot();
		      
		          // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
		          clickLine = new kakao.maps.Polyline({
		              map: map, // 선을 표시할 지도입니다 
		              path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
		              strokeWeight: 3, // 선의 두께입니다 
		              strokeColor: '#db4040', // 선의 색깔입니다
		              strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		              strokeStyle: 'solid' // 선의 스타일입니다
		          });
		          
		          // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
		          moveLine = new kakao.maps.Polyline({
		              strokeWeight: 3, // 선의 두께입니다 
		              strokeColor: '#db4040', // 선의 색깔입니다
		              strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		              strokeStyle: 'solid' // 선의 스타일입니다    
		          });
		      
		          // 클릭한 지점에 대한 정보를 지도에 표시합니다
		          displayCircleDot(clickPosition, 0);

		              
		      } else { // 선이 그려지고 있는 상태이면

		          // 그려지고 있는 선의 좌표 배열을 얻어옵니다
		          var path = clickLine.getPath();

		          // 좌표 배열에 클릭한 위치를 추가합니다
		          path.push(clickPosition);
		          
		          // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
		          clickLine.setPath(path);

		          var distance = Math.round(clickLine.getLength());
		          displayCircleDot(clickPosition, distance);
		      }
		  });
		      
		  // 지도에 마우스무브 이벤트를 등록합니다
		  // 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
		  kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

		      // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
		      if (drawingFlag){
		          
		          // 마우스 커서의 현재 위치를 얻어옵니다 
		          var mousePosition = mouseEvent.latLng; 

		          // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
		          var path = clickLine.getPath();
		          
		          // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
		          var movepath = [path[path.length-1], mousePosition];
		          moveLine.setPath(movepath);    
		          moveLine.setMap(map);
		          
		          var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
		              content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
		          
		          // 거리정보를 지도에 표시합니다
		          showDistance(content, mousePosition);   
		      }             
		  });                 

		  // 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
		  // 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
		  kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

		      // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
		      if (drawingFlag) {
		          
		          // 마우스무브로 그려진 선은 지도에서 제거합니다
		          moveLine.setMap(null);
		          moveLine = null;  
		          
		          // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
		          var path = clickLine.getPath();
		      
		          // 선을 구성하는 좌표의 개수가 2개 이상이면
		          if (path.length > 1) {

		              // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
		              if (dots[dots.length-1].distance) {
		                  dots[dots.length-1].distance.setMap(null);
		                  dots[dots.length-1].distance = null;    
		              }

		              var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
		                  content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
		                  
		              // 그려진 선의 거리정보를 지도에 표시합니다
		              showDistance(content, path[path.length-1]);  
		               
		          } else {

		              // 선을 구성하는 좌표의 개수가 1개 이하이면 
		              // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
		              deleteClickLine();
		              deleteCircleDot(); 
		              deleteDistnce();

		          }
		          
		          // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
		          drawingFlag = false;          
		      }  
		  });    

		  // 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
		  function deleteClickLine() {
		      if (clickLine) {
		          clickLine.setMap(null);    
		          clickLine = null;        
		      }
		  }

		  // 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
		  // 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
		  function showDistance(content, position) {
		      
		      if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
		          
		          // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
		          distanceOverlay.setPosition(position);
		          distanceOverlay.setContent(content);
		          
		      } else { // 커스텀 오버레이가 생성되지 않은 상태이면
		          
		          // 커스텀 오버레이를 생성하고 지도에 표시합니다
		          distanceOverlay = new kakao.maps.CustomOverlay({
		              map: map, // 커스텀오버레이를 표시할 지도입니다
		              content: content,  // 커스텀오버레이에 표시할 내용입니다
		              position: position, // 커스텀오버레이를 표시할 위치입니다.
		              xAnchor: 0,
		              yAnchor: 0,
		              zIndex: 3  
		          });      
		      }
		  }

		  // 그려지고 있는 선의 총거리 정보와 
		  // 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
		  function deleteDistnce () {
		      if (distanceOverlay) {
		          distanceOverlay.setMap(null);
		          distanceOverlay = null;
		      }
		  }

		  // 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
		  // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
		  function displayCircleDot(position, distance) {

		      // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
		      var circleOverlay = new kakao.maps.CustomOverlay({
		          content: '<span class="dot"></span>',
		          position: position,
		          zIndex: 1
		      });

		      // 지도에 표시합니다
		      circleOverlay.setMap(map);

		      if (distance > 0) {
		          // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
		          var distanceOverlay = new kakao.maps.CustomOverlay({
		              content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
		              position: position,
		              yAnchor: 1,
		              zIndex: 2
		          });

		          // 지도에 표시합니다
		          distanceOverlay.setMap(map);
		      }

		      // 배열에 추가합니다
		      dots.push({circle:circleOverlay, distance: distanceOverlay});
		  }

		  // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
		  function deleteCircleDot() {
		      var i;

		      for ( i = 0; i < dots.length; i++ ){
		          if (dots[i].circle) { 
		              dots[i].circle.setMap(null);
		          }

		          if (dots[i].distance) {
		              dots[i].distance.setMap(null);
		          }
		      }

		      dots = [];
		  }

		  // 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
		  // 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
		  // HTML Content를 만들어 리턴하는 함수입니다
		  function getTimeHTML(distance) {

		      // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
		      var walkkTime = distance / 67 | 0;
		      var walkHour = '', walkMin = '';

		      // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
		      if (walkkTime > 60) {
		          walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
		      }
		      walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

		      // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
		      var bycicleTime = distance / 227 | 0;
		      var bycicleHour = '', bycicleMin = '';

		      // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
		      if (bycicleTime > 60) {
		          bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
		      }
		      bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

		      // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
		      var content = '<ul class="dotOverlay distanceInfo">';
		      content += '    <li>';
		      content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
		      content += '    </li>';
		      content += '    <li>';
		      content += '        <span class="label">도보</span>' + walkHour + walkMin;
		      content += '    </li>';
		      content += '    <li>';
		      content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
		      content += '    </li>';
		      content += '</ul>'

		      return content;
		  }
   </script>
</body>
</html>