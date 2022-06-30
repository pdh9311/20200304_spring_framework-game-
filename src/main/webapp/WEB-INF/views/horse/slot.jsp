<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>7*3 slot machine - 1 line</title>
<!-- lemon, melon, cherry, 7, BAR, STAR, BELL -->
<style>
	#buttons {
		margin: 0 auto;
		width: 800px;
	}
	ul {
		list-style-type : none;
	}
	.btn {
		margin-top: 0px;
		float: left;
	}
	#machine {
		margin-left: auto;
		margin-right: auto;
		background-image: url("resources/img2/slot.png");
		background-size: 800px 400px;
		width: 800px;
		height: 400px;
		background-repeat: no-repeat;
		text-align: center;
	}
	#btn1 {
		margin-left: 80px;
		margin-right: 200px;
	}
	#btn2 {
		margin-right: 200px;
	}
	#btn3 {
	
	}
	.slot {
		background-image: url("resources/img2/in_slot3.gif");
		background-size: 215px 295px;
		width: 215px;
		height: 295px;
		float: left;
		margin-top: 53px;
	}
	#slot1 {
		margin-left: 11px;
	}
	#slot2 {
		margin-left: 26px;
	}
	#slot3 {
		margin-left: 26px;
	}
	#bet_alarm {
		padding: 0;
		margin: 0;
		margin-right: 10px;
		float: left;
	}
</style>
</head>
<body>
<!-- 배당 / 잭팟 설정 -->
<div id="machine">
	<ul>
		<!-- <li><div class="slot" id="slot1"><img src="resources/img2/in_slot.gif" width="215px" height="295px"/></div></li> -->
		<li><div class="slot" id="slot1"></div></li>
		<li><div class="slot" id="slot2"></div></li>
		<li><div class="slot" id="slot3"></div></li>
	</ul>
</div> <br/>
<div id="buttons">
	<ul>
		<li><input class='btn' type="button" id="btn1" value="Lucky!" onclick="stop(1)"/></li>
		<li><input class='btn' type="button" id="btn2" value="Lucky!" onclick="stop(2)"/></li>
		<li><input class='btn' type="button" id="btn3" value="Lucky!" onclick="stop(3)"/></li>	
	</ul> <br/> <br/>
	
	<h2 id="bet_alarm">Current Bet: 10</h2>
	<input id="bet" type="number"/>
	<input id="bet_check" type="button" value="Bet" onclick="betting()"/>
	
</div>

<br/> <br/>

<script src="http://192.168.1.41:82/socket.io/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
	var id = "1";
	// var id = ${userInfo.gambler_id};
	var socket = io("http://192.168.1.41:82/slot");
	
	var bet = 10;
	var result = [];
	var slot = [];
	var start = false;
	slot[0] = false;
	slot[1] = false;
	slot[2] = false;
	
	function betting() {
		if (start == true) {
			document.getElementById("bet_check").disabled = true;
			return;
		}
		var new_bet = document.getElementById("bet").value;
		if (new_bet <= 10) {return;}
		
		
		bet = new_bet;
		
		document.getElementById("bet_alarm").innerHTML = "Current Bet: " + bet;
	}
		
	function stop(option) {
		if (start == false) {
			socket.emit("bet_fix", {id: id, bet : bet});
			start = true;
		}
		socket.emit("slot_number", {option : option});
	}
	
	function finish() {
		if (result.length == 3) {
			var mul = 0;
			var message = "";
			
			if (result[0] == 0 && result[1] == 0 && result[2] == 0) {
				mul = 10;
				message  = "x" + mul + "!!";
			} else if (result[0] == 1 && result[1] == 1 && result[2] == 1) {
				mul = 20;
				message  = "x" + mul + "!!";
			} else if (result[0] == 2 && result[1] == 2 && result[2] == 2) {
				mul = 40;
				message  = "x" + mul + "!!";
			} else if (result[0] == 3 && result[1] == 3 && result[2] == 3) {
				mul = 60;
				message  = "x" + mul + "!!";
			} else if (result[0] == 4 && result[1] == 4 && result[2] == 4) {
				mul = 80;
				message  = "x" + mul + "!!";
			} else if (result[0] == 5 && result[1] == 5 && result[2] == 5) {
				mul = 100;
				message  = "x" + mul + "!!";
			} else {
				message = "Whack!!"
			}
			
			socket.emit("slot_result", { result : mul, id : id, bet: bet});
			setTimeout(function() {
				if(!alert(message)) {
					location.reload();
				}
			}, 2000);
			
		}
	}
	
	socket.on("slot_number", function(data) {
		var slots = document.getElementsByClassName("slot");
		var btns = document.getElementsByClassName("btn");
		console.log(data.num + " : " + data.option);
		
		if (data.option == 0) {
			for (var i = 0; i < slots.length; i++) {
				// btns.item(i).innerHTML = '<img src="resources/img2/' + ??? + '" width="215px" height="295px"/>';
				if (slot[i] == true) {continue;}
				else {
					slots.item(i).innerHTML = '<img src="resources/img2/' + image_match(data.num) + '" width="215px" height="295px"/>';
					slot[i] = true;
					btns.item(i).disabled = true;
console.log(result);
					finish();
					break;
				}
			}
		} else {
			for (var i = 0; i < slots.length; i++) {
				if (data.option-1 == i) {
					// btns.item(i).innerHTML = '<img src="resources/img2/' + ??? + '" width="215px" height="295px"/>';
					slots.item(i).innerHTML = '<img src="resources/img2/' + image_match(data.num) + '" width="215px" height="295px"/>';
					btns.item(i).disabled = true;
					slot[i] = true;
console.log(result);
					finish();
					break;
				}
			}
		}			
	});
	
	$(document).keydown(function(key){
		if (result.length == 3) {return;}
        //해당하는 키가 엔터키(13) 일떄
        if(key.keyCode == 13){
            stop(0);
        }
    });
	
	function image_match(num) {	// 0.96808
		var image = "";
		if (0 <= num && 30 > num) {
			image = "0.png";
			result.push(0);
		} else if (30 <= num && 47 > num) {
			image = "1.png";
			result.push(1);
		} else if (47 <= num && 63 > num) {
			image = "2.png";
			result.push(2);
		} else if (63 <= num && 77 > num) {
			image = "3.png";
			result.push(3);
		} else if (77 <= num && 89 > num) {
			image = "4.png";
			result.push(4);
		} else if (89 <= num && 100 > num) {
			// if (result[0] == 5 && result[1] == 5) {image = "4.png"; result.push(4);}
			image = "5.png";
			result.push(5);
		}
		return image; 
	}
</script>

