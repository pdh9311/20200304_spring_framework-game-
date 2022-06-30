package vegas.koreate.mvc.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import vegas.koreate.user.dao.UserDAO;
import vegas.koreate.user.service.UserService;
import vegas.koreate.user.vo.LoginDTO;
import vegas.koreate.user.vo.UserVO;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Inject
	UserService us;
	
	@Inject
	UserDAO dao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("/loginPost preHandler");
		return true;
	}

	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response,
			Object handler,	ModelAndView mav) throws Exception {
		System.out.println("/loginPost postHandler ---------");
		
		ModelMap modelObj = mav.getModelMap();
		
		LoginDTO dto = (LoginDTO) modelObj.get("loginDTO");
		
		System.out.println("dto : " + dto);
		
		UserVO userInfo = us.login(dto);
		System.out.println("userInfo : " + userInfo);
		HttpSession session = request.getSession();
		
		if(userInfo != null) {
			session.setAttribute("userInfo", userInfo);
			
			if(dto.isGambler_cookie()) {
				Cookie cookie = new Cookie("loginCookie",userInfo.getGambler_id());
				cookie.setPath("/");
				cookie.setMaxAge(60 * 60 * 24 * 15);
				response.addCookie(cookie);
			}
		} else {
			String message = "";
			
			message = "회원 정보가 없습니다.";
			
			mav.addObject("message",message);
			mav.setViewName("/user/login");
		}
		System.out.println("/loginPost postHandler ---------");
	}
	
	
}
