package vegas.koreate.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import vegas.koreate.comment.vo.CommentVO;
import vegas.koreate.util.Criteria;

public interface CommentDAO {

	@Insert("INSERT INTO total_board_comment(bno,commentText,commentAuth,gambler_num)"
			+ " VALUES(#{bno},#{commentText},#{commentAuth},#{gambler_num})")
	void addComment(CommentVO vo) throws Exception;
	
	@Select("SELECT count(*) FROM total_board_comment WHERE bno = #{bno}")
	int totalCount(int bno) throws Exception;
	
	@Select("SELECT * FROM total_board_comment WHERE bno = #{bno} ORDER BY cno DESC "
			+ " limit #{cri.pageStart} , #{cri.perPageNum}")
	List<CommentVO> listPage(
					@Param("bno") int bno, 
					@Param("cri")Criteria cri) throws Exception;

	@Update("UPDATE total_board_comment SET "
			+ " commentText = #{commentText}, "
			+ " updatedate = now() "
			+ " WHERE cno = #{cno}")
	void modifyComment(CommentVO vo) throws Exception;
	
	@Delete("DELETE FROM total_board_comment WHERE cno = #{cno}")
	void removeComment(int cno) throws Exception;
	
	@Delete("DELETE FROM total_board_comment WHERE bno = #{bno}")
	void deleteComment(int bno) throws Exception;
	
	
}





