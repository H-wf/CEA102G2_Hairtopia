package com.news.model;

import java.util.List;

public interface NewsDAO_interface {
	public void insert(NewsVO newsVO);

	public void update(NewsVO newsVO);

	public void delete(Integer newsNo);

	public NewsVO findByPrimaryKey(Integer newsNo);

	public List<NewsVO> getAll();
}
