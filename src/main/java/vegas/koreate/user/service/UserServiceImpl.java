package vegas.koreate.user.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vegas.koreate.user.dao.UserDAO;
import vegas.koreate.user.vo.LoginDTO;
import vegas.koreate.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	UserDAO	 dao;

	@Transactional
	@Override
	public void join(UserVO vo) throws Exception {
		dao.join(vo);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}

	@Override
	public int userIdCheck(String gambler_id) throws Exception{
		return dao.userIdCheck(gambler_id);
	}

	@Override
	public void userModify(UserVO vo) throws Exception {
		dao.userModify(vo);
	}

	@Override
	public UserVO selectUser(String gambler_id) throws Exception{
		return dao.selectUser(gambler_id);
	}

	@Override
	public void withdraw(UserVO vo) {
		dao.withdraw(vo);
	}
	
	@Override
	public UserVO getUserById(String cookieId) throws Exception{
		return dao.getUserByid(cookieId);
	}
	
	
}