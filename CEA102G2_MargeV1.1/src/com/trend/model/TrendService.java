package com.trend.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.post.model.PostVO;



public class TrendService {
	private TrendDAO_interface dao;

	public TrendService() {
		dao = new TrendDAO();
	}
	
	public TrendVO addTrend(String treTitle, String treCon,Timestamp treTime) {
		TrendVO treVO = new TrendVO();
		treVO.setTreTitle(treTitle);
		treVO.setTreCon(treCon);
		treVO.setTreTime(treTime);

		dao.insert(treVO);

		return treVO;

	}
	
	public TrendVO updateTrend(Integer treNo, String treTitle, String treCon,Timestamp treTime) {
		TrendVO treVO = new TrendVO();

		treVO.setTreNo(treNo);
		treVO.setTreTitle(treTitle);
		treVO.setTreCon(treCon);
		treVO.setTreTime(treTime);

		dao.update(treVO);

		return treVO;
	}
	
	public void deleteTrend(Integer treNo) {
		dao.delete(treNo);
	}

	public TrendVO getOneTrend(Integer treNo) {
		return dao.findByPrimaryKey(treNo);
	}

	public List<TrendVO> getAll() {

		return dao.getAll();
	}
	public Set<TrendVO> pickup5Trend() {
		List<TrendVO> allTrend = dao.getAll();
		Set<TrendVO> reTrend = new HashSet<TrendVO>();
		Set<Integer> index = new HashSet<Integer>();
		
		while(index.size()<5){
			int x = (int) (Math.random()*allTrend.size())+1;
			index.add(x);
		}
		while(reTrend.size()<5) {
			for(Integer y:index) {
				reTrend.add(allTrend.get(y));
			}
		}
		return reTrend;
	}

}
