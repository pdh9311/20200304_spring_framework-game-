package vegas.koreate.mvc.controller;


import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import vegas.koreate.game.service.GameService;
import vegas.koreate.util.Criteria;


@Controller
public class HomeController {
	
	@Inject
	GameService gs;

	@Resource(name="uploadPath")
	String uploadPath;
	
	@Resource(name="uploadFolder")
	String uploadFolder;
	
	
	@RequestMapping("/")
	public String home(
			@ModelAttribute Criteria cri,
			Model model) throws Exception {
		cri.setPerPageNum(3);
		model.addAttribute("gList",gs.gameList(cri));
		model.addAttribute("pageMaker",gs.getPageMaker(cri));
		return "home";
	}

	
	
}
