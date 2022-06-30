package vegas.koreate.horse.controller;


import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import vegas.koreate.horse.service.HService;
import vegas.koreate.horse.vo.HVO;
import vegas.koreate.horse.vo.WHVO;

@Controller
@RequestMapping("/game")
public class HController {

	@Inject
	HService hsv;

	@GetMapping("/horse")
	public String gameList() throws Exception {
		return "game/horse";
	}

	/*
	 * @GetMapping("/betready") public void betready(int hnum) throws Exception {
	 * hsv.betready(hnum); }
	 */

	@PostMapping("/bet")
	public ResponseEntity<String> gamebet(@RequestBody HVO hvo) throws Exception {
		ResponseEntity<String> entity = null;
		System.out.println("cont_bet");
		try {
			if (hsv.checkebet(hvo) == 0) {
				hsv.bet(hvo);
				hsv.cash_bet(hsv.check_cash_bet(hvo));
				System.out.println("insert");
			} else if (hsv.checkebet(hvo) == 1) {
				hsv.modbet(hvo);

				System.out.println("update");
			}
			System.out.println("total");
			hsv.hnum_total(hvo);

			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}// bet 같은 말에 배팅시 입력한 값으로 변경

	@PostMapping("/cancel")
	public ResponseEntity<String> cancelbet(@RequestBody HVO hvo) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			System.out.println("cont_cancel");
			System.out.println("total -cancel");
			hsv.cancel_back(hsv.cancel_much(hvo));
			System.out.println("배팅금액 돌려주고");
			hsv.canceltotal(hsv.bet_cancel(hvo));
			System.out.println("취소한 금액만큼 말의 총합 배팅금에서 빼주고");
			hsv.cancel(hvo);System.out.println("자신의 배팅 흔적 삭제");
			
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@GetMapping("/result")
	@ResponseBody
	public ResponseEntity<String> result(
			WHVO whvo) throws Exception{
		ResponseEntity<String> entity = null;
			try {
				
				int check = hsv.victory_moneycheck(whvo);
				// 회원번호 + 승리마 >>배팅금액
				if(check >0) {
					
				Integer bet = hsv.victory_check(whvo);
				int h_total = hsv.victory_horse_bet(whvo);
				int total = hsv.total();
				double perc = (total*0.8)/h_total;
				System.out.println("perc :"+ perc);
			int price = (int) (bet*perc);
				whvo.setPrice(price);
				System.out.println("price :"+ price);
				hsv.Win_price(whvo);//정산
				// 새로운 배팅 판 생성 
				for(int i = 1; i<9; i++) {
					hsv.betready(i);
				}
				hsv.reset();
				
		System.out.println("ekda");
				}else 
				{System.out.println("lose");
				hsv.lose(whvo);
				for(int i = 1; i<9; i++) {
					hsv.betready(i);
				}
				hsv.reset();
				}
				
				entity = new ResponseEntity<String>(HttpStatus.OK);
			}
			catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
			return entity;
		}
	
	// 정산
	/*
	 * @GetMapping("/result")
	 * 
	 * @ResponseBody public ResponseEntity<Map<String,Object>> result( WHVO whvo)
	 * throws Exception{ ResponseEntity<Map<String,Object>> entity = null; try {
	 * 
	 * int bet = hsv.victory_check(whvo);
	 * 
	 * 
	 * whvo.setWinner(winner); List<WHVO> list = hsv.vitory_man(winner);
	 * System.out.println(list); whvo.setVitory_num(hsv.vitory_num(winner));
	 * whvo.setVictory_horse_bet(winner); whvo.setTotalbet(hsv.total());
	 * 
	 * 
	 * model.addAttribute("winner", winner); model.addAttribute("vitory_man",
	 * hsv.vitory_man(winner)); model.addAttribute("vitory_num",
	 * hsv.vitory_num(winner)); model.addAttribute("totalbet", hsv.total());
	 * 
	 * 
	 * 
	 * Map<String,Object> map = new HashMap<>(); map.put("whvo", whvo); entity = new
	 * ResponseEntity<Map<String,Object>>(map,HttpStatus.OK); } catch (Exception e)
	 * { e.printStackTrace(); entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	 * } return entity; }
	 */

}// 컨트
