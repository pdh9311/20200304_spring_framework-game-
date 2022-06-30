<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<body class="bg-light">
	<div class="container">
		<div class="py-3">
			<h2>MODIFY</h2>
		</div>
		<div class="row">
			<div class="col-md-8 order-md-1">
				<form class="needs-validation" id="gamblerInfoModify" action="/user/gamblerInfoModifyComplete" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label>ID<span class="text-muted">(Email)</span></label> 
						<input type="text" class="form-control" id="gambler_id" name="gambler_id" value="${userInfo.gambler_id}" readonly/>
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<label>Password</label> 
						<input type="password" class="form-control" id="gambler_pw" name="gambler_pw" value="${userInfo.gambler_pw}" placeholder="영문,숫자를 혼합하여 6~20자 이내" />
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<input type="password" class="form-control" id="gambler_repw" value="${userInfo.gambler_pw}" placeholder="비밀번호 재입력"/>
						<div class="result"></div>
					</div>

					<div class="mb-3">
						<label>Phone</label> 
						<input type="text" class="form-control"
							id="gambler_phone" name="gambler_phone" value="${userInfo.gambler_phone}" placeholder="-표시 없이 숫자만"/>
						<div class="result"></div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label>Postal Address</label>
							<div class="input-group">
								<input type="text" class="form-control" id="gambler_addr_post" name="gambler_addr_post" value="${userInfo.gambler_addr_post}" placeholder="우편번호" readonly />
								<div class="input-group-append">
									<button type="button" class="btn btn-secondary" onclick="addressDaumPostCode();">Search Address</button>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" id="gambler_addr" name="gambler_addr" value="${userInfo.gambler_addr}" placeholder="주소" />
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" id="gambler_addr_detail" name="gambler_addr_detail" value="${userInfo.gambler_addr_detail}" placeholder="상세주소" />
					</div>

					<div class="form-group">
						<label for="gambler_image">Profile Image</label>
						<div>
							<input type="file" name="file" id="gambler_image" />
						</div>
					</div>

					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block" type="button" id="gamblerInfoModifyComplete">Complete Modify</button>
					<br />
				</form>
			</div>
		</div>

	</div>
	
	<!-- 다음 주소 API -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function addressDaumPostCode() {
			// alert("주소찾기 click");
			new daum.Postcode({
				// 주소를 검색하고 실행이 완료되었을때 oncomplete
				oncomplete : function(data) {
					// 주소 검색 결과
					console.log(data);

					var fullAddr = ""; // 최종 주소
					var extraAddr = ""; // 조합형 주소

					if (data.userSelectedType == 'R') { // 도로명 주소
						fullAddr = data.roadAddress;
					} else {
						fullAddr = data.jibunAddress;
					}

					if (data.userSelectedType == 'R') {
						// 법정동명이 존재하면 추가함.
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						// 건물명이 존재하면 추가함.
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ',' + data.buildingName : data.buildingName);
						}
						fullAddr += (extraAddr !== '' ? '(' + extraAddr + ')' : '');
					}

					$("#gambler_addr_post").val(data.zonecode); // 우편번호

					$("#gambler_addr").val(fullAddr);

					$("#gambler_addr_detail").focus();
				}
			}).open();
		}
	</script>


	<!-- 유효성 검사 -->
	<script>
		$(function() {
			$("#gambler_pw").focus();

			var boolPassword = true;
			var boolPasswordCheck = true;
			var boolPhone = true;
			var boolAddress = true;
			var boolProfileImage = false;

			var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/; // 영문,숫자를 혼합하여 6~20자 이내
			var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/; // mobile -표시 없이 숫자만

			// 정규식 검사
			function checkRegex(elP, valP, regexP, messageP, ajaxP) {
				if (regexP.test(valP) === false) {
					showErrorMessage(elP, messageP, false);
					return false;
				} else if (regexP.test(valP) !== false && ajaxP === null) {
					showErrorMessage(elP, "사용가능합니다.", true);
					return true;
				} else {
					if (ajaxP != null) {
						ajaxP(elP);
					}
				}
			}

			// 검사 결과를 보여줄 메세지
			function showErrorMessage(elP, messageP, isChecked) {
				var html = "<span style='margin-left:5px;font-size:12px; ";
				html += isChecked ? "color:green;" : "color:red;";
				html += "'>";
				html += messageP;
				html += " </span>";
				$(elP).html(html);
			}

			$("#gambler_pw").on("input",function() {
				var tempVal = $(this).val();
				var elP = $(this).parent().find(".result");
				var message = "영문,숫자를 혼합하여 6~20자 이내로 작성하세요.";
				boolPassword = checkRegex(elP, tempVal, regexPass, message, null);
			});

			$("#gambler_repw").on("input", function() {
				var tempVal = $(this).val();
				var elP = $(this).parent().find(".result");
				var message = "";
				var originVal = $("#gambler_pw").val();

				if (boolPassword) {
					if (tempVal == originVal) {
						boolPasswordCheck = true;
						message = "비밀번호가 일치합니다.";
					} else {
						boolPasswordCheck = false;
						message = "비밀번호가 일치하지 않습니다.";
					}
				} else {
					boolPasswordCheck = false;
					message = "비밀번호를 확인해주세요."
				}
				showErrorMessage(elP, message, boolPasswordCheck);
			});

			$("#gambler_phone").on("input",function() {
				var tempVal = $(this).val();
				var elP = $(this).parent().find(".result");
				var message = "-제외 숫자만 입력해주세요.";
				boolPhone = checkRegex(elP, tempVal, regexMobile,message, null);
			});

			function checkAddr() {
				if ($("#u_addr").val() !== '' && $("#u_addr_post").val() !== '' && $("#u_addr_detail").val() !== '') {
					boolAddress = true;
				} else {
					boolAddress = false;
				}
			}

			$("#gambler_infoOk").on("change", function() {
				var isChecked = $(this).is(":checked");
				if (isChecked) {
					boolInfoOk = true;
				} else {
					boolInfoOk = false;
				}
			});

			$("#gamblerInfoModifyComplete").click(function() {
				checkAddr();
				if (!boolPassword) {
					alert("비밀번호를 확인해주세요.");
					$("#gambler_pw").focus();
				} else if (!boolPasswordCheck) {
					alert("비밀번호확인을 확인해주세요.");
					$("#gambler_repw").focus();
				} else if (!boolPhone) {
					alert("휴대전화를 확인해주세요.");
					$("#gambler_phone").focus();
				} else if (!boolAddress) {
					alert("주소를 확인해주세요.");
					$("#gambler_addr").focus();
				} else {
					$("#gamblerInfoModify").submit();
				}
			});
		});
	</script>
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />