package vegas.koreate.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	
	private int gambler_num;
	private String gambler_id ;
	private String gambler_pw ;
	private String gambler_name ;
	private String gambler_birth ;
	
	private String gambler_gender ;
	private String gambler_phone ;
	private String gambler_addr_post;
	private String gambler_addr ;
	private String gambler_addr_detail;
	
	private String gambler_infoOk;
	private Date gambler_date;
	private String gambler_withdraw;
	private int gambler_cash;
	private int gambler_win;
	private int gambler_lose;
	private String gambler_image;
	
	public UserVO(String gambler_id, String gambler_pw, String gambler_name, String gambler_birth,
			String gambler_gender, String gambler_phone, String gambler_addr_post, String gambler_addr,
			String gambler_addr_detail, String gambler_infoOk, String gambler_image) {
		this.gambler_id = gambler_id;
		this.gambler_pw = gambler_pw;
		this.gambler_name = gambler_name;
		this.gambler_birth = gambler_birth;
		this.gambler_gender = gambler_gender;
		this.gambler_phone = gambler_phone;
		this.gambler_addr_post = gambler_addr_post;
		this.gambler_addr = gambler_addr;
		this.gambler_addr_detail = gambler_addr_detail;
		this.gambler_infoOk = gambler_infoOk;
		this.gambler_image = gambler_image;
	}
	
	
}
