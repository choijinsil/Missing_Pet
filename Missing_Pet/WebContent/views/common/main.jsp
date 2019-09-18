<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>mainPage</title>
	<!-- reset.css.로 초기화 -->
	<link rel="stylesheet" href="/css/reset.css">
	
	<!-- auto=가운데정렬, !important=reset.css에 적용된 색상때문에 사용, padding-top=padding값을 위에만 적용, .menu.selected=, wrap이 1000px로 한정되어있기때문에 header와 banner에 따로 padding값을 적용, background-size: cover=이미지가 중복되지않도록 늘림, box-sizing= border를 박스 안에다가 넣어줌, line-height=,-->
	<style>
		.footerImg{
		background-image:url('/images/pet_background1.jpg');
		background-size:contain;
		position: absolute;
		width: 100%;
		height: 30%;
		border-radius: 5px;
		}
		.dropmenu{ position: fixed; left: 50%; margin-left: -500px; top: 0; width: 64px; height: 64px; background: #ff6375; z-index: 10; }
		.dropmenu img{ transition:  all 0.3s ease; transform: rotate(0deg); }
		.dropmenu:hover img{ transform: rotate(180deg); }
		.dropmenu:hover .dropdown{ height: 200px; }
		
		.dropdown{ overflow: hidden; text-align: center; color: #fff; font-size: 16px; line-height: 200px; top: 64px;
					width: 100%; left: 0; height: 0; position: fixed; background: #ff6375; transition: all 300ms; z-index: 9; }
		
		.header{ background: #fff; border-bottom: 1px solid #e0e0e0; overflow: hidden; position: fixed; width: 100%; left: 0; top: 0; }

		.logo{ display: block; float: left; padding: 19px 0 10px 79px;}
		.logo{ display: block; float: left; padding: 19px 0 10px 79px;  }
		.logo img{ height: 31px; }

		body .menu{ display: block; float: right; color: #888; font-size: 16px; padding-top: 38px; margin-right: 25px;}

		.wrap{ width: 1000px; margin: 0 auto; overflow: hidden;} 

		.banner2{ background-color: #efefef; padding: 30px 0; margin-top: 64px;}
		.banner2 .rect{ cursor: pointer; transition: all 300ms; position: relative; background: #fff; padding: 20px 20px 15px; overflow: hidden;}
		.banner2 .title { transition: all 300ms; color: #777; font-size: 16px; float: left; width: 30%;}
		.banner2 .graph { float: left; width: 40%; height: 5px; margin-top: 4px; background: #d4d5d6;}
		.banner2 .graph .fill{ transition: all 300ms; width: 10%; height: 100%; background: #ff6375; }
		.banner2 .text { color: #fff; transition: all 300ms; position: absolute; top: 35px; opacity: 0; right: 0; width: 30%; text-align: center;}
		.banner2:hover .text{top:22px; opacity:1;}	
		.banner2:hover .rect{background:#ff6375;}
		.banner2:hover .title{color:#fff;}
		.banner2:hover .graph{background: #ccc}
		.banner2:hover .fill{background: #fff;}
		
		.article.wrap{padding: 30px 0;}

		.item{ width: 30%; margin: 0 1.5% 20px; border: 1px solid #e0e0e0; box-sizing: border-box; float: left;}
		.item .top{ height: 200px; background-size: cover; padding: 50px; border-bottom: 1px solid #e0e0e0; transition: 300ms; background-repeat: no-repeat;}
		.item .top:hover { transform: scale(1.05); }
		.item .bottom{ padding:20px; }
		.item .bottom .title{ font-size: 16px; font-weight: bold; padding-bottom: 15px; color: #333; }
		.item .bottom .context{ font-size: 12px; line-height: 1.5; height: 45px; color: #777; }

		.footer{ padding: 15px 0 30px; border-top: 2px solid #efefef; margin-top: 40px; overflow: hidden;}
		.footer .left{ float: left; }
		.footer .right{ float: right; overflow: hidden; margin-top: 15px; }

		.left .title{ font-size: 13px; font-weight: bold; color: #444; margin: 20px 0; }
		.left .context{ font-size: 12px; color: #777; margin: 20px 0;}
		.footer .right a{color: #777; font-size: 12px; }
		
		.p1{
			text-align: center;
		}
		.p2{
			text-align: center;
		}
		
		@media(max-width:1000px){.wrap{width:auto;}
								.dropmenu{left:0; margin:0;}
								.article .one{width:auto;float:none;margin:20px;}
								.banner2{display:none;}
								.footer{padding:20px;}
								.article .two{width:auto;float:none;margin:20px;}
								.article .three{width:auto;float:none;margin:20px;}
								.article .four{width:auto;float:none;margin:20px;}
								.article .five{width:auto;float:none;margin:20px;}
								.article .six{width:auto;float:none;margin:20px;}}
		
	</style>
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script>
		var no;
		function move(no){
			location.replace('pet?action=map&no=' +no);
		}
	</script>
</head>
<body>
	<div class="dropmenu">
		<img src="/images/bottom.png"/>
		<div class="dropdown">여기를 자유롭게 채워보세요.</div>
	</div>

	<div class="header">
		<div class="wrap">
			<a href="http://incoding.kr" class="logo">
				<img src="/images/cat.png"/>
			</a>
			<c:choose>
				<c:when test="${loginId eq null }">
					<a href="main?action=joinForm" class="logo" style="color: black;">회원 가입 </a> 
					<a href="main?action=loginForm" class="logo" style="color: black;">로그인</a>
				</c:when>
				
				<c:when test="${loginId eq 'admin'}">
					<a href="admin?action=admin" class="logo" style="color: black;">관리자페이지로 이동</a>
					<a href="main?action=loginOut" class="logo" style="color: black;">로그아웃</a>
				</c:when>
				
				<c:otherwise>
					<a class="logo" style="color: black">
						<font color="green">${loginId }</font>님 환영합니다.~^^
					</a>
					<a href="pet?action=registerForm" class="logo" style="color: black;">동물등록</a>
					<a href="main?action=user_mypage" class="logo" style="color: black;">마이페이지</a> 
					<a href="main?action=loginOut" class="logo" style="color: black;">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="banner2">
		<div class="wrap">
			<div class="rect">
				<div class="title">그동안 찾은 동물들</div>
				<div class="graph">
					<div class="fill"></div> 
				</div>
				<div class="text">클릭해보세요.</div>
			</div>
		</div>
	</div>

	<div class="article wrap">
		<c:forEach items="${list}" var="pet">
			<c:set var="pic" value="${pet.missing_pic}"></c:set>
			<c:set var="array" value="${fn:split(pic,',')}"></c:set>
			<div class="item">
				<div class="top" style="background-image:url('${array[0]}');" onclick="move(${pet.missing_no})"></div>
				<div class="bottom">
					<div class="title"><fmt:formatDate value="${pet.missing_date}" pattern="yyyy-MM-dd hh:mm"/></div>
					<div class="context" name="address"></div>
				</div>
			</div>
			<input name="place" type="hidden" value="${pet.missing_place}">
		</c:forEach>
	</div>
	
	<br>
	<p class="p2">
		<c:if test="${page == 1}">
			이전
		</c:if>
		<c:if test="${page > 1}">
			<a href="/main?action=main&page=${page-1}" style="text-decoration: none; color: black;">이전</a>
		</c:if>
		
			<c:forEach begin="1" end="${totalPage}" var="i">
				<a href="/main?action=main&page=${i}" style="text-decoration: none; color: black;"> [${i}] </a>
			</c:forEach>
			
		<c:if test="${page != totalPage}">
			<a href="/main?action=main&page=${page+1}" style="text-decoration: none; color: black;">다음</a>
		</c:if>
		<c:if test="${page == totalPage}">
			다음
		</c:if>
	</p>
	
	<div class="footer wrap">
		<div class="left">
			<div class="title">beans:beans</div>
			<div class="context">
				우린 누구인가? <br/><br/>
				잃어버린 애완동물을 찾아주는 마법사 ~!<br/><br/>
				<strong><font color="red">후원계좌: 010-8787-5536 기업  </font></strong><br/>
			</div>
		</div>
		<div class="right">
			<a href="" target="_blank">블로그</a>
			<a href="" target="_blank">페이스북</a>
		</div>
		 <div id="map"></div>
		 <span id="centerAddr"></span>
	</div>	
	<div class="footerImg"></div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b34394e2d8b59d2f6ccd7212da74043&libraries=services"></script>
	<script type="text/javascript">

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
		
	var place = $('input[name=place]');
		
	var address = $('div[name=address]');
	
		for(var i=0; i<place.length; i++){
			var lng = place[i].value.split(',')[0];
			var lat = place[i].value.split(',')[1];
			
			var coord = new kakao.maps.LatLng(lng, lat);
			
			var callback = function(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			    	address.html(result[0].address.address_name);
			    }
			};
			
			geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		}

	
	
	</script>
</body>
</html>