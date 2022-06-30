<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KoreateVeage</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="${path}/resources/bootstrap/css/bootstrap.css" rel="stylesheet"/>
<script src="${path}/resources/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet" href="${path}/resources/css/hanmin.css">


</head>
<body style="padding-top:56px;">
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		  <a class="navbar-brand text-danger" href="/">KoreateVegas</a>
		  <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		  <div class="navbar-collapse collapse" id="navbarCollapse" style="">
		    <ul class="navbar-nav mr-auto">
		    	<c:choose>
					<c:when test="${empty userInfo}"> 
						<li class="nav-item active">
				    		<a class="nav-link" href="/user/login">로그인<span class="sr-only">(current)</span></a>
				 	    </li>
				  	    <li class="nav-item active">
					        <a class="nav-link" href="/user/join">회원가입</a>
					    </li>
					    <li class="nav-item active">
					        <a class="nav-link" href="/board/list">자유게시판</a>
					    </li>
					   
					</c:when>
					<c:otherwise>
					  <li class="nav-item active">
				        <a class="nav-link" href="/user/logout">로그아웃 <span class="sr-only">(current)</span></a>
				      </li>
				      <li class="nav-item active">
				        <a class="nav-link text-success" href="/user/gamblerInfo">${userInfo.gambler_id}</a>
				      </li>
				      <li class="nav-item active">
				        <a class="nav-link" href="/board/list">자유게시판</a>
				      </li>
				      
					  <c:if test="${userInfo.gambler_id == 'admin@admin.com' }">
				      <li class="nav-item active">
						<a class="nav-link text-primary" href="/game/gameReg">Register Game</a>
					  </li>
                      </c:if>
                  
					</c:otherwise>
				</c:choose>
		    </ul>
		  </div>
		</nav>
	</header>
