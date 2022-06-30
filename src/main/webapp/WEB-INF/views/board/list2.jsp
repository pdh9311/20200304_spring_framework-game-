<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
<div class="container">
		<div class="py-3">
			<h2>자유게시판</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1">
					
					<div class="row">
						<div class="col-md-5 mb-3">
							<select class="custom-select d-block w-100" name="searchType">
								<option value="n" hidden disabled selected>Choose...</option>
								<option value="t">TITLE</option>
								<option value="c">CONTENT</option>
								<option value="w">WRITER</option>
								<option value="tc">TITLE & CONTENT</option>
								<option value="cw">CONTENT & WRITER</option>
								<option value="tcw">TITLE & CONTENT & WRITER</option>
							</select>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6 mb-3">
							<div class="input-group">
								<input type="text" class="form-control" id="keyword" name="keyword" />
								<div class="input-group-append">
									<button type="button" class="btn btn-outline-secondary"	id="searchBtn">검색</button>
									<c:if test="${!empty userInfo}">	
									<button type="button" class="btn btn-outline-secondary"	id="newBtn">글작성</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					
					
					
	<table class="table table-bordered table-striped table-sm">
	<tr>
		<th>BNO</th>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>REGDATE</th>
	</tr>
	<c:choose>
	<c:when test="${!empty list}">
		<!-- 목록 출력 -->
		<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.bno}</td>
				<td>
					<a href="read${pageMaker.search(pageMaker.cri.page)}&bno=${board.bno}">
						 <c:if test="${board.depth != 0}">
							<c:forEach var="i" begin="1" end="${board.depth}">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
							└<!-- ㅂ 한자키 + 6 -->
						</c:if> 
						<c:out value="${board.title}" /><%--escapeXml="true" [${board.commentCnt}] --%>
					</a>
				</td>
				<td>
					${board.writer}
				</td>
				<td>
					<f:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan=5>등록된 게시물이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</table>
	
	
	<div class="mt-4 mb-3" style="margin:0 auto;">	
		<nav aria-label="Page navigation example">
		  <ul class="pagination">
		  <c:if test="${pageMaker.prev}">
		    <li class="page-item">
		      <a class="page-link" href="list${pageMaker.search(pageMaker.startPage-1)}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		   </c:if>
		    <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		    <li class="page-item"><a class="page-link" href="list${pageMaker.search(i)}">${i}</a></li>
		    </c:forEach>
		    <c:if test="${pageMaker.next}">
		    <li class="page-item">
		      <a class="page-link" href="list${pageMaker.search(pageMaker.endPage+1)}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
	    	</c:if>
		  </ul>
		</nav>	
	</div>		
			
		</div>
	</div>
</div>	
					
		
<script>
	$("#searchBtn").click(function(){
		var searchValue = $("select option:selected").val();
		var keywordValue = $("#keyword").val();
		console.log("searchValue : " + searchValue + " | " + "keywordValue : " + keywordValue);
		location.href="list?searchType="+searchValue+"&keyword="+keywordValue;
	});
	
	$("#newBtn").click(function(){
		location.href="write";
	});
</script>
</body>
