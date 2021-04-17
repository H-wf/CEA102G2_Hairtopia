package com.transactionRecord.model;

import org.hibernate.*;
import org.hibernate.query.Query; //Hibernate 5.2 �}�l ���N�� org.hibernate.Query ����

import com.member.model.MemVO;

import hibernate.util.HibernateUtil;
import java.util.*;


public class TransRecHibernateDAO implements TransRecDAO_interface{

	private static final String GET_ALL_STMT = "FROM TransRecVO order by transRecNo";
	
	@Override
	public void insert(TransRecVO transRecVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(transRecVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void update(TransRecVO transRecVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(transRecVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public void delete(Integer transRecNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			TransRecVO transRecVO = (TransRecVO) session.get(TransRecVO.class, transRecNo);
			session.delete(transRecVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public TransRecVO findByPrimaryKey(Integer transRecNo) {
		TransRecVO transRecVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			transRecVO = (TransRecVO) session.get(TransRecVO.class, transRecNo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return transRecVO;
	}

	@Override
	public List<TransRecVO> getAll() {
		List<TransRecVO> list = new ArrayList<TransRecVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<TransRecVO> query = session.createQuery(GET_ALL_STMT, TransRecVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public List<TransRecVO> getMemberRecord(Integer traNo) {
		List<TransRecVO> list = new ArrayList<TransRecVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<TransRecVO> query = session.createQuery(GET_ALL_STMT, TransRecVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

}
