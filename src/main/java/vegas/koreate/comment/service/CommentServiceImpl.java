package vegas.koreate.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import vegas.koreate.comment.dao.CommentDAO;
import vegas.koreate.comment.vo.CommentVO;
import vegas.koreate.util.Criteria;
import vegas.koreate.util.PageMaker;

@Service
public class CommentServiceImpl implements CommentService{
	
	@Inject
	CommentDAO dao;

	@Override
	public void addComment(CommentVO vo) throws Exception {
		dao.addComment(vo);
	}

	@Override
	public Map<String, Object> listPage(int bno, int page) throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(page);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.totalCount(bno));
		
		List<CommentVO> list = dao.listPage(bno, cri);
		
		Map<String , Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pageMaker",pageMaker);
		return map;
	}

	@Override
	public void modifyComment(CommentVO vo) throws Exception {
		dao.modifyComment(vo);
	}

	@Override
	public void removeComment(int cno) throws Exception {
		dao.removeComment(cno);
	}
	
	
	
	
	
	

}
