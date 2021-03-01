package com.transactionRecord.model;

import java.util.List;

public interface TransRecDAO_interface {
	public void insert(TransRecVO transRecVO);

	public void update(TransRecVO transRecVO);

	public void delete(Integer traNo);

	public TransRecVO findByPrimaryKey(Integer traNo);

	public List<TransRecVO> getAll();
}
