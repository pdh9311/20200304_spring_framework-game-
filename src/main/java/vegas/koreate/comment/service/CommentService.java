package vegas.koreate.comment.service;

import java.util.Map;

import vegas.koreate.comment.vo.CommentVO;

public interface CommentService {
	
	void addComment(CommentVO vo) throws Exception;
	
	Map<String,Object> listPage(int bno, int page) throws Exception;

	void modifyComment(CommentVO vo) throws Exception;

	void removeComment(int cno) throws Exception;

}
