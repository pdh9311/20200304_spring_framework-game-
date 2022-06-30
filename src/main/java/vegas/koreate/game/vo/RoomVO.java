package vegas.koreate.game.vo;

import lombok.Data;

@Data
public class RoomVO {

	private int room_num;
	private String room_title;
	private int room_numberOfPeople;
	private String room_password;
	private boolean playStatus;
	private String game_name;
	
}
