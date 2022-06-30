<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
	<div class="container">
		<div class="py-3">
			<h2>READ PAGE</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1" style="margin: 0 auto;">
			
				<form id="readForm" class="needs-validation"> 
				<input type="hidden" name="gambler_num" value="${userInfo.gambler_num}"/>	
					<div class="mb-3">
						<label>제목</label> 
						<input type="text" class="form-control" name="title" value="${board.title}" required/>
					</div>

					<div class="mb-3">
						<label>내용</label> 
					 	<textarea class="form-control" name="content" rows="3" >${board.content}</textarea>
					</div>

					<div class="mb-3">
						<label>작성자</label> 
						<input type="text" class="form-control" name="writer" value="${userInfo.gambler_name}" readonly/>
					</div>
					
					<hr class="mb-4">
					<div class="btn-group mb-4 container" role="group" >
					<c:if test="${!empty userInfo}">
						<c:if test="${userInfo.gambler_num eq board.gambler_num}">
							<button class="btn btn-outline-warning btn-lg " id="modifyBtn" type="button" >MODIFY</button>
							<button class="btn btn-outline-danger btn-lg " id="deleteBtn" type="button" >DELETE</button>
						</c:if>
							<button class="btn btn-outline-primary btn-lg " id="replyBtn" type="button" >REPLY</button>
						</c:if>
							<button class="btn btn-outline-success btn-lg " id="listBtn" type="button" >LIST</button>
					</div>
					
					<br />
					
					<input type="hidden" name="bno" value="${board.bno}"/>
					<input type="hidden" name="page" value="${cri.page}"/>
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
					<input type="hidden" name="searchType" value="${cri.searchType}"/>
					<input type="hidden" name="keyword" value="${cri.keyword}"/>
				</form>
				
			</div>
		</div>
<script>var contextPath = '${pageContext.request.contextPath}';</script>
<%@ include  file="/WEB-INF/views/comment/comment.jsp" %>
	</div>
		
<script>
	var obj = $("#readForm");
	
	$("#listBtn").click(function(){
		obj.attr("action","list");
		obj.submit();
	});
	
	$("#replyBtn").click(function(){
		obj.attr("action","replywrite");
		obj.submit();
	});
	
	$("#modifyBtn").click(function(){
		obj.attr("action","update");
		obj.submit();
	});
	$("#deleteBtn").click(function(){
		/* 	
			var isDelete = confirm("첨부된 파일이 모두 삭제 됩니다. 삭제하시겠습니까?");
			if(isDelete){
				 */
		/* 		var arr = [];
				$(".uploadedList li").each(function(index){
					arr.push($(this).attr("data-src"));
				});
				
				if(arr.length > 0){
					$.post(contextPath+"/deleteAllFiles", {files : arr} , function(result){
						alert(result);
					});
				} */
				obj.attr("action","remove").submit();
				/* obj.attr("action","remove"); */
		/* 		obj.attr("method","post");
				obj.submit();	
			}else{
				alert("삭제 요청이 취소되었습니다.");
			} */
		});
	
</script>
</body>
