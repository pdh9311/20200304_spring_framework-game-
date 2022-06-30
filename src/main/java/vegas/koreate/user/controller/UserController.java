package vegas.koreate.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vegas.koreate.user.service.UserService;
import vegas.koreate.user.vo.LoginDTO;
import vegas.koreate.user.vo.UserVO;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Inject
	UserService us;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Resource(name="uploadFolder")
	String uploadFolder;
	
	@Autowired
	@Qualifier("servletContext")
	ServletContext context;
	
	@RequestMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	@PostMapping("/loginPost")
	public ModelAndView loginPost(LoginDTO dto) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("loginDTO",dto);
		mav.setViewName("redirect:/");
		return mav;
	};
	
	@GetMapping("/logout")
	public String logout(
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response,
			@CookieValue(name="loginCookie", required = false) Cookie loginCookie
			) throws Exception {
		
		if(session.getAttribute("userInfo") != null) {
			session.removeAttribute("userInfo");
			session.invalidate();
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
			}
		}
		return "redirect:/";
	}
	
	@RequestMapping("/join")
	public String join() {
		System.out.println("uploadPath : " + uploadPath);
		System.out.println("uploadFolder : " + uploadFolder);
		uploadPath = context.getRealPath(File.separator+uploadFolder);
		System.out.println("uploadPath : " + uploadPath);
		File file = new File(uploadPath);
		if(!file.exists()) {
			file.mkdirs();	// 경로 생성
		}
		return "/user/join";
	}

	@PostMapping("/joinPost")
	public String joinPost(
			@RequestParam("file") MultipartFile file,
			UserVO vo,
			RedirectAttributes rttr) throws Exception {
		System.out.println("file name : " + file.getOriginalFilename());
		System.out.println("file size : " + file.getSize());
		System.out.println("file Type : " + file.getContentType());
		System.out.println("file Bytes : " + file.getBytes());
		
		String gambler_image = uploadFile(file.getOriginalFilename(),file.getBytes());
		vo.setGambler_image(gambler_image);
		
		us.join(vo);
		rttr.addFlashAttribute("message", "회원가입성공");
		return "redirect:/user/login";
	};
	
	public String uploadFile(String originalName, byte[] fileData) throws IOException{
		String savedName = "";
		
		// 32개의 십육진수  '-' 4개  총 36개의 문자열 자동으로 랜덤하게 생성 
		UUID uid = UUID.randomUUID();

		savedName = uid.toString().replace("-", "")+"_"+originalName;
		
		File file = new File(uploadPath,savedName);
		
		FileCopyUtils.copy(fileData, file);
		
		return savedName;
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public boolean idCheck(String gambler_id) throws Exception {
		boolean isChecked = false;
		int registeredId = us.userIdCheck(gambler_id);
		if(gambler_id != null && registeredId < 1) {
			isChecked = true;
		}
		return isChecked;
	}
	
	@RequestMapping("/gamblerInfo")
	public String gamblerInfo() throws Exception {
		return "/user/gamblerInfo";
	}
	
	@RequestMapping("/gamblerInfoModify")
	public String userInfoModify() {
		uploadPath = context.getRealPath(File.separator+uploadFolder);
		System.out.println("uploadPath : " + uploadPath);
		File file = new File(uploadPath);
		if(!file.exists()) {
			file.mkdirs();	// 경로 생성
		}
		return "/user/gamblerInfoModify";
	}
	
	@RequestMapping("/gamblerInfoModifyComplete")
	public String gamblerInfoModifyComplete(
			@RequestParam("file") MultipartFile file,
			UserVO vo,
			HttpServletRequest request,
			HttpSession session) throws Exception {
		
		String gambler_image = uploadFile(file.getOriginalFilename(),file.getBytes());
		vo.setGambler_image(gambler_image);
		
		us.userModify(vo);
		
		System.out.println("image : " + vo.getGambler_image());
		
		UserVO userInfo = selectUser(vo.getGambler_id());
		session = request.getSession();
		session.setAttribute("userInfo", userInfo);
		System.out.println("pw : " + userInfo.getGambler_pw());
		
		return "/user/gamblerInfo";
	}
	
	public UserVO selectUser(String s) throws Exception {
		return us.selectUser(s);
	}
	
	@RequestMapping("/withdraw")
	public String withdraw() {
		return "/user/withdraw";
	}
	
	@RequestMapping("/withdrawOk")
	public ModelAndView withdrawOk(
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response,
			@CookieValue(name="loginCookie", required = false) Cookie loginCookie,
			UserVO vo) throws Exception {
			String message = "";
			ModelAndView mav = new ModelAndView();
			
			String inputPw = vo.getGambler_pw();
			vo = (UserVO)session.getAttribute("userInfo");
			
			String sessionPw = vo.getGambler_pw();
			
			if(inputPw.equals(sessionPw)) {
				us.withdraw(vo);
				if(session.getAttribute("userInfo") != null) {
					session.removeAttribute("userInfo");
					session.invalidate();
					
					if(loginCookie != null) {
						loginCookie.setPath("/");
						loginCookie.setMaxAge(0);
						response.addCookie(loginCookie);
					}
				}
				message = "KoreateVegas를 이용해 주셔서 감사합니다.";
				mav.addObject("message",message);
				mav.setViewName("redirect:/");
				return mav;
			}else {
				message = "비밀번호가 일치하지 않습니다.";
				mav.addObject("message",message);
				mav.setViewName("/user/withdraw");
				return mav;
			}
	}

}
