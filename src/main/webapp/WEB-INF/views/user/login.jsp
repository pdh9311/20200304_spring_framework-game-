<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"/> 

<body class="text-center bg-light">

    <form action="/user/loginPost" method="post" class="form-signin" 
    style="width:100%;height:30%;
    margin: 220px auto;max-width:330px;padding:15px;">
  
  <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  
  <label for="inputEmail" class="sr-only">Email address</label>
  <input type="email" id="inputEmail" name="gambler_id" class="form-control" placeholder="Email address" required>

  <label for="inputPassword" class="sr-only">Password</label>
  <input type="password" id="inputPassword" name="gambler_pw" class="form-control" placeholder="Password" required>
  <div class="checkbox mb-3">
    <label>
      	<input type="checkbox" name="gambler_cookie" value="true"> Remember me
    </label>
  </div>
  <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
  
  <p class="mt-5 mb-3 text-muted">© 2019-2020</p>
</form>


</body>

<script>
	var message = '${message}';
	if(message != null && message != ''){
		alert(message);
	}
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>