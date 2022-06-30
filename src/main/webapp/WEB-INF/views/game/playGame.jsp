<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게임에 입장하셨습니다.</h1>
	<a href="${param.game_name}?page=${param.page}&game_num=${param.game_num}&roomPage=${param.roomPage}&game_name=${param.game_name}">나가기</a>
</body>
</html>