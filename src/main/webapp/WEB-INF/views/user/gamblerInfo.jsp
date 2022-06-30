<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">

<div class="container">
	<div class="py-3">
			<h2>Gambler Info</h2>
		</div>
	<div class="row justify-content-md-center">
	<div class="table-responsive ">
	<form id="gamblerInfo" method="post">
		<table class="table table-bordered table-striped table-sm">
			<tr>
				<th style="width: 150px;" >ID</th>
				<td>${userInfo.gambler_id}</td>
			</tr>
			<tr>
				<th >Name</th>
				<td>${userInfo.gambler_name}</td>
			</tr>
			<tr>
				<th >Birth</th>
				<td>${userInfo.gambler_birth}</td>
			</tr>
			<tr>
				<th >Gender</th>
				<td>${userInfo.gambler_gender}</td>
			</tr>
			<tr>
				<th >Phone</th>
				<td>${userInfo.gambler_phone}</td>
			</tr>
			<tr>
				<th >Postal Address</th>
				<td>${userInfo.gambler_addr_post}</td>
			</tr>
			<tr>
				<th >Address</th>
				<td>${userInfo.gambler_addr} ${userInfo.gambler_addr_detail}</td>
			</tr>
			<tr>
				<th >Cash</th>
				<td>${userInfo.gambler_cash}</td>
			</tr>
			<tr>
				<th >Win</th>
				<td>${userInfo.gambler_win}</td>
			</tr>
			<tr>
				<th >Lose</th>
				<td>${userInfo.gambler_lose}</td>
			</tr>
			<tr>
				<th >Join Date</th>
				<td><f:formatDate value="${userInfo.gambler_date}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th >Profile Image</th>
				<td><img src="/upload/${userInfo.gambler_image}" style="width: 150px; height: 150px;" /></td>
			</tr>
		</table>
		<div class="btn-group" role="group" aria-label="Basic example">
		  <button type="button" class="btn btn-outline-success " id="gamblerInfoModify">Modify</button>
		  <button type="button" class="btn btn-outline-danger" id="withdraw">Withdraw</button>
		</div>
		</form>
	</div>
	</div>
</div>
<script>
	
	var obj = $("#gamblerInfo");
	$("#gamblerInfoModify").click(function(){
		obj.attr("action","gamblerInfoModify");
		obj.submit();
	});
	$("#withdraw").click(function(){
		obj.attr("action","withdraw");
		obj.submit();
	});

</script>
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
