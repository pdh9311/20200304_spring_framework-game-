package vegas.koreate.board.service;

import java.util.List;

import vegas.koreate.board.vo.BoardVO;
import vegas.koreate.util.PageMaker;
import vegas.koreate.util.SearchCriteria;
public interface BoardService {

	List<BoardVO> getList(SearchCriteria cri) throws Exception;

	void write(BoardVO board) throws Exception;

	void replywrite(BoardVO vo) throws Exception;

	BoardVO read(int bno) throws Exception;

	void delete(int bno) throws Exception;

	void update(BoardVO board) throws Exception;

	PageMaker getPageMaker(SearchCriteria cri) throws Exception;


}
