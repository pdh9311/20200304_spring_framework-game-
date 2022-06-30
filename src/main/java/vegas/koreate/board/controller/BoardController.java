package vegas.koreate.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vegas.koreate.board.service.BoardService;
import vegas.koreate.board.vo.BoardVO;
import vegas.koreate.util.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	BoardService service;

	@GetMapping("list")
	public String getBoardList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		System.out.println("cont_list");
		System.out.println("cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", service.getPageMaker(cri));

		return "board/list";
	}

	@GetMapping("write")
	public String write_g(BoardVO board) throws Exception {
		return "board/write";

	}

	@PostMapping("write")
	public String write_p(BoardVO board) throws Exception {
		System.out.println("cont_wri");
		System.out.println("write board : " + board);
		service.write(board);
		return "redirect:/board/list";

	}

	@GetMapping("replywrite")
	public String replyRegisterGet(
			int bno, 
			@ModelAttribute("cri") SearchCriteria cri, 
			Model model) throws Exception {
		model.addAttribute("board", service.read(bno));
		return "board/replyRegister";
	}

	@PostMapping("replywrite")
	public String replyRegisterPost(
			RedirectAttributes rttr, 
			BoardVO vo, 
			SearchCriteria cri) throws Exception {
		// 답변글 등록
		System.out.println("<답변글정보> : " + vo);
		service.replywrite(vo);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}

	@GetMapping("readPage")
	public String readPage(SearchCriteria cri, int bno, RedirectAttributes rttr) throws Exception {

		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/read";
	}

	@GetMapping("read")
	public String read(@ModelAttribute("cri") SearchCriteria cri, Model model, int bno) throws Exception {
		System.out.println("read : " + cri);
		model.addAttribute("board", service.read(bno));
		return "board/read";
	}

	@GetMapping("update")
	public String update_g(
			int bno, 
			@ModelAttribute("cri") SearchCriteria cri,
			Model model) throws Exception {
		model.addAttribute("board", service.read(bno));
		return "board/update";

	}
	
	@PostMapping("update")
	public String update_p(
			BoardVO board, 
			@ModelAttribute("cri") SearchCriteria cri, 
			RedirectAttributes rttr) throws Exception {
		System.out.println("cont_wri");
		service.update(board);
		rttr.addAttribute("bno", board.getBno());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/read";

	}

	@GetMapping("remove")
	public String remove(int bno) throws Exception {
		service.delete(bno);
		return "redirect:/board/list";
	}

}
