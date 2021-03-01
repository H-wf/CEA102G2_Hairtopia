package com.notification.model;

import java.util.List;

public interface NotiDAO_interface {
	public void insert(NotiVO notiVO);
	public void update(NotiVO notiVO);
	public void delete(Integer notiNo);
    public NotiVO findByPrimaryKey(Integer notiNo);
    public List<NotiVO> getAll();
}
