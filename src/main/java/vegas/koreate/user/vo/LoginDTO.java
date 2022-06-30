package vegas.koreate.user.vo;

import lombok.Data;

@Data
public class LoginDTO {

	private String gambler_id;
	private String gambler_pw;
	private boolean gambler_cookie;
	
}
