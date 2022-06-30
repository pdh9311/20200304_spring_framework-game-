///////////////// MySQL ///////////////////////
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'java',
  password : 'java',
  database : 'mydata'
});

/* gambler_member, gambler_cash, gambler_id */
//////////////// deck & shuffle ////////////////
var base_deck = [10, 11, 20, 21, 30, 31, 40, 41, 50, 51, 60, 61, 70, 71, 80, 81, 90, 91, 100, 101];
function shuffle() {
    var array = base_deck.slice(0);

    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    return array;
}

////////////// Room control objet /////////////
var rooms = {};
class info {
    constructor(number) {
        this.room_num = number;
        this.user_num = Number(0);
        this.deck_list = shuffle();
        this.deck_count = Number(0);
        this.room_ready = Number(0);            // SYNC!!!!!!!
        this.room_member = new Object;
        this.order = new Array();
        this.bet = Number(10);
        this.total_bet = Number(0);
        this.turn = Number(0);
        this.result = new Object;
        this.tie = Number(0);
    }
}

/////////////// New Player HTML ///////////////
function new_player_code (room_member) {
    var code = "";

    for (var key in room_member) {
        var id = key;
        code += "<li id='" + id + "' class='user'>";
        code += "<div id='player'>";
        code += "<img id='" + id + "_img' src='' width='100' height='100'/> <br/>";
        code += "<h3 id='" + id + "_betting'></h3><br/>";
        code += "<h2 id='" + id + "_status'>" + id + "</h2><br/>";
        code += "<ul id='" + id + "_hand'></ul>";
        code += "</div>";
        code += "</li>";
    }   
    
    return code;
}

///////////////// jok_bo //////////////////
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



/////////////// Network setting ///////////////
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var system = io.of('/system');
var slot = io.of('/slot');

http.listen(82, function () {
    console.log('listening on *:82');
});
 
/////////////////// Slot //////////////////////
slot.on('connection', function(socket) {
    // jackpot && refund rate
    socket.on("slot_number", function(data) {
        socket.emit("slot_number", {num : Math.floor(Math.random() * 100), option : data.option});
    });

    socket.on("slot_result", function(data) {
        console.log(data.id + " : " + data.bet + "*" + data.result);
        connection.query('UPDATE gambler_member SET gambler_cash = gambler_cash + ' + data.bet * data.result + ' WHERE gambler_id = "' + data.id + '";', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
        });
        connection.query('SELECT * from gambler_member WHERE gambler_id = "' + data.id + '";', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
            if (results[0]["gambler_cash"] <= 0) {
                socket.emit('get_out', {id : data.id});
                console.log("get_out");
            } else {
                console.log(data.id + " : " + results[0]["gambler_cash"]);
            }
        });
    });

    socket.on("bet_fix", function(data) {
        console.log(data.id + " : " + data.bet);
        connection.query('UPDATE gambler_member SET gambler_cash = gambler_cash - ' + data.bet + ' WHERE gambler_id = "' + data.id + '";', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
        });
    });
});

///////////////// Namespace ///////////////////
system.on('connection', function(socket) {

//////////////////// Room /////////////////////
    socket.on("joinRoom", function(data) {
        socket.join(data.room, function(){});

        if (!(data.room in rooms)) {
            rooms[data.room] = new info(data.room);
        }
        
        var temp_id = data.id;
        rooms[data.room].room_member[temp_id] = socket;
        rooms[data.room].user_num = Object.keys(rooms[data.room].room_member).length;
        
        var temp_order = rooms[data.room].user_num -1;
        rooms[data.room].order[temp_order] = socket;
        
        console.log(rooms[data.room].room_member);
        connection.query('SELECT * from game_room WHERE room_num = ' + data.room + ';', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
            if (results[0]["playStatus"] == false) {
                system.to(data.room).emit('new_player', new_player_code(rooms[data.room].room_member));
            } else {
                console.log("user CUT!");
                system.to(data.room).emit("die", {id: data.id});
            }
        });

        

        socket.on('disconnect', function () {
            socket.leave(data.room, function() {});
            rooms[data.room].user_num -= 1;
            delete rooms[data.room].room_member[temp_id];
            rooms[data.room].order.splice(temp_order, 1);
            rooms[data.room].order = rooms[data.room].order.filter(function (i) {return i != null;});
            connection.query('SELECT * from game_room WHERE room_num = ' + data.room + ';', function (error, results, fields) {
                if (error) {
                    console.log(error);
                }
                if (results[0]["playStatus"] == false) {
                    system.to(data.room).emit('new_player', new_player_code(rooms[data.room].room_member));
                } else {
                    console.log("user CUT!");
                    system.to(data.room).emit("die", {id: data.id});
                }
            });
        });
    });

    socket.on('reload', function(data) {
        system.to(data.room).emit('new_player', new_player_code(rooms[data.room].room_member));
    });

    socket.on("get_head", function(data) {
        var num = data.room;
        socket.emit("get_head", {num : rooms[num].deck_list[rooms[num].deck_count]});
        if (rooms[num].deck_count == 19) {  
            rooms[num].deck_count = 0;  // this might be unnecessary
        } else {
            rooms[num].deck_count++;
        }
    });

    socket.on("chat", function(data) {
        system.to(data.room).emit('chat', {id: data.id, text: data.text});
    });

//////////////// Game process ///////////////////

    socket.on("ready", function(data) {
        
        system.to(data.room).emit("ready", {id: data.id});
        rooms[data.room].room_ready += 1;
        if (rooms[data.room].room_ready == rooms[data.room].user_num && rooms[data.room].user_num != 1) {   // game_start_condition // system.to(data.room).emit("start"); (?)

        // DB work
            connection.query('UPDATE game_room SET playStatus = true WHERE room_num = ' + data.room + ';', function (error, results, fields) {
                if (error) {
                    console.log(error);
                }
            });

            system.to(data.room).emit("OK", {user_num : rooms[data.room].user_num});
            for (var key in rooms[data.room].room_member) {                 
                system.to(data.room).emit("get_tail", key);
            }
            rooms[data.room].turn = 1;
            rooms[data.room].room_ready = 0;
            rooms[data.room].order[0].emit("bet", {bet: rooms[data.room].bet, turn: rooms[data.room].turn, total: rooms[data.room].user_num*10});
        } else {}
    });

    socket.on("second_phase_start", function(data) {
        system.to(data.room).emit("second_phase_start", {turn : 2});
console.log("second_phase_start");
        for (var key in rooms[data.room].room_member) {
            system.to(data.room).emit("get_tail", key);
        }
        rooms[data.room].turn = 2;
        rooms[data.room].room_ready = 0;
        rooms[data.room].order[0].emit("bet", {bet: rooms[data.room].bet, turn: rooms[data.room].turn, total: rooms[data.room].total_bet});
    });

/////////////////// result  ///////////////////

    socket.on("summary", function(data) {   // id, room, bet, card
        system.to(data.room).emit("open", {id: data.id, card: data.card});

        var jokbo = jok_bo(data.card);

        rooms[data.room].result[data.id] = jokbo;
        rooms[data.room].room_ready += 1;           // lock for sync? I heard that javascript use one thread but...

        if (rooms[data.room].room_ready == rooms[data.room].user_num) {
            var winner = "";
            var winner_jokbo = 1000;
            for (var key in rooms[data.room].result) {
                if (winner_jokbo > rooms[data.room].result[key]) {
                    winner = key;
                    winner_jokbo = rooms[data.room].result[key];
                }
            }

            // Special condition
            if (winner_jokbo == 2 && winner_jokbo == 3) {
                // 암행어사
                for (var key in rooms[data.room].result) {
                    if (rooms[data.room].result[key] == 101) {
                        winner = key;
                        winner_jokbo = rooms[data.room].result[key];
                    }
                }
            } else if (winner_jokbo >= 11 && winner_jokbo <= 19) {
                // 땡잡이
                for (var key in rooms[data.room].result) {
                    if (rooms[data.room].result[key] == 102) {
                        winner = key;
                        winner_jokbo = rooms[data.room].result[key];
                    }
                }
            } else if (winner_jokbo >= 11 && winner_jokbo <= 39) {
                // 멍구사: 재경기
                for (var key in rooms[data.room].result) {
                    if (rooms[data.room].result[key] == 103) {
                        winner = "!@#rematch";
                        console.log("rematch");
                    }
                }
            } else if (winner_jokbo >= 21 && winner_jokbo <= 39) {
                // 구사: 재경기
                for (var key in rooms[data.room].result) {
                    if (rooms[data.room].result[key] == 104) {
                        winner = "!@#rematch";
                        console.log("rematch");
                    }
                }
            }
            // tie
            rooms[data.room].tie = 0;
            for (var key in rooms[data.room].result) {
                if (winner_jokbo == rooms[data.room].result[key]) {
                    rooms[data.room].tie++;
                }
            }

            if(rooms[data.room].tie >= 2) {
                winner = "!@#rematch";
            }

            rooms[data.room].tie = 0;

console.log("winner : " + winner + " / jokbo : " + winner_jokbo);
            system.to(data.room).emit("winner", {winner : winner});

            connection.query('UPDATE gambler_member SET gambler_cash = gambler_cash + ' + Math.floor(rooms[data.room].total_bet * 0.99) + ' WHERE gambler_id = "' + winner + '";', function (error, results, fields) {
                if (error) {
                    console.log(error);
                }
            });

            for (var key in rooms[data.room].room_member) {
                connection.query('SELECT * from gambler_member WHERE gambler_id = "' + key + '";', function (error, results, fields) {
                    if (error) {
                        console.log(error);
                    }
                    if (results[0]["gambler_cash"] <= 0) {
                        console.log("get_out, " + results[0]["gambler_id"]);
                        rooms[data.room].room_member[results[0]["gambler_id"]].emit('get_out');
                    }
                });
            }
            
            rooms[data.room].deck_list = shuffle();
            rooms[data.room].deck_count = Number(0);
            rooms[data.room].room_ready = Number(0);            // SYNC!!!!!!!
            rooms[data.room].bet = Number(10);
            rooms[data.room].total_bet = Number(0);
            rooms[data.room].turn = Number(0);
            rooms[data.room].result = new Object;

            for (var sk in rooms[data.room].order) {
                if (rooms[data.room].order[sk] == rooms[data.room].room_member[winner]) {
                    rooms[data.room].order.splice(sk, 1);
                console.log(rooms[data.room].room_member);
                    rooms[data.room].order = rooms[data.room].order.filter(function (i) {return i != null;});
                console.log(rooms[data.room].room_member);
                    rooms[data.room].order.unshift(rooms[data.room].room_member[winner]);
                console.log(rooms[data.room].room_member);
                    break;
                }
            }

            connection.query('UPDATE game_room SET playStatus = false WHERE room_num = ' + data.room + ';', function (error, results, fields) {
                if (error) {
                    console.log(error);
                }
            });
        }
    });

////////////// betting algorithm //////////////
    
    socket.on("die", function(data) {
console.log(data.id + ", this user is dead");
        system.to(data.room).emit("die", {id: data.id});
    });

    socket.on("start_bet", function(data) {
        rooms[data.room].total_bet += data.bet;
        connection.query('UPDATE gambler_member SET gambler_cash = gambler_cash - ' + data.bet + ' WHERE gambler_id = "' + data.id + '";', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
        });

        console.log(data.id + " bet : " + data.bet + " / " + "room's bet : " + rooms[data.room].bet + " / total bet : " + rooms[data.room].total_bet);
    });

    socket.on("bet", function(data) {
        rooms[data.room].total_bet += Number(data.new_bet);
        system.to(data.room).emit('bet_update', {id: data.id, bet: data.bet, total: rooms[data.room].total_bet});

        connection.query('UPDATE gambler_member SET gambler_cash = gambler_cash - ' + data.new_bet + ' WHERE gambler_id = "' + data.id + '";', function (error, results, fields) {
            if (error) {
                console.log(error);
            }
        });

        var idx = Number(-1);
        if (socket == rooms[data.room].order[0]) {
            idx = 0;
        } else if (socket == rooms[data.room].order[1]) {
            idx = 1;
        } else if (socket == rooms[data.room].order[2]) {
            idx = 2;
        } else if (socket == rooms[data.room].order[3]) {
            idx = 3;
        }

        if (data.die == true) {
            rooms[data.room].room_ready += 1;
        }
        else if (rooms[data.room].bet == data.bet) {
            rooms[data.room].room_ready += 1;
        } else {
            rooms[data.room].room_ready = 1;
            rooms[data.room].bet = data.bet;
        }

console.log(data.id + " bet : " + data.new_bet + " / " + "room's bet : " + rooms[data.room].bet + " / total bet : " + rooms[data.room].total_bet);
console.log("ready : " + rooms[data.room].room_ready +  "/" + rooms[data.room].user_num);

        if (rooms[data.room].room_ready == rooms[data.room].user_num) {
            rooms[data.room].room_ready = 0;

            if (rooms[data.room].turn == 1) {
                rooms[data.room].order[idx].emit("first_phase_over");
            } else if (rooms[data.room].turn == 2) {
                system.to(data.room).emit("second_phase_over");
            }
        
        } else {
            if (rooms[data.room].user_num == idx+1) {
                rooms[data.room].order[0].emit("bet", {bet: rooms[data.room].bet, turn: rooms[data.room].turn, total: rooms[data.room].total_bet});
            } else {
                rooms[data.room].order[idx+1].emit("bet", {bet: rooms[data.room].bet, turn: rooms[data.room].turn, total: rooms[data.room].total_bet});
            }
        }
    });
});

/*
    01. Is there any way to controll 'socket.connection' / 'namespace.conneciton' / 'room.connection' ?
    02. when disconnected, is 'room.leave' necessary?
    03. If someone is playing multiple games?
    05. 배팅 금액의 최대 / 최소 / 올인 설정?
    06. 특정 코드 지우기 .remove();
    07. 뒷면 id="[id_tail]" / 앞면 id="[id_head]"
    08. .jsp 에서 get_head로 온 결과를 따로 보관하고 매판 리셋
    09. dictionary element 지우기 : delete myArray["lastname"];
    10. dictionary에 key 추가할 때 문제가 생기면 임의의 dictionary 형태 element를 미리 넣어준다. 
    11. 방 입장 : 게시판 화면에서 방 번호를 가져와서 세션(?)에 저장하고 (게임).jsp로 이동해서 방 번호와 함께 접속했다는 신호를 서버에 전달한다.
    12. 11번에 규칙에 따라 socket 이외의 신호는 받을 필요 없다.
    13. 방 만들기 : DB에 등록하고 결과로 방 번호를 받아서 방 입장을 자동으로 시킨다.
    14. 방 폭파 : disconnect 신호가 왔을 때 남은 인원 수가 0이라면 DB에서 방을 제거하고 rooms에서도 지운다.
    15. 방 생성 / 제거 : 자동인가?
    15. 배팅 순서는 이긴 사람부터 순서대로 돌아간다.
    16. 게임 진행 중일 땐 게시판에서 접속 제한
*/

/*
    socket.emit();              : only one
    system.emit(); / io.emit(); : to all
    system.to(room).emit();     : to room memberS
    socket.broadcast.emit();    : to all except 'socket' 

    { id: userid, name: username } : multiple variable
*/

/*  [QUERY]
    connection.query('SELECT * FROM re_tbl_board', function (error, results, fields) {
        if (error) {
            console.log(error);
        }
        
        console.log(results);
        console.log(results[3].bno);
        console.log(results[3].bno);
        console.log(results[3].bno);
        console.log(results[3].bno);
        console.log(results[3].bno);
    });
*/