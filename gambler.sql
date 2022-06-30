USE gambler;

SHOW TABLES;

DROP TABLE total_board_comment;
DROP TABLE total_board;
DROP TABLE h_bet;
DROP TABLE gambler_member;
DROP TABLE gambler_game;
DROP TABLE game_room;
DROP TABLE h_total;

CREATE TABLE gambler_member(
	gambler_num INT PRIMARY KEY auto_increment,			-- 회원번호
	gambler_id VARCHAR(50) NOT NULL,					-- 회원아이디(email)
	gambler_pw VARCHAR(50) NOT NULL,					-- 비밀번호
	gambler_name VARCHAR(50) NOT NULL,					-- 이름
	gambler_birth VARCHAR(50) NOT NULL ,				-- 생년월일
	gambler_gender VARCHAR(10) NOT NULL,				-- 성별
	gambler_phone VARCHAR(50) NOT NULL,					-- 전화번호
	gambler_addr_post VARCHAR(50),						-- 우편번호 
	gambler_addr VARCHAR(50),							-- 주소
	gambler_addr_detail VARCHAR(50),					-- 상세주소
	gambler_infoOk char(1),								-- 개인정보 이용동의
	gambler_date TIMESTAMP NOT NULL default now(),		-- 계정 생성일
	gambler_cash INT default 10000,						-- 캐시
	gambler_win INT default 0,							-- 승
	gambler_lose INT default 0,							-- 패	
	gambler_image VARCHAR(200) NULL						-- 이미지 		16개
);	

insert into gambler_member 
(gambler_id, gambler_pw, gambler_name, gambler_birth, gambler_gender, gambler_phone) values 
('admin@admin.com', 'qwe123', '관리자', '19930311', '남자', '01063810086');
insert into gambler_member 
(gambler_id, gambler_pw, gambler_name, gambler_birth, gambler_gender, gambler_phone) values 
('bb@b', 'bb', 'bb', 'bb', 'bb', 'bb');

CREATE TABLE gambler_game(
	game_num INT PRIMARY KEY auto_increment,	
	game_title VARCHAR(50) NOT NULL,
	game_writer VARCHAR(50) NOT NULL,
	game_content TEXT NOT NULL,
	game_regdate TIMESTAMP NULL default now(),
	game_thumbnail VARCHAR(50) NOT NULL
);

CREATE TABLE game_room(
	room_num INT PRIMARY KEY auto_increment,
	room_title VARCHAR(50) NOT NULL, 
	playStatus boolean default false,
	game_name VARCHAR(50) NOT NULL
);

INSERT INTO game_room(room_title,game_name) VALUES('1','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('2','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('3','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('4','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('5','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('6','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('7','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('8','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('9','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('10','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('11','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('12','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('13','seodda');
INSERT INTO game_room(room_title,game_name) VALUES('14','seodda');

---------------------------------------------

DROP TABLE total_board;

CREATE TABLE total_board(
	bno INT PRIMARY KEY auto_increment,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	writer VARCHAR(50),
	origin INT NULL default 0,
	depth INT NULL default 0,
	seq INT NULL default 0,
	regdate TIMESTAMP NULL default now(),
	updatedate TIMESTAMP NULL default now(),
	gambler_num INT NOT NULL,
	FOREIGN KEY(gambler_num) REFERENCES gambler_member(gambler_num)
);

INSERT INTO total_board(title,content,writer,gambler_num)
VALUES('1번글','1번내용','관리자',1);


CREATE TABLE total_board_comment(
	cno INT PRIMARY KEY auto_increment,
	bno INT NOT NULL,
	commentText TEXT NOT NULL,
	commentAuth VARCHAR(100) NOT NULL,
	regdate TIMESTAMP NOT NULL default now(),
	updatedate TIMESTAMP NOT NULL default now(),
	gambler_num INT NOT NULL,
	FOREIGN KEY(bno) REFERENCES total_board(bno)
);

create table h_bet(
	hnum int not null,
	hbet int not null,
	gambler_num int not null,
	bettime timestamp not null default now(),
	FOREIGN KEY(gambler_num) REFERENCES gambler_member(gambler_num)
);

create table h_total(
	hnum int null,
	hnum_total int null,
	bettime timestamp not null default now()
);

insert into h_total values(1, 0, now());
insert into h_total values(2, 0, now());
insert into h_total values(3, 0, now());
insert into h_total values(4, 0, now());
insert into h_total values(5, 0, now());
insert into h_total values(6, 0, now());
insert into h_total values(7, 0, now());
insert into h_total values(8, 0, now());


