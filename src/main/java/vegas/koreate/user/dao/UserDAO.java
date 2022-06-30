package vegas.koreate.user.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import vegas.koreate.user.vo.LoginDTO;
import vegas.koreate.user.vo.UserVO;

public interface UserDAO {

	// 회원가입
	@Insert("INSERT INTO gambler_member(gambler_id,gambler_pw,gambler_name,gambler_birth,gambler_gender,gambler_phone,"
			+ "gambler_addr_post,gambler_addr,gambler_addr_detail,gambler_infoOk,gambler_image) "
			+ " VALUES(#{gambler_id},#{gambler_pw},#{gambler_name},"
			+ "CONCAT(substring(#{gambler_birth},1,4),'-',substring(#{gambler_birth},5,2),'-',substring(#{gambler_birth},7,2)),"
			+ "#{gambler_gender},#{gambler_phone},#{gambler_addr_post},#{gambler_addr},#{gambler_addr_detail},#{gambler_infoOk},#{gambler_image})")
	void join(UserVO vo) throws Exception;
	
	// 로그인
	@Select ("SELECT * FROM gambler_member WHERE gambler_id = #{gambler_id} AND gambler_pw = #{gambler_pw}")
	UserVO login(LoginDTO dto) throws Exception;

	// 회원가입시 아이디 중복확인
	@Select("SELECT count(*) FROM gambler_member WHERE gambler_id = #{gambler_id}")
	int userIdCheck(String gambler_id) throws Exception;

	// 회원정보 수정
	@Update("UPDATE gambler_member"
			+ " SET gambler_pw = #{gambler_pw} ,"
			+ " gambler_phone = #{gambler_phone} ,"
			+ " gambler_addr_post = #{gambler_addr_post} ,"
			+ " gambler_addr=#{gambler_addr} ,"
			+ " gambler_addr_detail = #{gambler_addr_detail} ,"
			+ " gambler_image = #{gambler_image} "
			+ " WHERE gambler_id = #{gambler_id}")
	void userModify(UserVO vo) throws Exception;
	
	// 회원정보 찾기
	@Select("SELECT * FROM gambler_member WHERE gambler_id = #{gambler_id}")
	UserVO selectUser(String gambler_id) throws Exception;
	
	//회원탈퇴
	@Update("DELETE FROM gambler_member WHERE gambler_id = #{gambler_id}")
	void withdraw(UserVO vo);

	// 브라우저의 LoginCookie값과 같은 아이디를 가진 회원의 정보 가져오기
	@Select("SELECT * FROM gambler_member WHERE gambler_id = #{cookieId}")
	UserVO getUserByid(String cookieId) throws Exception;
}
