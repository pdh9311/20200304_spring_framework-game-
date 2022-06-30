package vegas.koreate.board.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private int origin;
	private int depth;
	private int seq;
	private Date updatedate;
	private int gambler_num;
	
	List<String> files;
}
