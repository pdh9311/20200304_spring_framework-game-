<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>  

<body>
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
					<a href="#listboard"><span class="ion-ios-compose-outline"></span>board</a>
					
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



			<div class="container" style="width:90%; position: relative; top: 80px;">

				<table class="table has-text-white" style="background: bottom;">
					<tr>
						<th class="has-text-white">BNO</th>
						<th class="has-text-white">TITLE</th>
						<th class="has-text-white">WRITER</th>
						<th class="has-text-white">REGDATE</th>
					</tr>
					<c:choose>
						<c:when test="${!empty list}">
							<!-- 목록 출력 -->
							<c:forEach var="board" items="${list}">
								<tr>
									<td>${board.bno}</td>
									<td><a
										href="read${pageMaker.search(pageMaker.cri.page)}&bno=${board.bno}">
											<c:if test="${board.depth != 0}">
												<c:forEach var="i" begin="1" end="${board.depth}">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
							└<!-- ㅂ 한자키 + 6 -->
											</c:if> <c:out value="${board.title}" /> <%--escapeXml="true" [${board.commentCnt}] --%>
									</a></td>
									<td>${board.writer}</td>
									<td><f:formatDate value="${board.regdate}"
											pattern="yyyy-MM-dd" /></td>
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

					<div class="container">
						<div class="pagination is-centered" role="navigation"
							aria-label="pagination">
							<ul class="pagination-list">
								<c:if test="${pageMaker.prev}">
									<li><a class="button"
										href="list${pageMaker.search(pageMaker.startPage-1)}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:if>
								<c:forEach var="i" begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}">
									<li><a class="button"  href="list${pageMaker.search(i)}">${i}</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next}">
									<li><a class="button"
										href="list${pageMaker.search(pageMaker.endPage+1)}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</c:if>
							</ul>
						</div>
					</div>

				<div class="field"  style="position: relative; left:280px; top:10px;">
					<!-- 	<label>Gender</label> -->
					<select class="select is-middle" name="searchType"
						style="height: 40px;">
						<option value="n" hidden disabled selected>Choose...</option>
						<option value="t">TITLE</option>
						<option value="c">CONTENT</option>
						<option value="w">WRITER</option>
						<option value="tc">TITLE & CONTENT</option>
						<option value="cw">CONTENT & WRITER</option>
						<option value="tcw">TITLE & CONTENT & WRITER</option>
					</select> <input type="text" class="input" id="keyword" name="keyword"
						style="width: 20%;" />
					<button type="button" class="button" id="searchBtn">검색</button>
					<c:if test="${!empty userInfo}">
						<button type="button" class="button" id="newBtn">글작성</button>
					</c:if>
				</div>
				<!-- Main container -->



				<div class="nav">
					<a href="#profile" class="nav-item nav-count-1"><i
						class="ion-ios-person-outline"></i><span class="invisible">Profile</span></a>
					<!-- <a href="#compose" class="nav-item nav-count-2"><i
				class="ion-ios-compose-outline"></i><span class="invisible">Compose</span></a>
			<a href="#chats" class="nav-item nav-count-3"><i
				class="ion-ios-chatboxes-outline"></i><span class="invisible">Chats</span></a>
			<a href="#alarm" class="nav-item nav-count-4"><i
				class="ion-ios-alarm-outline"></i><span class="invisible">Alarm</span></a>
			<a href="#toggle" class="mask"><i class="ion-ios-plus-empty"></i></a> -->
				</div>
			</div>
		</div>
		</div>
		</div>
		</body>
<script>
var contextPath = '${pageContext.request.contextPath}';
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
<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>