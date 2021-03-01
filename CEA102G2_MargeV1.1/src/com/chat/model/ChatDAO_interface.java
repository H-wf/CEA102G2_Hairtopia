package com.chat.model;

import java.util.List;

public interface ChatDAO_interface {
	
		public void insert(ChatVO chatVO);
		public void update(ChatVO chatVO);
		public void delete(Integer chatNo);
	    public ChatVO findByPrimaryKey(Integer chatNo);
	    public List<ChatVO> getAll();
}
