package vegas.koreate.game.service;

import java.util.List;

import vegas.koreate.game.vo.GameVO;
import vegas.koreate.game.vo.RoomVO;
import vegas.koreate.util.Criteria;
import vegas.koreate.util.PageMaker;
import vegas.koreate.util.RoomCri;
import vegas.koreate.util.RoomPage;

public interface GameService {

	// 게임 등록
	String gameReg(GameVO gamevo) throws Exception;

	// 등록된 게임정보를 List로 가져오기
	List<GameVO> gameList(Criteria cri) throws Exception;
	
	// pageMaker
	PageMaker getPageMaker(Criteria cri) throws Exception;

	// 게임방 만들기
	int roomReg(RoomVO rvo) throws Exception;

	// 등록된 방 List 가져오기
	List<RoomVO> room(RoomCri roomCri) throws Exception;

	// RoomPage
	RoomPage roomPage(RoomCri roomCri) throws Exception;

	//boolean roomNameCheck(String roomName);
	

}
