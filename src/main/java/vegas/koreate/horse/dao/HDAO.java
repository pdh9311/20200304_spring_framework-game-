package vegas.koreate.horse.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import vegas.koreate.horse.vo.HVO;
import vegas.koreate.horse.vo.WHVO;

public interface HDAO {
	// 게임 시작 준비
	@Update("UPDATE h_total SET hnum=#{hnum},hnum_total=0,bettime=now() where hnum=#{hnum}")
	void start(int hnum) throws Exception;

	// 배팅
	@Insert("INSERT INTO h_bet(hnum,hbet,gambler_num) VALUES(#{hnum},#{hbet},#{gambler_num}) ")
	void bet(HVO hvo) throws Exception;

	// 배팅 정보 확인
	@Select("SELECT hbet,gambler_num from h_bet where hnum=#{hnum} and gambler_num=#{gambler_num}")
	HVO check_cash_bet(HVO hvo) throws Exception;

	// 배팅한 만큼 차감
	@Update("UPDATE gambler_member SET gambler_cash=gambler_cash-#{hbet} where gambler_num = #{gambler_num}")
	void cash_bet(HVO hvo);

	// 배팅 정보 확인
	@Select("SELECT count(*) from h_bet where hnum=#{hnum} and gambler_num=#{gambler_num}")
	int checkebet(HVO hvo) throws Exception;

	// 첫배팅시 insert 추가 배팅시 update
	@Update("UPDATE h_bet SET hbet = hbet + #{hbet} where hnum = #{hnum} AND gambler_num = #{gambler_num}")
	void modibet(HVO hvo);

	// 말별 총배팀 금액
	@Update("UPDATE h_total SET hnum_total = hnum_total+ #{hbet} where hnum=#{hnum} ")
	int hnum_total(HVO hvo) throws Exception;
	////////////////////////////////////

	// 취소 영역
	/////////////////////////////// 취소
	@Delete("DELETE From h_bet WHERE hnum= #{hnum} AND gambler_num = #{gambler_num} ")
	void cancel(HVO hvo);

	@Select("SELECT  hnum,hbet From h_bet WHERE  hnum =#{hnum} AND gambler_num = #{gambler_num} ")
	HVO bet_cancel(HVO hvo);
 

	@Delete("DELETE From h_bet")
	void reset();

	
	@Select("SELECT  hbet,gambler_num From h_bet WHERE  hnum =#{hnum} AND gambler_num = #{gambler_num} ")
	HVO cancel_much(HVO hvo);// x번째말 배팅금액

	@Update("UPDATE gambler_member SET gambler_cash=gambler_cash+#{hbet} where gambler_num = #{gambler_num}")
	void cancel_back(HVO hvo);

	@Update("UPDATE h_total SET hnum_total = hnum_total-#{hbet} where  hnum = #{hnum}")
	void canceltotal(HVO hvo);

	// 모든 말의 배팅 금액
	@Select("SELECT sum(hbet) from h_bet")
	Integer totalbet() throws Exception;

	// 승리한 사람 찾기
	@Select("SELECT count(hbet) from h_bet where hnum= #{winner} AND gambler_num = #{gambler_num}")
	int victory_moneycheck(WHVO whvo) throws Exception;

	// 승리한 사람 금액찾기
	@Select("SELECT hbet from h_bet where hnum= #{winner} AND gambler_num = #{gambler_num}")
	int victory_check(WHVO whvo) throws Exception;

	// 승리마 총 배팅금액
	@Select("SELECT hnum_total from h_total where hnum = #{winner}")
	int victory_horse_bet(WHVO whvo);

	// 승리시 상금 받고 승수+
	@Update("UPDATE gambler_member SET gambler_cash = gambler_cash + #{price} , gambler_win=gambler_win+1 WHERE gambler_num=#{gambler_num} ")
	int Win_price(WHVO whvo) throws Exception;

	// 패배시 패수 +
	@Update("UPDATE gambler_member SET gambler_lose=gambler_lose+1 WHERE gambler_num=#{gambler_num} ")
	void lose(WHVO whvo) throws Exception;

	/*
	 * //승리한 사람수 찾기
	 * 
	 * @Select("SELECT count(gambler_num) from h_bet where hnum= #{winner}") int
	 * vitory_num(int winner) throws Exception;
	 * 
	 * // 승리한 사람의 배팅금 찾기
	 * 
	 * @Select("SELECT hbet from h_bet where hnum= #{winner} AND gambler_num = #{gambler_num}"
	 * ) int victory_man_bet(int gambler_num);
	 */

}
