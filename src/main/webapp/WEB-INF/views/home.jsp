<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<div class="mobile-wrap">
	<div class="mobile clearfix">

		<!-- 메뉴버튼 영역 -->
		<div class="header">
			<span class="ion-ios-navicon pull-left"><i></i></span> <span
				class="ion-ios-search pull-right"></span>
			<%-- <div class="search">
				<form method="post">
					<input type="search" placeholder="Search Here">
				</form>
			</div> --%>
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

			<!-- 메인화면  시간  -->

			<!-- 

			<div class="html welcome visible">
				<div class="datetime">
					<div class="day lightSpeedIn animated"></div>
					<div class="date lightSpeedIn animated"></div>
					<div class="time lightSpeedIn animated"></div>
				</div>
			</div>
			메인화면  -->



		<div class="content">
		
			</div>
			
			<div class="html compose">
				<div class="forms">
					<div class="group clearfix slideInRight animated">
						<label class="pull-left" for="compose-time"><span class="ion-ios-time-outline"></span> Time</label>
						<input class="pull-right" id="compose-time" type="time">
					</div>
					<div class="group clearfix slideInLeft animated">
						<label class="pull-left" for="compose-date"><span class="ion-ios-calendar-outline"></span> Date</label>
						<input class="pull-right" id="compose-date" type="date">
					</div>
					<div class="group clearfix slideInRight animated">
						<label class="pull-left" for="compose-title"><span class="ion-ios-paper-outline"></span> Title</label>
						<input class="pull-right" id="compose-title" type="text">
					</div>
					<div class="group clearfix slideInLeft animated">
						<label class="visible" for="compose-detail"><span class="ion-ios-list-outline"></span> Task</label>
						<textarea class="visible" id="compose-detail" rows="3"></textarea>
					</div>
					<div class="action flipInY animated">
						<button class="btn">Compose</button>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
</div>
</body>
<script>
var contextPath = '${pageContext.request.contextPath}';

</script>

<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>