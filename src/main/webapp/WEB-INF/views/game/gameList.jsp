<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

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
			<h1>Game List</h1>
			<%-- <c:if test="${userInfo.gambler_id == 'admin@admin.com' }"> --%>
				<a href="gameReg">Register Game</a>
			<%-- </c:if> --%>
			
			  <div class="columns is-centered">
			  	<c:forEach var="gList" items="${gList}">	
				<div class="column is-3">		
					<div class="card">
					  <div class="card-image">
					    <figure class="image" style="margin: 0;">
					      <img src="/upload/${gList.game_thumbnail}" alt="Placeholder image" style="height:250px;align-text:center;"/>
					    </figure>
					  </div>
					  
					  <div class="card-content">
					    <div class="content">
					      <p class="title is-4">${gList.game_title}</p>
					      ${gList.game_content}<br/>
					      <%-- <c:if test="${!empty userInfo.gambler_id && userInfo.gambler_cash != 0}"> --%>
						  	<a href="/game/${gList.game_title}?page=${pageMaker.cri.page}&game_num=${gList.game_num}&game_name=${gList.game_title}" class="button is-danger is-rounded is-small">Game Start</a>
					      <%-- </c:if> --%>
					    </div>
					  </div>
					  
					</div>
				</div>
				</c:forEach>
			  </div>
			
				<nav class="pagination is-rounded is-centered is-small" role="navigation" aria-label="pagination">
				  <ul class="pagination-list" style="list-style:none;">
				  <c:if test="${pageMaker.prev}">
				    <li class="page-item">
				      <a class="pagination-previous" href="${pageMaker.startPage - 1}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				   </c:if>
				    <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				    <li class="page-item" ><a class="pagination-link" href="${i}">${i}</a></li>
				    </c:forEach>
				    <c:if test="${pageMaker.next}">
				    <li class="page-item">
				      <a class="pagination-next" href="${pageMaker.endPage + 1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				    </c:if>
				  </ul>
				  <form id="pageInfo">
						<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
						<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
					</form>	
				</nav>	
			<script>
				 $(".pagination-list li a").on("click",function(event){
					 event.preventDefault();
					 var targetPage = $(this).attr("href");
					 var pageInfo = $("#pageInfo");
					 pageInfo.find("[name='page']").val(targetPage);
					 pageInfo.attr("action","/game/gameList").attr("method","GET");
					 pageInfo.submit();
				 });
				 
				 var message = '${message}';
				 if(message != null && message != '') { alert(message); }
				 
			</script>		
			
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








