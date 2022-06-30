package vegas.koreate.mvc.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import vegas.koreate.user.service.UserService;
import vegas.koreate.user.vo.UserVO;

public class CheckCookieInterceptor extends HandlerInterceptorAdapter{

	@Inject
	UserService us;
	
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)	throws Exception {
		
		System.out.println("CheckCooki 시작");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") != null) {
			System.out.println("사용자 정보 이미 존재");
			return true;
		}
		
		Cookie cookie = WebUtils.getCookie(request, "loginCookie");
		if(cookie != null) {
			UserVO userInfo = us.getUserById(cookie.getValue());
			System.out.println("쿠키값  : " + cookie.getValue());
			System.out.println("cookir user : " + userInfo);
			if(userInfo != null) {
				session.setAttribute("userInfo", userInfo);
			}
		}
		
		System.out.println("CheckCooki 종료");
		return true;
	}
	
	

}
