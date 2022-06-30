<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
	<div class="container">
		<div class="py-3">
			<h2>JOIN</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1">
				<form class="needs-validation" id="joinForm" action="/user/joinPost" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label>ID<span class="text-muted">(Email)</span></label> 
						<input type="text" class="form-control" id="gambler_id" name="gambler_id" placeholder="you@example.com" />
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<label>Password</label> 
						<input type="password" class="form-control" id="gambler_pw" name="gambler_pw" placeholder="영문,숫자를 혼합하여 6~20자 이내" />
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<input type="password" class="form-control" id="gambler_repw" placeholder="비밀번호 확인" />
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<label>Name</label> 
						<input type="text" class="form-control" id="gambler_name" name="gambler_name" placeholder="" />
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<label>Birth</label> 
						<input type="text" class="form-control" id="gambler_birth" name="gambler_birth" placeholder="ex)19820607" />
						<div class="result"></div>
					</div>

					<div class="row">
						<div class="col-md-5 mb-3">
							<label>Gender</label>
							<select class="custom-select d-block w-100" id="gambler_gender" name="gambler_gender">
								<option hidden disabled selected>Choose...</option>
								<option value="man">남자</option>
								<option value="women">여자</option>
							</select>
							<div class="result"></div>
						</div>
					</div>

					<div class="mb-3">
						<label>Phone</label> 
						<input type="text" class="form-control" id="gambler_phone" name="gambler_phone" placeholder="-표시 없이 숫자만" />
						<div class="result"></div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label>Address</label>
							<div class="input-group">
								<input type="text" class="form-control" id="gambler_addr_post" name="gambler_addr_post" placeholder="우편번호" readonly />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary"	onclick="addressDaumPostCode();">Search Address</button>
								</div>
							</div>
							<div class="result"></div>
						</div>
					</div>

					<div class="mb-3">
						<input type="text" class="form-control" id="gambler_addr" name="gambler_addr" placeholder="주소" />
					</div>

					<div class="mb-3">
						<input type="text" class="form-control" id="gambler_addr_detail" name="gambler_addr_detail" placeholder="상세주소" />
					</div>

					<div class="form-group">
						<label for="gambler_image">Profile Image</label>
						<div><input type="file"  name="file" id="gambler_image" /></div>
					</div>

					<hr class="mb-4">
					<div class="custom-control custom-checkbox">
						<textarea class="form-control" rows="3" readonly>
						<%
						BufferedReader reader = null;
						try {
							String filePath = application.getRealPath("/resources/privaryInfoContent.txt");
							reader = new BufferedReader(new FileReader(filePath));
							while (true) {
							String str = reader.readLine();
							if (str == null)
								break;
								out.print(str);
							}
						} catch (FileNotFoundException fnfe) {
							out.print("파일이 존재 하지 않습니다.");
						} catch (IOException ioe) {
							out.print("파일을 읽을수 없습니다.");
						} finally {
							try {
								reader.close();
							} catch (Exception e) {	}
						}
						%>
						</textarea>
						<input type="checkbox" class="custom-control-input"	id="gambler_infoOk" name="gambler_infoOk" value="y" /> 
						<label for="gambler_infoOk" class="custom-control-label">I accept the Terms of Service</label>
					</div>

					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block" type="button" id="joinBtn">Create Account</button>
					<br />
				</form>
			</div>
		</div>

	</div>
	<!-- 다음 주소 API -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	function addressDaumPostCode(){
		// alert("주소찾기 click");
		new daum.Postcode({
			// 주소를 검색하고 실행이 완료되었을때 oncomplete
			oncomplete : function(data){
				// 주소 검색 결과
				console.log(data);
				
				var fullAddr = "";	// 최종 주소
				var extraAddr = "";	// 조합형 주소
				
				if(data.userSelectedType == 'R') {	// 도로명 주소
					fullAddr = data.roadAddress;
				}else{
					fullAddr = data.jibunAddress;
				}
				
				if(data.userSelectedType == 'R'){
					// 법정동명이 존재하면 추가함.
					if(data.bname !== ''){			
						extraAddr += data.bname;						
					}
					// 건물명이 존재하면 추가함.
					if(data.buildingName !== ''){
						extraAddr += (extraAddr !== '' ? ','+data.buildingName : data.buildingName);
					}
					
					fullAddr += (extraAddr !== '' ? '('+extraAddr+')' : ''); 
				}
				
				$("#gambler_addr_post").val(data.zonecode);	// 우편번호
				
				$("#gambler_addr").val(fullAddr);
				
				$("#gambler_addr_detail").focus();
			}
		}).open();
	}
</script>


	<!-- 유효성 검사 -->
	<script>
	$(function(){
		$("#gambler_id").focus();
		
		var boolId = false;
		var boolPassword = false;
		var boolPasswordCheck = false;
		var boolName = false;
		var boolBirth = false;
		var boolGender = false;
		var boolPhone = false;
		var boolAddress = false;
		var boolInfoOk = false;
		
		var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;       // 이메일
		var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;			// 영문,숫자를 혼합하여 6~20자 이내
		var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/;					// mobile -표시 없이 숫자만
		var regexName = /^[\uac00-\ud7a3]{2,6}$/;								// 한글 영문 포함 2~6자 이내
		var regexBirth = /^[0-9]{4}[0-9]{2}[0-9]{2}$/;							// 생년월일  19820607
		
		// 정규식 검사
		function checkRegex(elP,valP,regexP,messageP,ajaxP){
			if(regexP.test(valP) === false){
				showErrorMessage(elP,messageP,false);
				return false;
			}else if(regexP.test(valP) !== false && ajaxP === null){
				showErrorMessage(elP,"사용가능합니다.",true);
				return true;
			}else{
				if(ajaxP != null){
					ajaxP(elP);
				}
			}
		}
		
		// 검사 결과를 보여줄 메세지
		function showErrorMessage(elP,messageP,isChecked){
			var html ="<span style='margin-left:5px;font-size:12px; "; 
				html += isChecked ? "color:green;" : "color:red;";
				html +="'>";
				html += messageP;
				html +=" </span>";
				$(elP).html(html);
		}
		
		$("#gambler_id").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "올바른 이메일 형식이 아닙니다.";
			boolId = checkRegex(elP,tempVal,regexEmail,message,checkIdAjax);
		});
		
		function checkIdAjax(elP){
			$.ajax({
				type : "post",
				url: "/user/idCheck",
				dataType: "json",
				data:{
					gambler_id : $("#gambler_id").val()
				},
				success : function(data){
					if(data){
						showErrorMessage(elP,"사용가능한 아이디입니다.",true);
						boolId = true;
					}else{
						showErrorMessage(elP,"이미 존재하는 아이디 입니다.",false);
						boolId = false;
					}
				}
			});
		}
		
		$("#gambler_pw").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "영문,숫자를 혼합하여 6~20자 이내로 작성하세요.";
			boolPassword = checkRegex(elP,tempVal,regexPass,message,null);
		});
		
		$("#gambler_repw").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "";
			var originVal = $("#gambler_pw").val();
			
			if(boolPassword){
				if(tempVal == originVal){
					boolPasswordCheck = true;
					message = "비밀번호가 일치합니다.";
				}else{
					boolPasswordCheck = false;
					message = "비밀번호가 일치하지 않습니다.";
				}
			}else{
				boolPasswordCheck = false;
				message = "비밀번호를 확인해주세요."
			}
			showErrorMessage(elP,message,boolPasswordCheck);
		});
		
		$("#gambler_name").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "한글 영문 포함 2~6자 이내로 작성해주세요.";
			boolName = checkRegex(elP,tempVal,regexName,message,null);
		});
	
		$("#gambler_birth").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "숫자만 입력해주세요 ex)19480815";
			boolBirth = checkRegex(elP,tempVal,regexBirth,message,null);
		});
	
		$("#gambler_gender").change(function(){
			var tempVal = $(this).val();
			console.log(tempVal);
			var elP = $(this).parent().find(".result");
			var message = "성별을 선택해주세요.";
			if(tempVal == 'man' || tempVal == 'woman'){
				boolGender = true;
			}else{
				boolGender = false;
			}
		});
		
		$("#gambler_phone").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "-제외 숫자만 입력해주세요.";
			boolPhone = checkRegex(elP,tempVal,regexMobile,message,null);
		});
		
		function checkAddr(){
			if($("#u_addr").val() !== '' 
					&&
			   $("#u_addr_post").val() !== ''
					&&
			   $("#u_addr_detail").val() !== ''){
				boolAddress = true;
			}else{
				boolAddress = false;
			}
		}
		
		$("#gambler_infoOk").on("change",function(){
			var isChecked = $(this).is(":checked");
			if(isChecked){
				boolInfoOk = true;
			}else{
				boolInfoOk	= false;
			}
		});
				
		$("#joinBtn").click(function(){
			checkAddr();
			if(!boolId){
				alert("아이디를 확인해주세요.");
				$("#gambler_id").focus();
			}else if(!boolPassword){
				alert("비밀번호를 확인해주세요.");
				$("#gambler_pw").focus();
			}else if(!boolPasswordCheck){
				alert("비밀번호확인을 확인해주세요.");
				$("#gambler_repw").focus();	
			}else if(!boolName){
				alert("이름을 확인해주세요.");
				$("#gambler_name").focus();
			}else if(!boolBirth){
				alert("생년월일을 확인해주세요.");
				$("#gambler_birth").focus();
			}else if(!boolGender){
				alert("성별을 선택해주세요.");
				$("#gambler_gender").focus();
			}else if(!boolPhone){
				alert("휴대전화를 확인해주세요.");
				$("#gambler_phone").focus();
			}else if(!boolAddress){
				alert("주소를 확인해주세요.");
				$("#gambler_addr").focus();
			}else if(!boolInfoOk){
				alert("개인정보이용 동의를 체크해주세요.");
				$("#gambler_infoOk").focus();
			}else{
				$("#joinForm").submit();
			}
		});
	});
</script>
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />