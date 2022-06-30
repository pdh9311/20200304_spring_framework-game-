<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<body class="text-center">

	<div class="container">
		<div style="margin: 30px; padding: 30px;">
			<button type="button" class="btn btn-outline-info" 
			onclick="location.href='gameRoomReg?page=${page}&game_num=${game_num}&game_name=${game_name}'">방 만들기</button>
			<button type="button" class="btn btn-outline-info" onclick="javascript:location.reload();">새로고침</button> 
		</div>
	</div>

	
	<div class="container">
	  <div class="row">
		
		
		<c:forEach var="room" items="${room}">
			<div class="col-6">
				<div class="bd-example">
					<div class="list-group">
						<a href="sutda?page=${page}&game_num=${game_num}&roomPage=${roomPage.roomCri.roomPage}&room_num=${room.room_num}&game_name=${game_name}" class="list-group-item list-group-item-action">
						
							<div class="d-flex w-100 justify-content-between">
							<c:choose>
								<c:when test="${room.playStatus}">
								<h5 class="mb-1">PLAYING</h5>
								</c:when>
								<c:otherwise>
								<h5 class="mb-1">WAITING</h5>
								</c:otherwise>
							</c:choose>	
								<small class="text-muted">Room ${room.room_num}</small>
							</div>
							<p class="mb-1">${room.room_title}.</p> 
								<%-- <small class="text-muted">${room.game_name}</small> --%>
						</a> 
					</div>
				</div>
			</div>
		</c:forEach>
			
		</div>
	</div>
	
	<div class="container mt-4">
		<div class="row justify-content-md-center">
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		  <c:if test="${roomPage.roomPrev}">
		    <li class="page-item">
		      <a class="page-link" href="${roomPage.roomCri.roomPage-1}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    </c:if>
		    <c:if test="${roomPage.roomNext}">
		    <li class="page-item">
		      <a class="page-link" href="${roomPage.roomCri.roomPage+1}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		    </c:if>
		  </ul>
		</nav>
		</div>
	</div>
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
</body>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />