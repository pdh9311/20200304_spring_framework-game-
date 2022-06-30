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
		<div class="">
			<button type="button" class="button is-danger is-rounded is-small" 
			onclick="location.href='gameRoomReg?page=${page}&game_num=${game_num}&game_name=${game_name}'">방 만들기</button>
			<button type="button" class="button is-danger is-rounded is-small" onclick="javascript:location.reload();">새로고침</button> 
		</div>
	<hr/>
	
	<nav class="columns">
	<div class="column is-full">
		<c:forEach var="room" items="${room}">
		<div class="column is-6 is-pulled-left is-paddingless" style="background:bottom;border:1px solid white;">
			<a class="bd-focus-item column has-text-centered" 
				href="sutda?page=${page}&game_num=${game_num}&roomPage=${roomPage.roomCri.roomPage}&room_num=${room.room_num}&game_name=${game_name}">
		      
		      <p class="title is-size-5">
		      		<small class="">[Room. ${room.room_num}]</small>
					<small>${room.room_title}</small>
		      </p>
		    	<c:choose>
					<c:when test="${room.playStatus}">
					<p class="subtitle is-6">PLAYING</p>
					</c:when>
					<c:otherwise>
					<p class="subtitle is-6">WAITING</p>
					</c:otherwise>
				</c:choose>	
		    </a>
		    </div>
		</c:forEach>
		</div>
	</nav>
		<nav class="pagination is-rounded is-centered" role="navigation" aria-label="pagination">
		  <ul class="pagination-list" style="list-style:none;">
		  <c:if test="${roomPage.roomPrev}">
		    <li class="page-item">
		      <a class="pagination-previous" href="${roomPage.roomCri.roomPage-1}">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    </c:if>
		    <c:if test="${roomPage.roomNext}">
		    <li class="page-item">
		      <a class="pagination-next" href="${roomPage.roomCri.roomPage+1}">
		        <span>&raquo;</span>
		      </a>
		    </li>
		    </c:if>
		  </ul>
		</nav>
	
	<form id="roomInfo">
			<input type="hidden" name=page value="${page}"/>
			<input type="hidden" name=game_num value="${game_num}"/>
			<input type="hidden" name="game_name" value="${game_name}"/>
			<input type="hidden" name="roomPage" value="${roomPage.roomCri.roomPage}"/>
			<%-- <input type="hidden" name="roomPerPageNum" value="${roomPage.roomCri.roomPerPageNum}"/> --%>
		</form>
	
<script>
$(".page-item a").on("click",function(event){
	 event.preventDefault();
	 var roomTargetPage = $(this).attr("href");
	 var roomPageInfo = $("#roomInfo");
	 roomPageInfo.find("[name='roomPage']").val(roomTargetPage);
	 roomPageInfo.attr("action","/game/seodda").attr("method","GET");
	 roomPageInfo.submit();
});

$(document).ready(function(){
	
	setTimeout(function() {
		location.reload();
	}, 5000);
});
/* 
	var message = '${message}';
	if(message != null && message != '') { alert(message); }
 */	
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
