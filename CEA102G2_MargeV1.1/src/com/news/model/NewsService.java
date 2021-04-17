package com.news.model;

import java.sql.Timestamp;
import java.util.*;

public class NewsService {
	private NewsDAO_interface dao;
	
	public NewsService() {
		dao = new NewsHibernateDAO();
	}
	
	public NewsVO addNews(String newsTitle, String newsCon) {
		NewsVO newsVO = new NewsVO();
		
		newsVO.setNewsTitle(newsTitle);
		newsVO.setNewsCon(newsCon);
		newsVO.setNewsTime(new Timestamp(new Date().getTime()));
		
		dao.insert(newsVO);
		
		return newsVO;
	}
	
	public NewsVO updateNews(Integer newsNo, String newsTitle, String newsCon) {
		
		NewsVO newsVO = dao.findByPrimaryKey(newsNo);
		newsVO.setNewsNo(newsNo);
		newsVO.setNewsTitle(newsTitle);
		newsVO.setNewsCon(newsCon);
		
		dao.update(newsVO);
		
		return newsVO;
	}
	
	public void deleteNews(Integer newsNo) {
		dao.delete(newsNo);
	}
	
	public NewsVO getOneNews(Integer newsNo) {
		return dao.findByPrimaryKey(newsNo);
	}
	
	public List<NewsVO> getAll() {
		return dao.getAll();
	}
	
	
}
