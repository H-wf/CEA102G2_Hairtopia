package com.coudet.model;

import java.util.*;

public interface CosdetDAO_interface {
		public void insert(CosdetVO cosdetVO);
		public void update(CosdetVO cosdetVO);
		public void delete(Integer cosNo);
		public CosdetVO findByPrimaryKey(Integer cosNo);
		public List<CosdetVO> getAll();
}
