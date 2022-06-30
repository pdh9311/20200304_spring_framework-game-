<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<main role="main">
<!-- 
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1" class=""></li>
      <li data-target="#myCarousel" data-slide-to="2" class=""></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active" style="height:300px;">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img"><rect width="100%" height="100%" fill="#777"></rect></svg>
        
        <div class="container">
          <div class="carousel-caption text-left">
            <h1>Example headline.</h1>
            <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item" style="height:300px;">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img"><rect width="100%" height="100%" fill="#777"></rect></svg>
        <div class="container">
          <div class="carousel-caption">
            <h1>Another example headline.</h1>
            <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item" style="height:300px;">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img"><rect width="100%" height="100%" fill="#777"></rect></svg>
        <div class="container">
          <div class="carousel-caption text-right">
            <h1>One more for good measure.</h1>
            <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
          </div>
        </div>
      </div>
    </div>
    
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div> 
 -->
 
 
	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
	      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      <li data-target="#myCarousel" data-slide-to="1" class=""></li>
	      <li data-target="#myCarousel" data-slide-to="2" class=""></li>
	    </ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="/resources/img3/hwato.jpg" height="300px" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="/resources/img3/bbachingko.jpg" height="300px" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="/resources/img3/kyeongma.jpg" height="300px" class="d-block w-100" alt="...">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev"> 
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
			<span class="sr-only">Previous</span>
		</a> 
		<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next"> 
			<span class="carousel-control-next-icon" aria-hidden="true">
			</span> <span class="sr-only">Next</span>
		</a>
	</div>
 
 
	<div class="container marketing mt-5" style="width:100%;" >
    <div class="row">
    <c:forEach var="gList" items="${gList}">	
	    <div class="card" style="width: 18rem;margin: 0 40px 0 40px;">
		  <img src="/upload/${gList.game_thumbnail}" class="card-img-top" alt="..." height="180">
		  <div class="card-body">
		    <h5 class="card-title">${gList.game_title}</h5>
		    <p class="card-text">${gList.game_content}</p>
		    <c:if test="${!empty userInfo.gambler_id && userInfo.gambler_cash != 0}">
			   	<a href="/game/${gList.game_title}?page=${pageMaker.cri.page}&game_num=${gList.game_num}&game_name=${gList.game_title}" class="btn btn-primary">Game Start</a>
		    </c:if>
		  </div>
		</div>
	</c:forEach>
	</div>	
	
	<div class="row justify-content-md-center mt-4 mb-3" style="margin: 0 auto;">	
		<nav aria-label="Page navigation example">
		  <ul class="pagination" >
		  <c:if test="${pageMaker.prev}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.startPage - 1}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		   </c:if>
		    <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		    <li class="page-item" ><a class="page-link" href="${i}">${i}</a></li>
		    </c:forEach>
		    <c:if test="${pageMaker.next}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.endPage + 1}" aria-label="Next">
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
	</div>

    <hr/>
	<p class="float-right"><a href="#">Back to top</a></p>	
  </div>
</main>
<script>
	 $(".pagination li a").on("click",function(event){
		 event.preventDefault();
		 var targetPage = $(this).attr("href");
		 var pageInfo = $("#pageInfo");
		 pageInfo.find("[name='page']").val(targetPage);
		 pageInfo.attr("action","/").attr("method","GET");
		 pageInfo.submit();
	 });
	 
	 var message = '${message}';
	 if(message != null && message != '') { alert(message); }
</script>
</body>

<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>