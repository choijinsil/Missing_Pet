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
		.map{ display:inline; float:left; width: 80%; height: 500px; margin-top: 30px;}
		.list{ display:inline; float:left; background-color: orange; height: 500px; width: 20%; margin-top: 30px;}
		
		.main{color:#0B3861; font-size: 12px bold; position: absolute; margin-left: 100px;}
		#div1{position: absolute; }
		
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
        #section0 .swiper-container { width: 20%; height: 20%; z-index: 20; left:0; top:0; position: absolute; margin-top: 450px;}
		
		.img_wrap{ margin: 0 auto; overflow: hidden; }
		.h1{ width: 100%; margin: 0 2.0% 20px;  float: left;}
		.h1 .top{ height: 200px; background-size: cover; border-bottom: 3px solid #e0e0e0; cursor: pointer;}
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
<body>
	<c:set var="pic" value="${vo.missing_pic}"></c:set>
	<c:set var="array" value="${fn:split(pic,',')}"></c:set>
	<div class="wrap">
		<div id="map" class="map"></div>
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
					<th>사진</th>
					<td>
						<img class="img" src="${array[0]}">
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
	<div id="div1">
		<button id="bt">실종동물</button>
	</div>
	<div class="main">
		<a href="main?action=main">[메인으로]</a>
		<a href="wit?action=wit">목격신고</a>
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
	
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043"></script>
   <script type="text/javascript">
      var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
      var options = { //지도를 생성할 때 필요한 기본 옵션
         center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
         level: 3 //지도의 레벨(확대, 축소 정도)
      };
      
      var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
   </script>
</body>
</html>