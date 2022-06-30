<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
	<div class="container">
		<div class="py-3">
			<h2>Register Game</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1" style="margin: 0 auto;">
				<form class="needs-validation" action="gameRegResult" method="post" enctype="multipart/form-data"> 
					<div class="mb-3">
						<label>TITLE</label> 
						<input type="text" class="form-control" name="game_title" />
					</div>

					<div class="mb-3">
						<label>WRITER</label> 
						<input type="text" class="form-control" name="game_writer" value="${userInfo.gambler_id}" readonly/>
					</div>

					<div class="mb-3">
						<label>CONTENT</label> 
					 	<textarea class="form-control" name="game_content" rows="3"></textarea>
					</div>

					<div class="form-group">
						<label for="profileImage">Game Thumbnail</label>
						<div><input type="file"  name="file" id="profileImage" name="game_thumbnail" /></div>
					</div>
					
					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block" type="submit" >Create Account</button>
					<br />
				</form>
			</div>
		</div>

	</div>
	
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />