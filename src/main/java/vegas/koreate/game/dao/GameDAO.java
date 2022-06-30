package vegas.koreate.game.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import vegas.koreate.game.vo.GameVO;
import vegas.koreate.game.vo.RoomVO;
import vegas.koreate.util.Criteria;
import vegas.koreate.util.RoomCri;

public interface GameDAO {

	// 게임 등록
	@Insert("INSERT INTO gambler_game(game_title,game_writer,game_content,game_thumbnail) "
			+ "VALUES(#{game_title},#{game_writer},#{game_content},#{game_thumbnail})")
	int gameReg(GameVO gamevo) throws Exception;

	// 게임 리스트 
	@Select("SELECT * FROM gambler_game ORDER BY game_num DESC LIMIT #{pageStart},#{perPageNum}")
	List<GameVO> gameList(Criteria cri) throws Exception;

	// 게임 리스트 총 개수
	@Select("SELECT count(*) FROM gambler_game")
	int listCount() throws Exception;

	// 게임방 만들기
	@Insert("INSERT INTO game_room(room_title,game_name) "
			+ "VALUES(#{room_title},#{game_name})")
	int roomReg(RoomVO rvo) throws Exception;

	// 등록된 방 List 가져오기
	@Select("SELECT * FROM game_room ORDER BY room_num DESC LIMIT #{roomPageStart},#{roomPerPageNum}")
	List<RoomVO> room(RoomCri rCri) throws Exception;

	// 등록된 방 총 개수
	@Select("SELECT count(*) FROM game_room")
	int roomCount() throws Exception;
	
	// 방 등록시 방번호 가져오기
	@Select("SELECT room_num FROM game_room WHERE room_title = #{room_title}")
	int getRoomNum(RoomVO rvo);

	// 방이름 중복확인
	//@Select("SELECT count(*) FROM game_room WHERE roomtitle = #{roomName}")
	//int roomNameCheck(String roomName);

	//
	//@Select("SELECT room_num FROM game_room WHERE room_title = #{room_title}")
	//int roomNum(RoomVO rvo);

}
