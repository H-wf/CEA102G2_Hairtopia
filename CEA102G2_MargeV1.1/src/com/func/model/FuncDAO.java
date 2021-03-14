package com.func.model;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.sql.DataSource;

import com.staff.model.StaffDAO;
import com.staff.model.StaffVO;

import jpa.util.JPAUtil;

public class FuncDAO implements FuncDAO_interface{
	

	//fjdsfjdsoijfdsoifjdsoijf
	
	private static final String GET_ALL_STMT = "FROM FuncVO order by funcNo";


	
	@Override
	public void insert(FuncVO funcVO) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction(); // 以下兩行不建議使用，會造成多方員工跳十號（因為是同一條連線）
		try {
			tx.begin(); // 以下兩行不建議使用，會造成多方員工跳十號（因為是同一條連線）

			em.persist(funcVO); // 新增
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}



	@Override
	public void update(FuncVO funcVO) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.merge(funcVO);  //修改
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}

	public void delete(Integer funcNo) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			FuncVO funcVO = em.find(FuncVO.class, funcNo);
		    em.remove(funcVO);
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}

	@Override
	public FuncVO findByPrimaryKey(Integer funcNo) {
		FuncVO funcVO = null;
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			funcVO = em.find(FuncVO.class, funcNo);  //查詢
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
		return funcVO;
	}



public List<FuncVO> getAll() {
		
		List<FuncVO> list = null;
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Query query = em.createQuery(GET_ALL_STMT, FuncVO.class);
			list = query.getResultList();  //查詢
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
		return list;
	}


	
	
	public static void main(String[] args) {
		FuncDAO dao = new FuncDAO();
		
		List<FuncVO> list2 = dao.getAll();
		for (FuncVO aDept : list2) {
			System.out.print(aDept.getFuncNo() + ",");
			System.out.print(aDept.getFuncName() + ",");
			System.out.println("\n-----------------");
			
			
			}
			System.out.println();
		}




		
}
