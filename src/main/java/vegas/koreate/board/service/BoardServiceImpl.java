package vegas.koreate.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import vegas.koreate.board.dao.BoardDAO;
import vegas.koreate.board.vo.BoardVO;
import vegas.koreate.util.PageMaker;
import vegas.koreate.util.SearchCriteria;
@Service
public class BoardServiceImpl implements BoardService{

	@Inject
	BoardDAO dao;
	
	@Override
	public List<BoardVO> getList(SearchCriteria cri) throws Exception {
		System.out.println("getlist");
		
		List<BoardVO> list = dao.boardList(cri);
		return list;
	}


	@Override
	public void write(BoardVO board) throws Exception {
		dao.regist(board);
	}
	@Override
	public void replywrite(BoardVO board) throws Exception {
		System.out.println("replyRegister : " + board);
		dao.updateReply(board);
		
		board.setDepth(board.getDepth()+1); 
		board.setSeq(board.getSeq()+1);
		
		System.out.println("등록된 게시물 정보 : " + board);
		
		dao.replyRegister(board);
	}
	
	//depth , seq 등록된 테이블 생성
	@Override
	public BoardVO read(int bno) throws Exception {
		
		return dao.read(bno);
	}

	@Override
	public void delete(int bno) throws Exception {
		dao.remove(bno);
		
	}

	@Override
	public void update(BoardVO board) throws Exception {
		dao.modify(board);
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		System.out.println("ser_getPMAKER");
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.countList(cri));
		System.out.println(pageMaker);
		return pageMaker;
	}
}
