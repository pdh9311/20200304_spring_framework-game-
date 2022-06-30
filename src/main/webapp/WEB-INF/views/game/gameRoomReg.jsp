<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<body>


<div class="mobile-wrap">
	<div class="mobile clearfix" style="overflow-x:hidden;">

		<!-- 메뉴버튼 영역 -->
		<div class="header">
			<span class="ion-ios-navicon pull-left"><i></i></span> <span
				class="title">Home</span> <span class="ion-ios-search pull-right"></span>
			<div class="search">
				<form method="post">
					<input type="search" placeholder="Search Here">
				</form>
			</div>
		</div>
		<!-- 메뉴버튼 영역 -->


		<!--사이드바 영역   -->
		<div class="sidebar">
			<div class="sidebar-overlay"></div>
			<div class="sidebar-content">

				<!-- 로그인 회원가입 버튼 -->
				<div class="top-head">
					<div class="name">Mohan Khadka</div>
					<div class="email">contact@mohankhadka.com.np</div>
				</div>
				<!-- 로그인 회원가입 버튼 -->

				<!--메뉴 선택  -->
				<div class="nav-left">
					<a href="#home"><span class="ion-ios-home-outline"></span> Home</a>
					<a href="#listgame"><span class="ion-ios-list-outline"></span> game</a>
					<a href="#listboard"><span class="ion-ios-compose-outline"></span> board</a>
				</div>
				<!--메뉴 선택  -->
			</div>
		</div>
		<!--사이드바 영역   -->



		<div class="content">

<!-- 메인화면  시간  
			<div class="html welcome visible">
				<div class="datetime">
					<div class="day lightSpeedIn animated"></div>
					<div class="date lightSpeedIn animated"></div>
					<div class="time lightSpeedIn animated"></div>
				</div>
			</div>
-->

<!-- 메인화면  -->

<form id="createRooom" action="/game/gameRoomRegResult?page=${page}&game_num=${game_num}" method="post" class=""
	style="width: 100%;height: 30%;margin: 100px auto;max-width: 330px;padding: 15px;">
	
	<input type="hidden" name="game_name" value="${param.game_name}"/>
	<input type="hidden" name="page" value="${page}"/>
	<input type="hidden" name="game_num" value="${game_num}"/> 
	<h1 class="">Register Room</h1>

	<input type="text" name="room_title" class="input is-rounded is-hovered" placeholder="방제목을 입력하세요" required>
	<hr />
	<button class="button is-danger is-rounded is-small " id="roomOk"  type="submit">방 만들기</button>
	<button class="button is-danger is-rounded is-small " id="roomCencel" type="button">돌아가기</button>
</form>
		
<script>
$("#roomCencel").click(function(){
	location.href="/game/${param.game_name}?page=${page}&game_num=${game_num}&game_name=${param.game_name}";
});
</script>


<!-- 메인화면  -->		
		</div>
		<div class="nav">
			<a href="#profile" class="nav-item nav-count-1"><i
				class="ion-ios-person-outline"></i><span class="invisible">Profile</span></a>
			<a href="#compose" class="nav-item nav-count-2"><i
				class="ion-ios-compose-outline"></i><span class="invisible">Compose</span></a>
			<a href="#chats" class="nav-item nav-count-3"><i
				class="ion-ios-chatboxes-outline"></i><span class="invisible">Chats</span></a>
			<a href="#alarm" class="nav-item nav-count-4"><i
				class="ion-ios-alarm-outline"></i><span class="invisible">Alarm</span></a>
			<a href="#toggle" class="mask"><i class="ion-ios-plus-empty"></i></a>
		</div>
		
	</div>
</div>


</body>
<script>var contextPath = '${pageContext.request.contextPath}';</script>
