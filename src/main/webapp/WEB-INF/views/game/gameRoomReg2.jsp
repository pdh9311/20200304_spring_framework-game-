<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<body class="text-center">

	<form id="createRooom" action="/game/gameRoomRegResult?page=${page}&game_num=${game_num}" method="post" class="form-signin"
		style="width: 100%;height: 30%;margin: 220px auto;max-width: 330px;padding: 15px;">
		<input type="hidden" name="game_name" value="${param.game_name}"/>
		<input type="hidden" name="page" value="${page}"/>
		<input type="hidden" name="game_num" value="${game_num}"/> 
		<h1 class="h2 mb-3 font-weight-normal">Register Room</h1>
	
		<input type="text" name="room_title" class="form-control" placeholder="방제목을 입력하세요" required>
		<hr />
		<div class="btn-group btn-group-toggle btn-block" data-toggle="buttons">
		<button class="btn btn-lg btn-outline-primary " id="roomOk"  type="submit">방 만들기</button>
		<button class="btn btn-lg btn-outline-primary " id="roomCencel" type="submit">돌아가기</button>
		</div>
		<p class="mt-5 mb-3 text-muted">© 2019-2020</p>
	</form>
		
<script>
$("#roomCencel").click(function(){
	location.href="/game/${param.game_name}?page=${page}&game_num=${game_num}&game_name=${param.game_name}";
	//location.href="/game/${param.game_name}?page=${page}&game_num=${game_num}&game_name=${param.game_name}";
});
</script>

	
	

</body>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />