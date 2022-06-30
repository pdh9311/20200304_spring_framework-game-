package vegas.koreate.horse.service;


import vegas.koreate.horse.vo.HVO;
import vegas.koreate.horse.vo.WHVO;

public interface HService {

	void bet(HVO hvo) throws Exception;

	int checkebet(HVO hvo)throws Exception;

	void cancel(HVO hvo) throws Exception;

	int hnum_total(HVO hvo) throws Exception;

	HVO bet_cancel(HVO hvo) throws Exception;

	void modbet(HVO hvo) throws Exception;

	void canceltotal(HVO hvo) throws Exception;

	int total() throws Exception;

	int victory_horse_bet(WHVO whvo) throws Exception;

	Integer victory_check(WHVO whvo) throws Exception;


	void lose(WHVO whvo) throws Exception;

	void cancel_back(HVO hvo) throws Exception;

	HVO cancel_much(HVO hvo) throws Exception;

	void cash_bet(HVO hvo) throws Exception;

	HVO check_cash_bet(HVO hvo) throws Exception;

	int victory_moneycheck(WHVO whvo) throws Exception;

	void Win_price(WHVO whvo) throws Exception;

	void betready(int hnum) throws Exception;

	void reset() throws Exception;





}
