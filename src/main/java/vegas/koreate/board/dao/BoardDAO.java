package vegas.koreate.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import vegas.koreate.board.provider.Providerlist;
import vegas.koreate.board.vo.BoardVO;
import vegas.koreate.util.SearchCriteria;

public interface BoardDAO {

	//게시물 목록
	@SelectProvider(type=Providerlist.class, method="listSQL")
	List<BoardVO> boardList(SearchCriteria cri) throws Exception;
	
	//게시물 개수
	@SelectProvider(type=Providerlist.class, method="countSQL")
	int countList(SearchCriteria cri) throws Exception;
	
	//게시물 쓰기
	@Insert("insert into total_board (title, content, writer, gambler_num, origin) values (#{title},#{content},#{writer},#{gambler_num}, (select max(a.bno) from total_board as a)+1 )")
	void regist(BoardVO board)throws Exception;
	
	//게시물 읽기
	@Select("SELECT * FROM total_board where bno=#{bno}")
	BoardVO read(int bno)throws Exception;
	
	//게시물 수정
	@Update("UPDATE total_board SET "
			+ "title = #{title},"
			+ "content = #{content},"
			+ "writer = #{writer}, "
			+ " updatedate = now() "
			+ "WHERE bno = #{bno}")
	void modify(BoardVO board)throws Exception;
	
	// 답글들의 정렬값 수정
	@Update("UPDATE total_board SET seq = seq + 1 "
			+ " WHERE origin = #{origin} AND seq > #{seq}")
	void updateReply(BoardVO vo) throws Exception;

	// 답변글 등록
	@Insert("INSERT INTO total_board(title,content,writer,origin,depth,seq,gambler_num) "
			+ "VALUES(#{title},#{content},#{writer},#{origin},#{depth},#{seq},#{gambler_num})")
	void replyRegister(BoardVO vo) throws Exception;
	
	//게시뭏 삭제
	@Delete("DELETE FROM total_board where bno=#{bno}")
	void remove(int bno)throws Exception;
}
