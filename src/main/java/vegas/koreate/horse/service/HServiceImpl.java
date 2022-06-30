package vegas.koreate.horse.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vegas.koreate.horse.dao.HDAO;
import vegas.koreate.horse.vo.HVO;
import vegas.koreate.horse.vo.WHVO;
@Service
public class HServiceImpl  implements HService{

	


	@Inject
	HDAO hdao;
	WHVO whvo;
 	
	// 배팅 준비설정
	@Override
	public void betready(int hnum) throws Exception{
hdao.start(hnum);
	}

@Override
public void reset() throws Exception{
hdao.reset();
	
	}
	// 배팅여부
	@Override
	public int checkebet(HVO hvo) throws Exception {
		return hdao.checkebet(hvo);
	}
    //배팅하기
	@Override
	public void bet(HVO hvo) throws Exception {
		hdao.bet(hvo);
		
	}
	//배팅 차감금액 확인
	@Override
	public HVO check_cash_bet(HVO hvo) throws Exception {
	
		return hdao.check_cash_bet(hvo);
		
	}
	//배팅후 차감 
	@Override
	public void cash_bet(HVO hvo) throws Exception {
		hdao.cash_bet(hvo);
	}
	//배팅 수정 
	@Override
	public void modbet(HVO hvo) throws Exception {
		hdao.modibet(hvo);
	}
	// 각 말별 총 배팅금액
		@Override
		public int hnum_total(HVO hvo)throws Exception {
			return hdao.hnum_total(hvo);
		}

	@Override
	public void cancel(HVO hvo) throws Exception {
	     hdao.cancel(hvo);
	}
	
	@Override
	public HVO bet_cancel(HVO hvo) throws Exception {
		return hdao.bet_cancel(hvo);
	}
	
	
	@Override
	public HVO cancel_much(HVO hvo) throws Exception {
		return hdao.cancel_much(hvo);
	}//  
	
	@Override
	public void cancel_back(HVO hvo) throws Exception {
		hdao.cancel_back(hvo);
	}
	
	
	@Override
	public void canceltotal(HVO hvo) throws Exception {
	     hdao.canceltotal(hvo);
	}
	
	

//  승리한 말에게  배팅 여부
	@Override
	public int victory_moneycheck(WHVO whvo)throws Exception {
		return hdao.victory_moneycheck(whvo);
		
	}
	// 승리한 말에게 배팅한 금액
		@Override
		public Integer victory_check(WHVO whvo)throws Exception {
			return hdao.victory_check(whvo);
			
		}


//총 배팅금액
	@Override
	public int total() throws Exception {
		return hdao.totalbet();
	}
	
	@Override
	public int victory_horse_bet(WHVO whvo) throws Exception {
		return hdao.victory_horse_bet(whvo);
	}
	

	@Override
	public void Win_price(WHVO whvo) throws Exception {
		hdao.Win_price(whvo);
		
	}
	@Override
	public void lose(WHVO whvo) throws Exception {
	hdao.lose(whvo);
	
	}






}
/*
 * @Override public int vitory_num(int winner) throws Exception { // TODO
 * Auto-generated method stub return 0; }
 * 
 * @Override public int victory_man_bet(int gambler_num) throws Exception { //
 * TODO Auto-generated method stub return 0; }
 */
