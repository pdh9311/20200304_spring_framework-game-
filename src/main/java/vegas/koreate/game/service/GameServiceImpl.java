package vegas.koreate.game.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vegas.koreate.game.dao.GameDAO;
import vegas.koreate.game.vo.GameVO;
import vegas.koreate.game.vo.RoomVO;
import vegas.koreate.util.Criteria;
import vegas.koreate.util.PageMaker;
import vegas.koreate.util.RoomCri;
import vegas.koreate.util.RoomPage;

@Service
public class GameServiceImpl implements GameService{

	@Inject
	GameDAO gdao;
	
	@Override
	public String gameReg(GameVO gamevo) throws Exception {
		int result = gdao.gameReg(gamevo);
		String message = (result > 0) ? "게임이 등록 되었습니다." : "다시 시도해주세요."; 
		return message;
	}

	@Override
	public List<GameVO> gameList(Criteria cri) throws Exception {
		return gdao.gameList(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(3);
		pageMaker.setTotalCount(gdao.listCount());
		return pageMaker;
	}

	@Transactional
	@Override
	public int roomReg(RoomVO rvo) throws Exception {
		gdao.roomReg(rvo);
		int roomNum = gdao.getRoomNum(rvo);
		return roomNum;
	}

	@Override
	public List<RoomVO> room(RoomCri roomCri) throws Exception {
		return gdao.room(roomCri);
	}

	@Override
	public RoomPage roomPage(RoomCri roomCri) throws Exception {
		RoomPage roomPage = new RoomPage();
		roomPage.setRoomCri(roomCri);
		roomPage.setRoomTotalCount(gdao.roomCount());
		return roomPage;
	}
/*
	@Override
	public boolean roomNameCheck(String roomName) {
		 boolean isRoomNameCheck = (gdao.roomNameCheck(roomName) >= 1) ? false : true ;
		 return isRoomNameCheck ;
	}
*/
	
	
	
}
