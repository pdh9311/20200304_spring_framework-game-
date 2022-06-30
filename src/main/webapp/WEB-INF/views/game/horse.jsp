<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<title>Canvas</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
canvas {
	background: #eee;
	position:relative;
	top:100px;
	float:left;
}
#control{

width:430px;
height:600px;
float:left;

position:relative;
	top:100px;
	
}
#wrapper{
width:1700px;
height:600px;
float:left;
padding: 0px 0px 0px 250px;
}

#Left{
float:left;}
</style>
</head>

<body>
<div id="wrapper">
	<canvas class="canvas" width="1000" height="500"></canvas>
<div id= "control">
	<c:if test="${!empty userInfo}">
		
<div id="chatting_board" style="border: 2px black solid; width: 400px; height: 300px; float:left; "><!--margin: 0px 20px 0px 40px;  -->
	<div id="text" style="overflow: auto; border: 1px black solid; width: 375px; height: 250px; margin: 0px; margin-left: 8px; margin-top: 8px;"></div>
	<input type="text" id="chat" style="margin-left: 8px; margin-top: 3px; width: 325px;"/>
	<input type="button" value="chat" id="send" onclick="javascript:send();"/>
</div>
		
		<div id="horse_menu" style=" width: 400px; height: 300px; float:left; "><!-- margin: 0px 20px 0px 40px; -->
<div id="winnerDiv">winner :  </div>
		<h5>배팅</h5>
		<input type="number" id="horse" placeholder="말 번호"/>
		<input type="number" id="much" placeholder="배팅액"/>
		<input type="button" id="bet" value="Bet"/><br/>
		<input type="number" id="horsecancel" placeholder="배팅 취소할 말 번호"/>
		<input type="button" id="cancel" value="Cancel"/>
		<!-- <input type="button" id="calc" value="Calc"/> -->
	<div class="control"><input type="button" id="start" value="Start"/></div>
	</div>
		</c:if>
</div>

</div>

<%-- <jsp:include page="/WEB-INF/views/horse/result.jsp"/> --%>
</body>


<!-- //박스생성 박스클릭
	박스 인식 : 좌표가 필요   -->
	
<script src="http://192.168.1.41:82/socket.io/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.js"></script>

<script>
var socket = io("http://192.168.1.41:82/racing");
var id = "${userInfo.gambler_id}";
var contextPath = '${pageContext.request.contextPath}';
const canvas = document.querySelector('.canvas');
const context = canvas.getContext('2d');
const control = document.querySelector('.control');
const boxes = []; //배열에 넣어 관리
let winner;
context.font = 'bold 15px sans-serif';


class Box{
	constructor(index, x, y,speed) {
		this.index = index;
		this.x=x;
		this.y=y;
		this.speed = speed;
		this.draw();
		
	}
draw(){
	//움직이기위해서 좌표 수정후 그림
	context.fillStyle="rgba(0,0,0,0.5)";
	context.fillRect(this.x,this.y,50,50)
	context.fillStyle ='#fffff';
	context.fillText(this.index,this.x+10,this.y+10);
	
}//draw
}//class


let tpX=0 ,tpY=0,tpSpeed;
  for(let i=0; i<8; i++){
	tpY+= 55;
	tpSpeed= Math.random()*2+1;
	boxes.push(new Box(i+1,tpX,tpY,tpSpeed));
} // 객체 생성 



function setTime(){
document.getElementById("testDiv").innerHTML = new Date();
setTimeout(setTime,1000);
}
function result(winner){

	document.getElementById("winnerDiv").innerHTML= winner;
	
	var winner =winner;
	var gambler_num = ${userInfo.gambler_num}
	console.log("${userInfo.gambler_num}");
	console.log("승리마 : " + winner);
		$.ajax({
			type : "get",
			url : contextPath+"/game/result",
			data : {
				winner : winner,
				gambler_num  : gambler_num 
			},
			dataType : "text",
			success : function(data){
				alert(data);
			},
			erro : function(res){
				alert(res.responseText);
			}
		});

}





function render() {
		context.clearRect(0,0,canvas.width,canvas.height);
		let box;
	for(let i=0; i<boxes.length; i++){
		box = boxes[i];
		setTimeout(speed0(box),5000);
		/* setTimeout(setTime,1000);
		setTimeout(function() {
			speed0(box)
		},1500);
		setTimeout(setTime,1000);
		 */
			 if(box.x >canvas.width){
				 
				 console.log('승리마는 ',box.index);
				 winner= box.index;
				 result(winner);
				 setTimeout(function() {
					 location.reload();
					}, 30000);
				 return 
				  }
		box.draw();
			 }//for1
			/*  setInterval(render,1000); */
			 requestAnimationFrame(render); 
			}//render

  
 function speed(box){

				box.speed += Math.random()*2+1;
				box.x+=box.speed;
				console.log('......');
				console.log('index',box.index,'speed',box.speed,'x : ',box.x);

 }//speed
 function speed0(box){

		box.x+=box.speed;
		console.log('index',box.index,'speed',box.speed,'x : ',box.x);

}//speed
  console.log(boxes);


control.addEventListener('click', render);
/* setTimeout(render(),1000); */
 
/////////////////////////////////////////////////////////////////////////////////////

	


		

			$(document).keydown(function(key){
                if(key.keyCode == 13){
                    send();
                }
                
                if(key.keyCode == 46){
                    // $("#id_register").toggle();
                }
            });

          	function send() {
	           	var text = document.getElementById("chat").value;
	           	console.log(text);
	           	if (text == "") {return;}
	           	else {
	           		socket.emit("chat", { id: id, text: text });
	           		$("#chat").val("");
	           		$("#chat").focus();
	           	}
        	}
            
            socket.on("chat", function(data){
            	$("#text").append(data.id + " : " + data.text + " <br/>");
            	$("#text").scrollTop($("#text").prop("scrollHeight"));
            });



                $("#bet").click(function() {
                	var hbet = $("#much").val();
                	var hnum = $("#horse").val();
                	if (hbet == "") {
                		alert("bet money");
                		return;
                	}	
                		if(hnum >8){
                			alert(" horse 1~8");
                    		return;
                		}
                	
                		
              		$.ajax({
              			type : "post",
              			url : contextPath+"/game/bet",
              			data : JSON.stringify({
              				hbet : hbet,
              				hnum : hnum,
              				gambler_num : "${userInfo.gambler_num}"
              			}),
              			headers : {
              				"Content-Type" : "application/json",
              			},
              			dataType : "text",
              			success : function(data){
              				alert(data);
              			},
              			erro : function(res){
              				alert(res.responseText);
              			}
              		});
              	});
                
       
				$("#calc").click(function() {
					
					$.ajax({
              			type : "get",
              			url : contextPath+"/game/betclose",
              			success : function(data){
              				alert(data);
              			},
              			erro : function(res){
              				alert(res.responseText);
              			}
              		});
					});
		
				$("#cancel").click(function() {
					var hnum = $("#horsecancel").val();
					
              		$.ajax({
              			type : "post",
              			url : contextPath+"/game/cancel",
              			data : JSON.stringify({
              				hnum: hnum,
              				gambler_num : "${userInfo.gambler_num}"
              			}),
              			headers : {
              				"Content-Type" : "application/json",
              			},
              			dataType : "text",
              			success : function(data){
              				alert(data);
              			},
              			erro : function(res){
              				alert(res.responseText);
              			}
              		});
                });
				
			
		
 
 
</script>
</html>









