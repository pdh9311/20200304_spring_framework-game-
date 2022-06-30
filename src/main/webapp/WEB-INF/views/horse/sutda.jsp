<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#big {
		width: 100%;
		padding-left: auto;
		padding-right: auto;
	}
	.user {
		margin-left: 50px;
		margin-right: 50px;
	}
	li {
		margin : 0px 5px;
		float: left;
	}
	#board {
		margin-left: auto;
		margin-right: auto;
		background-image: url("resources/img/board5.jpg");
		background-size: 1000px 700px;
		width: 1000px;
		height: 600px;
		background-repeat: no-repeat;
		padding-top: 100px;
		text-align: center;
	}
	#game_menu {
		margin-left: auto;
		margin-right: auto;
	}
	#ready_menu {
		margin-left: auto;
		margin-right: auto;
	}
	#player_list {
	
		display: inline-block;
		margin : 0 auto;
	}
	ul {
  		list-style-type : none;
	}
</style>


</head>
<body>
	<input type="text" id="new_id"/>
	<input type="button" id="new_id_btn"/>
	
	<div class="big">
	<div id="board" >
		<div id="current_bet_per_person" style="height: 75px; margin: 5px 0; padding: 0px;"></div>
		<ul id="player_list" >
			
		</ul>
	</div>
		
	<div id="ready_menu">
		<input type="button" id="ready" value="Ready"/>
		<!-- 
		<input type="button" id="cancel" value="Cancel"/>
		 -->
		<input type="button" class="out" value="Out"/>
	</div>
	
	<div id="game_menu">
		<input type="number" id="much"/>
		<input type="button" id="bet" value="Bet"/>
		<input type="button" id="call" value="Call"/>
		<input type="button" id="die" value="Die"/>
		<input type="button" class="out" value="Out"/>
	</div>
	<!-- 
	<table>
		<tr>
			<th>족보</th>
		</tr>
		<tr>
			<td>삼팔광땡</td>
		</tr>
		<tr>
			<td>일팔광땡</td>
		</tr>
		<tr>
			<td>일삼광땡</td>
		</tr>
		<tr>
			<td>장땡</td>
		</tr>
		<tr>
			<td>구땡</td>
		</tr>
		<tr>
			<td>팔땡</td>
		</tr>
		<tr>
			<td>칠땡</td>
		</tr>
		<tr>
			<td>육땡</td>
		</tr>
		<tr>
			<td>오땡</td>
		</tr>
		<tr>
			<td>사땡</td>
		</tr>
		<tr>
			<td>삼땡</td>
		</tr>
		<tr>
			<td>이땡</td>
		</tr>
		<tr>
			<td>일땡</td>
		</tr>
		<tr>
			<td>알리</td>
		</tr>
		<tr>
			<td>독사</td>
		</tr>
		<tr>
			<td>구삥</td>
		</tr>
		<tr>
			<td>장삥</td>
		</tr>
		<tr>
			<td>장사</td>
		</tr>
		<tr>
			<td>세륙</td>
		</tr>
		<tr>
			<td>갑오</td>
		</tr>
		<tr>
			<td>여덟끗</td>
		</tr>
		<tr>
			<td>일곱끗</td>
		</tr>
		<tr>
			<td>여섯끗</td>
		</tr>
		<tr>
			<td>다섯끗</td>
		</tr>
		<tr>
			<td>네끗</td>
		</tr>
		<tr>
			<td>세끗</td>
		</tr>
		<tr>
			<td>두끗</td>
		</tr>
		<tr>
			<td>한끗</td>
		</tr>
		<tr>
			<td>망통</td>
		</tr>
		<tr>
			<th>특수족보</th>
		</tr>
		<tr>
			<td>암행어사</td>
		</tr>
		<tr>
			<td>땡잡이</td>
		</tr>
		<tr>
			<td>멍구사</td>
		</tr>
		<tr>
			<td>구사</td>
		</tr>
	</table>
	 -->	
	</div>
	<br/>

    <script src="http://192.168.1.41:82/socket.io/socket.io.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.1.js"></script>
    <script>
    		var card = [];
    		var room = 1;
            var bet = 10;
            // var id = ${userInfo.gambler_id};
            var die = false;
            var turn = 0;
            var ready_state = false;
            var socket = io("http://192.168.1.41:82/system");
            
    		function open_your_card () {
    			alert("open your card!");
    		}
    
            $(document).ready(function(){
                
            	$('#game_menu').toggle("slow");
            	document.getElementById("bet").disabled = true;
				document.getElementById("call").disabled = true;
				document.getElementById("die").disabled = true;
                
            	// socket.emit("joinRoom", { id: id, room: room });

//////////////////////////////////////////////////////////////////////////////////////

				$("#new_id_btn").click(function() { // temporary it will not be necessary
                	id = document.getElementById("new_id").value;
                	socket.emit("joinRoom", { id: id, room: room });
                	// console.log(id);
                });
                                
                $("#get_head").click(function() {
                	if (die == true) {return;}
                	else if (card.length == 2) {return;}
                	else if (turn == 1 && card.length == 1) {return;}
                	else {socket.emit("get_head", { id: id, room: room });}
                });
                
                $(".tail").click(function() {
                	console.log("click");
                	// this.parentNode.getAttribute("class");
                	if (this.parent().getAttribute("class") != id + "_tail") {
                		return;
                	}
                	if (die == true) {return;}
                	else if (card.length == 2) {return;}
                	else if (turn == 1 && card.length == 1) {return;}
                	else {socket.emit("get_head", { id: id, room: room });}
                });
                
                $("#remove").click(function() {
                	$('li#x').remove();
                	card = [];
                });
                
//////////////////////////////////////////////

                socket.on("new_player", function(data) { // Long~~ Code
                	// $("#player_list").append(data);
                	document.getElementById("player_list").innerHTML = data;
                });

                socket.on("get_tail", function(data) { // someone's ID who pushed "get_tail" button
                	var hand = data + "_hand";
                	document.getElementById(hand).innerHTML += "<li class='" + data + "_tail'><img src='resources/img/tail.png' height='115px' weight='80px' class='tail' onclick='show_head(\"" + data + "_tail\")'/></li>";
                });
                
                socket.on("get_head", function(data) { // new card number, id
					card.push(data.num);
					console.log(card);
					
                	if (card.length == 2) {
                		card = card.sort(function(a, b) { // asending (1, 2, 3, ...)
    			            return a - b;
    			        });
                		
                		var jokbo = jok_bo(card);
                		console.log(jokbo);
                	}
                	
                	var hand = id + "_hand";
                	var tails = document.getElementsByClassName(id + "_tail");
                	for (var i = 0; i < tails.length; i++) {
                		tails.item(i).remove();
                		break;
                	}
                	// $("#" + id + "_tail").remove();
                	document.getElementById(hand).innerHTML += "<li class='" + id + "_head'><img src='resources/img/" + image_match(data.num) + "' height='115px' weight='80px' class='tail'/></li>";
                	// document.getElementById(hand).innerHTML += "<li class='" + data + "_tail'><img src='resources/img/tail.png' height='115px' weight='80px' class='tail' onclick='show_head(\"" + data + "_tail\")'/></li>";
                });
                
                socket.on("open", function(data) { // {id: data.id, card: data.card}
                	var jokbo = jok_bo(data.card);
                	document.getElementById(data.id + "_status").innerHTML = data.id + ": " + jok_bo_kor(jokbo);
                	var hand = data.id + "_hand";
                	var tails = document.getElementsByClassName(data.id + "_tail");
                	for (var i = tails.length-1; i >= 0; i--) {
                		tails.item(i).remove();
                		document.getElementById(hand).innerHTML += "<li class='" + data.id + "_head'><img src='resources/img/" + image_match(data.card[i]) + "' height='115px' weight='80px' class='tail'/></li>";
                	}
                });
                
//////////////////////////////////////////////////////////////////////////////////////

                $("#bet").click(function() {
                	var num = document.getElementById("much").value;
                	
                	if (num < bet || num == "") {
                		alert("more!!");
                		return;
                	}
                	
                	if (turn == 2 && card.length != 2) {
						open_your_card();
						return;
					};
                	socket.emit("bet", {id: id, room: room, bet: num, die: die});
                	document.getElementById("bet").disabled = true;
					document.getElementById("call").disabled = true;
					document.getElementById("die").disabled = true;
                });
                
				$("#call").click(function() {
					if (turn == 2 && card.length != 2) {
						open_your_card();
						return;
					};
					socket.emit("bet", {id: id, room: room, bet: bet, die: die});
					document.getElementById("bet").disabled = true;
					document.getElementById("call").disabled = true;
					document.getElementById("die").disabled = true;
                });
                
				$("#die").click(function() {
					die = true;
					socket.emit("die", {id: id, room: room});
					socket.emit("bet", {id: id, room: room, bet: bet, die: die});
					document.getElementById("bet").disabled = true;
					document.getElementById("call").disabled = true;
					document.getElementById("die").disabled = true;
                });
				
				socket.on("bet", function(data) { // {bet: rooms[data.room].bet, turn: rooms[data.room].turn}
					alert("Your Turn!");
					bet = data.bet;
					turn = data.turn;
					document.getElementById("much").value = data.bet;
					document.getElementById("current_bet_per_person").innerHTML = "<h1>Betting: " + data.bet + "</h1>"; 
				
					if (die == true) {
						socket.emit("bet", {id: id, room: room, bet: bet, die: die});
						document.getElementById("bet").disabled = true;
						document.getElementById("call").disabled = true;
						document.getElementById("die").disabled = true;

						return;
					}
					
					document.getElementById("bet").disabled = false;
					document.getElementById("call").disabled = false;
					document.getElementById("die").disabled = false;
                });
								
				socket.on("die", function(data) { // {id: data.id}
					var id_status = data.id + "_status";
					document.getElementById(id_status).innerHTML = data.id + " (X)";
                });
				
//////////////////////////////////////////////////////////////////////////////////////

                $("#ready").click(function() {
                	if (ready_state == true) {
                		return;
                	}
                	ready_state = true;
                	socket.emit("ready", { id: id, room: room, value: 1 });
                });

				socket.on("OK", function() {
					$("#ready").toggle("slow");
					$(".ready_message").remove();	///////////////////////////////////////////////
					$('#ready_menu').toggle("slow");
                	$('#game_menu').toggle("slow");
				});

				socket.on("ready", function(data) {
                	var user = document.getElementById(data.id);
                	user.innerHTML += "<h1 class='ready_message'>READY!</h1>"
                });
				
				socket.on("first_phase_over", function(data) { // {id: data.id}
console.log("first_phase_over");
					socket.emit("second_phase_start", {id: id, room: room});
                });
				
				socket.on("second_phase_over", function(data) { // {id: data.id}
					socket.emit("summary", {id: id, room: room, bet: bet, card: card});
                });
				
				socket.on("second_phase_start", function(data) { // {id: data.id}
					turn = data.turn;
                });
				
				socket.on("winner", function(data) { // {id: data.id}
					setTimeout(function() {
					if (data.winner == "!@#rematch") {
						if(!alert("Rematch!")) {
							document.getElementById("current_bet_per_person").innerHTML = "";
							document.getElementById("player_list").innerHTML = "";
							socket.emit("reload", {room : room});
							
							card = [];
			                bet = 10;
			                die = false;
			                turn = 0;
			                ready_state = false;
			                
			            	$('#game_menu').toggle("slow");
			            	$("#ready_menu").toggle("slow");
			            	$("#ready").toggle("slow");
			            	
			            	document.getElementById("bet").disabled = true;
							document.getElementById("call").disabled = true;
							document.getElementById("die").disabled = true;
						}
					}
					else if (id == data.winner) {
						if(!alert("You Win!")) {
							setTimeout(function() {}, 3000);
							document.getElementById("current_bet_per_person").innerHTML = "";
							document.getElementById("player_list").innerHTML = "";
							socket.emit("reload", {room : room});

							card = [];
			                bet = 10;
			                die = false;
			                turn = 0;
			                ready_state = false;
			                
			            	$('#game_menu').toggle("slow");
			            	$("#ready_menu").toggle("slow");
			            	$("#ready").toggle("slow");
			            	
			            	document.getElementById("bet").disabled = true;
							document.getElementById("call").disabled = true;
							document.getElementById("die").disabled = true;
						}
					} else {
						if(!alert("You Lose!")) {
							document.getElementById("current_bet_per_person").innerHTML = "";
							document.getElementById("player_list").innerHTML = "";
							socket.emit("reload", {room : room});

							card = [];
			                bet = 10;
			                die = false;
			                turn = 0;
			                ready_state = false;
			                
			            	$('#game_menu').toggle("slow");
			            	$("#ready_menu").toggle("slow");
			            	$("#ready").toggle("slow");
			            	
			            	document.getElementById("bet").disabled = true;
							document.getElementById("call").disabled = true;
							document.getElementById("die").disabled = true;
						}
					}
					}, 2000);
                });

            });
            
////////////////////////////////////////////////////////////////////////////////

			function image_match(num){
				var img_file = "";
				if (num == 10) {
					img_file = "1_0.gif";
				} else if (num == 11) {
					img_file = "1_1.gif";
				} else if (num == 21) {
					img_file = "2_1.gif";
				} else if (num == 20) {
					img_file = "2_0.gif";
				} else if (num == 31) {
					img_file = "3_1.gif";
				} else if (num == 30) {
					img_file = "3_0.gif";
				} else if (num == 41) {
					img_file = "4_1.gif";
				} else if (num == 40) {
					img_file = "4_0.gif";
				} else if (num == 51) {
					img_file = "5_1.gif";
				} else if (num == 50) {
					img_file = "5_0.gif";
				} else if (num == 61) {
					img_file = "6_1.gif";
				} else if (num == 60) {
					img_file = "6_0.gif";
				} else if (num == 71) {
					img_file = "7_1.gif";
				} else if (num == 70) {
					img_file = "7_0.gif";
				} else if (num == 81) {
					img_file = "8_1.gif";
				} else if (num == 80) {
					img_file = "8_0.gif";
				} else if (num == 91) {
					img_file = "9_1.gif";
				} else if (num == 90) {
					img_file = "9_0.gif";
				} else if (num == 101) {
					img_file = "10_1.gif";
				} else if (num == 100) {
					img_file = "10_0.gif";
				} else {
					img_file = "tail.png";
				}
				return img_file;
			}

			function show_head (class_name) {
console.log("click");
               	if (class_name != id + "_tail") {
               		return;
               	}
               	if (die == true) {return;}
               	else if (card.length == 2) {return;}
               	else if (turn == 1 && card.length == 1) {return;}
               	else {socket.emit("get_head", { id: id, room: room });}
            };
            
            function digit10 (num) {
                if (num >= 100) {return 0;}
                return parseInt(num/10);
            }
            
            function jok_bo (card) {
                if (card.length != 2) {
                    return 2222;
                }
                var sorted = card.sort(function(a, b) { // asending (1, 2, 3, ...)
                    return a - b;
                });

                var small = sorted[0];
                var big = sorted[1];
                var jokbo = 1111;
// console.log("small : " + small + " / big : " +  big);
                if (big == 81 && small == 31) {
                    jokbo = 1;
                } else if (big == 81 && small == 11) {
                    jokbo = 2;
                } else if (big == 31 && small == 11) {
                    jokbo = 3;
                
                } else if (big == 101 && small == 100) {
                    jokbo = 4;
                } else if (big == 91 && small == 90) {
                    jokbo = 11;
                } else if (big == 81 && small == 80) {
                    jokbo = 12;
                } else if (big == 71 && small == 70) {
                    jokbo = 13;
                } else if (big == 61 && small == 60) {
                    jokbo = 14;
                } else if (big == 51 && small == 50) {
                    jokbo = 15;
                } else if (big == 41 && small == 40) {
                    jokbo = 16;
                } else if (big == 31 && small == 30) {
                    jokbo = 17;
                } else if (big == 21 && small == 20) {
                    jokbo = 18;
                } else if (big == 11 && small == 10) {
                    jokbo = 19;
                
                } else if (small == 10 && big == 20
                        || small == 10 && big == 21
                        || small == 11 && big == 21) {
                    jokbo = 21;
                } else if (small == 10 && big == 40
                        || small == 10 && big == 41
                        || small == 11 && big == 41) {
                    jokbo = 22;
                } else if (small == 10 && big == 90
                        || small == 10 && big == 91
                        || small == 11 && big == 91) {
                    jokbo = 23;
                } else if (small == 10 && big == 100
                        || small == 10 && big == 101
                        || small == 11 && big == 101) {
                    jokbo = 24;
                } else if (small == 40 && big == 100
                        || small == 40 && big == 101
                        || small == 41 && big == 101) {
                    jokbo = 25;
                } else if (small == 40 && big == 60
                        || small == 40 && big == 61
                        || small == 41 && big == 61) {
                    jokbo = 26;
                
                } else if (big == 71 && small == 41) {
                    jokbo = 101;
                } else if (big == 71 && small == 31) {
                    jokbo = 102;
                } else if (big == 91 && small == 41) {
                    jokbo = 103;
                } else if (digit10(big) == 4 && digit10(small) == 9) {
                    jokbo = 104;
                 
                } else if (digit10(big) + digit10(small) == 9 || digit10(big) + digit10(small) == 19) {
                    jokbo = 30;
                } else if (digit10(big) + digit10(small) == 8 || digit10(big) + digit10(small) == 18) {
                    jokbo = 31;
                } else if (digit10(big) + digit10(small) == 7 || digit10(big) + digit10(small) == 17) {
                    jokbo = 32;
                } else if (digit10(big) + digit10(small) == 6 || digit10(big) + digit10(small) == 16) {
                    jokbo = 33;
                } else if (digit10(big) + digit10(small) == 5 || digit10(big) + digit10(small) == 15) {
                    jokbo = 34;
                } else if (digit10(big) + digit10(small) == 4 || digit10(big) + digit10(small) == 14) {
                    jokbo = 35;
                } else if (digit10(big) + digit10(small) == 3 || digit10(big) + digit10(small) == 13) {
                    jokbo = 36;
                } else if (digit10(big) + digit10(small) == 2 || digit10(big) + digit10(small) == 12) {
                    jokbo = 37;
                } else if (digit10(big) + digit10(small) == 1 || digit10(big) + digit10(small) == 11) {
                    jokbo = 38;
                } else if (digit10(big) + digit10(small) == 10 || digit10(big) + digit10(small) == 20) {
                    jokbo = 39;
                }

                return jokbo;
            }
            
            function jok_bo_kor(jokbo) {
            	var korean = "";
            	if (jokbo == 1) {
            		korean = "삼팔광땡";
            	} else if (jokbo == 2) {
            		korean = "일팔광땡";
            	} else if (jokbo == 3) {
            		korean = "일삼광땡";
            	} else if (jokbo == 4) {
            		korean = "장땡";
            	} else if (jokbo == 11) {
            		korean = "구땡";
            	} else if (jokbo == 12) {
            		korean = "팔땡";
            	} else if (jokbo == 13) {
            		korean = "칠땡";
            	} else if (jokbo == 14) {
            		korean = "육땡";
            	} else if (jokbo == 15) {
            		korean = "오땡";
            	} else if (jokbo == 16) {
            		korean = "사땡";
            	} else if (jokbo == 17) {
            		korean = "삼땡";
            	} else if (jokbo == 18) {
            		korean = "이땡";
            	} else if (jokbo == 19) {
            		korean = "일땡";
            	} else if (jokbo == 21) {
            		korean = "알리";
            	} else if (jokbo == 22) {
            		korean = "독사";
            	} else if (jokbo == 23) {
            		korean = "구삥";
            	} else if (jokbo == 24) {
            		korean = "장삥";
            	} else if (jokbo == 25) {
            		korean = "장사";
            	} else if (jokbo == 26) {
            		korean = "세륙";
            	} else if (jokbo == 101) {
            		korean = "암행어사";
            	} else if (jokbo == 102) {
            		korean = "땡잡이";
            	} else if (jokbo == 103) {
            		korean = "멍구사";
            	} else if (jokbo == 104) {
            		korean = "구사";
            	} else if (jokbo == 30) {
            		korean = "갑오";
            	} else if (jokbo == 31) {
            		korean = "여덟끗";
            	} else if (jokbo == 32) {
            		korean = "일곱끗";
            	} else if (jokbo == 33) {
            		korean = "여섯끗";
            	} else if (jokbo == 34) {
            		korean = "다섯끗";
            	} else if (jokbo == 35) {
            		korean = "네끗";
            	} else if (jokbo == 36) {
            		korean = "세끗";
            	} else if (jokbo == 37) {
            		korean = "두끗";
            	} else if (jokbo == 38) {
            		korean = "한끗";
            	} else if (jokbo == 39) {
            		korean = "망통";
            	} else {
            		korean = "나가리";
            	}
            	return korean;
            }
    </script>
