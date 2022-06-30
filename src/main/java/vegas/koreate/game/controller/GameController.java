package vegas.koreate.game.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vegas.koreate.game.service.GameService;
import vegas.koreate.game.vo.GameVO;
import vegas.koreate.game.vo.RoomVO;
import vegas.koreate.util.Criteria;
import vegas.koreate.util.RoomCri;

@Controller
@RequestMapping("/game")
public class GameController {

	@Inject
	GameService gs;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Resource(name="uploadFolder")
	String uploadFolder;
	
	@Autowired
	@Qualifier("servletContext")
	ServletContext context;
	
	@RequestMapping("/gameList")
	public void gameList(
			@ModelAttribute Criteria cri,
			Model model) throws Exception {
		cri.setPerPageNum(3);
		model.addAttribute("gList",gs.gameList(cri));
		model.addAttribute("pageMaker",gs.getPageMaker(cri));
	}
	
	@RequestMapping("/gameReg")
	public String gameReg() throws Exception {
		return "/game/gameReg";
	}

	@RequestMapping("/gameRegResult")
	public String gameRegResult(
			@RequestParam("file") MultipartFile file,
			GameVO gamevo,
			RedirectAttributes rttr) throws Exception {
		uploadPath = context.getRealPath(File.separator+uploadFolder);
		System.out.println("uploadPath : " + uploadPath);
		File file1 = new File(uploadPath);
		if(!file1.exists()) {
			file1.mkdirs();	// 경로 생성
		}
		String game_thumbnail = uploadFile(file.getOriginalFilename(),file.getBytes());
		gamevo.setGame_thumbnail(game_thumbnail);
		
		String message = gs.gameReg(gamevo);
		rttr.addFlashAttribute("message", message);
		return "redirect:/game/gameList";
	}
	
	public String uploadFile(String originalName, byte[] fileData) throws IOException{
		String savedName = "";
		
		// 32개의 십육진수  '-' 4개  총 36개의 문자열 자동으로 랜덤하게 생성 
		UUID uid = UUID.randomUUID();

		savedName = uid.toString().replace("-", "")+"_"+originalName;
		
		File file = new File(uploadPath,savedName);
		
		FileCopyUtils.copy(fileData, file);
		
		return savedName;
	}
	
	@RequestMapping("/seodda")
	public String seodda(
			@ModelAttribute RoomCri	roomCri,
			@RequestParam(name="page") int page,
			@RequestParam(name="game_num") int game_num,
			@RequestParam(name="game_name") String game_name,
			Model model) throws Exception{
		model.addAttribute("page",page);
		model.addAttribute("game_num",game_num);
		model.addAttribute("game_name",game_name);
		model.addAttribute("room",gs.room(roomCri));
		model.addAttribute("roomPage",gs.roomPage(roomCri));
		return "game/seodda";
	}

	@RequestMapping("/gameRoomReg")
	public String gameRoomReg(
			@RequestParam(name="page") int page,
			@RequestParam(name="game_num") int game_num,
			@RequestParam(name="game_name") String game_name,
			Model model	) throws Exception {
		model.addAttribute("page",page);
		model.addAttribute("game_num",game_num);
		model.addAttribute("game_name",game_name);
		return "game/gameRoomReg";
	}
	
	@RequestMapping("/gameRoomRegResult")
	public String gameRoomRegResult( 
			RoomVO rvo,
			RedirectAttributes rttr,
			@RequestParam(name="page") int page,
			@RequestParam(name="game_num") int game_num,	
			@RequestParam(name="game_name") String game_name) throws Exception {
		rttr.addAttribute("page",page);
		rttr.addAttribute("game_num",game_num);
		rttr.addAttribute("game_name",game_name);
		
		//String message = gs.roomReg(rvo);
		int roomNum = gs.roomReg(rvo);
		String message = (roomNum != 0) ? "방을 만들었습니다." : "방을 만들지 못했습니다.";
		rttr.addAttribute("room_num",roomNum);
		rttr.addFlashAttribute("message",message);
		
		return "redirect:/game/sutda";
	}
	
	@RequestMapping("/sutda")
	public String playGame() {
		return "game/sutda";
	}

	@RequestMapping("/slot")
	public String slot() {
		return "game/slot";
	}
	
	
	
}
