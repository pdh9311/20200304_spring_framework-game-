package vegas.koreate.game.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GameVO {

	private int game_num ;
	private String game_title;
	private String game_writer;
	private String game_content;
	private Date game_regdate;
	private String game_thumbnail;
}
