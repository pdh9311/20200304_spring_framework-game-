USE gambler;

SHOW TABLES;

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

UPDATE gambler_member 
SET gambler_cash = 1000000
WHERE gambler_id = 'admin@admin.com';

UPDATE gambler_member 
SET gambler_cash = 0
WHERE gambler_id = 'admin@admin.com';





DELETE FROM gambler_member;
SELECT * FROM gambler_member;
DROP TABLE gambler_member;
DESC gambler_member;

ALTER TABLE gambler_member ADD(gambler_image VARCHAR(200));


CREATE TABLE gambler_game(
	game_num INT PRIMARY KEY auto_increment,	
	game_title VARCHAR(50) NOT NULL,
	game_writer VARCHAR(50) NOT NULL,
	game_content TEXT NOT NULL,
	game_regdate TIMESTAMP NULL default now(),
	game_thumbnail VARCHAR(50) NOT NULL
);

DELETE FROM gambler_game;
SELECT * FROM gambler_game;
DROP TABLE gambler_game;
DESC gambler_game;

CREATE TABLE game_room(
	room_num INT PRIMARY KEY auto_increment,
	room_title VARCHAR(50) NOT NULL, 
	playStatus boolean default false,
	game_name VARCHAR(50) NOT NULL
);

DELETE FROM game_room;
SELECT * FROM game_room;
DROP TABLE game_room;
DESC game_room;

INSERT INTO game_room VALUES(1,'1번방',false,'seodda');
INSERT INTO game_room VALUES(2,'2번방',true,'seodda');
INSERT INTO game_room VALUES(3,'3번방',true,'seodda');
INSERT INTO game_room VALUES(4,'4번방',false,'seodda');
INSERT INTO game_room VALUES(5,'5번방',false,'seodda');
INSERT INTO game_room VALUES(6,'6번방',false,'seodda');

INSERT INTO game_room(room_title,playStatus,game_name) 
SELECT room_title,playStatus,game_name FROM game_room;

---------------------------------------------


DESC tbl_user;

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
	gambler_num INT NOT NULL
);

ALTER TABLE total_board ADD CONSTRAINT fk_total_board_uno 
FOREIGN KEY(uno) REFERENCES gambler_member(gambler_num);

DELETE FROM total_board; 
SELECT * FROM total_board;
DESC total_board;

INSERT INTO total_board(title,content,writer,origin,gambler_num) 
SELECT title,content,writer,origin,gambler_num FROM total_board;


























