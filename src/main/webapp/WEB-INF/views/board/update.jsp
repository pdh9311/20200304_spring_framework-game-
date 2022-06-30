<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
	<div class="container">
		<div class="py-3">
			<h2>MODIFY BOARD</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1" style="margin: 0 auto;">
			
				<form id="modifyForm" class="needs-validation" action="update" method="post" > 
				<input type="hidden" name="gambler_num" value="${userInfo.gambler_num}"/>	
				<input type="hidden" name="bno" value="${board.bno}"/>
				<input type="hidden" name="page" value="${cri.page}"/>
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
				<input type="hidden" name="searchType" value="${cri.searchType}"/>
				<input type="hidden" name="keyword" value="${cri.keyword}"/>
					<div class="mb-3">
						<label>제목</label> 
						<input type="text" class="form-control" name="title" value="${board.title}" required/>
					</div>

					<div class="mb-3">
						<label>작성자</label> 
						<input type="text" class="form-control" name="writer" value="${userInfo.gambler_name}" readonly/>
					</div>

					<div class="mb-3">
						<label>내용</label> 
					 	<textarea class="form-control" name="content" rows="3">${board.content}</textarea>
					</div>
					
					<hr class="mb-4">
					<button class="btn btn-warning btn-lg btn-block" type="submit" >수정</button>
					<br />
				</form>
				
			</div>
		</div>

	</div>
	
</body>
