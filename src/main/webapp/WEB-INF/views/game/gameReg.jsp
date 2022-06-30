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

	<form action="gameRegResult" method="post" enctype="multipart/form-data"
		style="width: 100%;height: 30%;margin: 20px auto;max-width: 330px;padding: 15px;"> 
		<h2>Register Game</h2>
		<div class="field">
			<label class="label">TITLE</label> 
			<div class="control">
				<input type="text" class="input" name="game_title" />
			</div>
		</div>
		
		<div class="field">
			<label class="label">WRITER</label> 
			<div class="control">
			<input type="text" class="input" name="game_writer" value="${userInfo.gambler_id}" readonly/>
			</div>
		</div>

		<div class="field">
			<label class="label">CONTENT</label> 
			<div class="control">
		 	<textarea class="textarea" name="game_content" rows="3"></textarea>
		 	</div>
		</div>

		<div class="form-group">
			<label class="label" for="profileImage">Game Thumbnail</label>
			<div class="control">
			<input type="file"  name="file" id="profileImage" name="game_thumbnail" />
			</div>
		</div>
		
		<hr class="field">
		<button class="button is-danger is-rounded is-small " type="submit">게임목록 생성</button>
		<button class="button is-danger is-rounded is-small " id="backGameList" type="button">취소</button>
		<br />
	</form>
	
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

<script>
$("#backGameList").click(function(){
	location.href="/game/gameList";
});
</script>


</body>
<script>var contextPath = '${pageContext.request.contextPath}';</script>
