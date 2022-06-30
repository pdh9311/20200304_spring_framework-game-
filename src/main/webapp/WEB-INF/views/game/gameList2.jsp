<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<h1>Game List</h1>
	<c:if test="${userInfo.gambler_id == 'admin@admin.com' }">
		<a href="gameReg">Register Game</a>
	</c:if>

<div class="gameList-width center ">

	<c:forEach var="gList" items="${gList}">	
		<div class="gameList overflowH">
			<div>
			</div>
			<div class="nes-container is-rounded">
				<c:if test="${!empty userInfo.gambler_id}">
					<%-- <a href="gameStart?page=${pageMaker.cri.page}&game_num=${gList.game_num}" class="nes-badge"> --%>
					<a href="${gList.game_title}?page=${pageMaker.cri.page}&game_num=${gList.game_num}&game_name=${gList.game_title}" class="nes-badge">
	 				 <span class="is-dark">시작하기</span>
					</a>
				</c:if>
	  			<%-- <p>${gList.game_num}</p>
	  			<p>${gList.game_title}</p>
	  			<p>개발자 : ${gList.game_writer}</p>
	  			<p>등록일 : <f:formatDate value="${gList.game_regdate}" pattern="yyyy-MM-dd"/></p>
	  			<p>조회수 : ${gList.game_viewcnt}</p> --%>
	  			<p>설명 : ${gList.game_content}</p>
			</div>	
		</div>
	</c:forEach>
	
	
	
	
	
	
	
	
	
	
	<div style="width:800px; height:10px; clear:both">
		<ul class="pageBlock">
		
			<c:if test="${pageMaker.prev}">
				<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
			</c:if>
			
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li <c:out value="${pageMaker.cri.page == i ? 'class=red' : '' }"/>>
					<a href="${i}">${i}</a>
				</li>
			</c:forEach>
			
			<c:if test="${pageMaker.next}">
				<li><a href="${pageMaker.endPage + 1}">&raquo;</a></li>
			</c:if>
			
		</ul>
		
		<form id="pageInfo">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
		</form>		
		
	</div>
	
</div>
<script>
	 $(".pageBlock li a").on("click",function(event){
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

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>












