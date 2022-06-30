<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
	#comments li{
		list-style:none;
	}
	
	#modDiv{
		display:none;
	}
</style>

<div>
	<c:if test="${!empty userInfo}">
		<table class="table table-sm" >
			<tr>
				<th class="table-active" colspan="2" >ADD NEW COMMENT</th>
			</tr>
			<tr>
				<td style="width:150px;">COMMENT AUTH</td>
				<td><input class="form-control" type="text" id="commentAuth" name="commentAuth" value="${userInfo.gambler_name}" readonly/></td>
			</tr>
			<tr>
				<td>COMMENT TEXT</td>
				<td><input class="form-control" type="text" id="commentText" name="commentText"/></td>
			</tr>
			<tr>
				<td colspan=2><input type="button" id="commentAddBtn" value="ADD COMMENT"/></td>
			</tr>
		</table>
	</c:if>
</div>
<br/><hr/><br/>

<div id="modDiv">
	<h3>댓글 수정 &amp; 삭제</h3>
	<!-- 댓글 번호 -->
	<div class="mod-title"></div>
	<!-- 댓글 내용 -->
	<div>
		<input type="text" id="modCommentText"/>
	</div>
	
	<div>
		<input type="button" id="commentModBtn" value="MODIFY"/>
		<input type="button" id="commentDelBtn" value="DELETE"/>	
		<input type="button" id="closeBtn" value="CLOSE"/>		
	</div>
	<br/><hr/><br/>
</div>
<div class="container">
<div class="row">
	<ul id="comments">
	
	</ul>
</div>
</div>
<script>
	var bno = "${board.bno}";
	
	var commentPage = 1;
	
	getListPage(commentPage);
	
	$("#comments").on("click",".commentLi button",function(){
		var commentWrap = $(this).parent();
		var cno = commentWrap.attr("data-cno");
		var text = commentWrap.attr("data-text");
		$(".mod-title").html(cno);
		$("#modCommentText").val(text);
		
		$("#modDiv").toggle("slow");
		
		$("#modCommentText").focus();
	});
	
	$("#closeBtn").click(function(){
		$("#modDiv").toggle("slow");
	});
	
	// 댓글 수정
	$("#commentModBtn").click(function(){
		var cno = $(".mod-title").html();
		var text = $("#modCommentText").val();
		
		$.ajax({
			type : "patch",
			url : contextPath+"/comments/"+cno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PATCH"
			},
			data : JSON.stringify({
				commentText : text
			}),
			dataType : "text",
			success : function(data){
				alert(data);
				$("#modDiv").hide("slow");
				getListPage(commentPage);
			}
		});
	});
	
	// 댓글 삭제
	$("#commentDelBtn").click(function(){
		var cno = $(".mod-title").html();
		
		$.ajax({
			type : "delete",
			url : contextPath+"/comments/"+cno,
			headers : {
				"X-HTTP-Override":"DELETE"
			},
			dataType : "text",
			success : function(data){
				alert(data);
				$("#modDiv").hide("slow");
				getListPage(commentPage);
			}
		});
	});
	

	// 댓글 삽입
	$("#commentAddBtn").click(function(){
		var commentAuth = $("#commentAuth").val();
		var commentText = $("#commentText").val();
		
		$.ajax({
			type : "post",
			url : contextPath+"/comments/add",
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JSON.stringify({
				bno : bno,
				commentText : commentText,
				commentAuth : commentAuth,
				gambler_num : "${userInfo.gambler_num}"
			}),
			dataType : "text",
			success : function(data){
				alert(data);
				getListPage(1);
				$("#commentText").val("");
				$("#commentText").focus();
			},
			erro : function(res){
				alert(res.responseText);
			}
		});
	});
	
	// 댓글 목록
	function getListPage(page){
		$.getJSON(contextPath+"/comments/"+bno+"/"+page,function(data){
			// data == Map<String,Object> 
			// data.list = List<CommentVO> 
			// data.pageMaker = PageMaker
			
			var str = "";
			$(data.list).each(function(){
				str += "<li data-cno='"+this.cno+"' data-text='"+this.commentText+"' class='commentLi'>";
				str += '작성자 : '+this.commentAuth+'<br/> 작성시간 : ' + getDate(this.updatedate);
				str += '<br/> 내용 : ' + this.commentText
				if(isCheckUser(this.gambler_num)){
					str += ' <br/> <button>modify</button>';	
				}
				str += "</li><br/>";
				str += "<li>--------------------------------</li> <br/>";
			});
			$("#comments").html(str);
		});
	}
	
	function isCheckUser(gambler_num){
		var userUno = '${userInfo.gambler_num}';
		if(userUno != "" && userUno == gambler_num){
			return true;
		}
		return false;
	}
	
	
	
	function getDate(timeValue){
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth()+1;
		var date = dateObj.getDate();
		var hour = dateObj.getHours();
		var minute = dateObj.getMinutes();
		var seconds = dateObj.getSeconds();
		
		return year + "/"+ month + "/"+ date +" " + hour+":"+minute+":"+seconds; 
		
	}
	
	
	
	

</script>















