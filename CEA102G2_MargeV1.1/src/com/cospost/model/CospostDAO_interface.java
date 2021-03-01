package com.cospost.model;

import java.util.*;

public interface CospostDAO_interface {
		public void insert(CospostVO cospostVO);
		public void update(CospostVO cospostVO);
		public void delete(Integer cosPubNo);
		public CospostVO findByPrimaryKey(Integer cosPubNo);
		public List<CospostVO> getAll();
}
