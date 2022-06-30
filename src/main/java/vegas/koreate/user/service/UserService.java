package vegas.koreate.user.service;

import vegas.koreate.user.vo.LoginDTO;
import vegas.koreate.user.vo.UserVO;

public interface UserService {
	
	// 회원가입
	void join(UserVO vo) throws Exception;
	
	// 로그인
	UserVO login(LoginDTO dto) throws Exception;

	// 회원가입시 아이디 중복확인
	int userIdCheck(String gambler_id) throws Exception;

	// 회원정보 수정
	void userModify(UserVO vo) throws Exception;

	// 회원 객체 찾기
	UserVO selectUser(String gambler_id) throws Exception;

	// 회원탈퇴
	void withdraw(UserVO vo);

	// 브라우저의 LoginCookie값과 같은 아이디를 가진 회원의 정보 가져오기
	UserVO getUserById(String cookieId) throws Exception;
}
