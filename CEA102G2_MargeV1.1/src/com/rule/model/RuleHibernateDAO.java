package com.rule.model;

import org.hibernate.*;
import org.hibernate.query.Query; //Hibernate 5.2 �}�l ���N�� org.hibernate.Query ����

import com.member.model.MemVO;

import hibernate.util.HibernateUtil;
import java.util.*;


public class RuleHibernateDAO implements RuleDAO_interface{

	private static final String GET_ALL_STMT = "FROM RuleVO order by RuleNo";
	
	@Override
	public void insert(RuleVO RuleVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(RuleVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void update(RuleVO RuleVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(RuleVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public void delete(Integer RuleNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			RuleVO RuleVO = (RuleVO) session.get(RuleVO.class, RuleNo);
			session.delete(RuleVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public RuleVO findByPrimaryKey(Integer RuleNo) {
		RuleVO RuleVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			RuleVO = (RuleVO) session.get(RuleVO.class, RuleNo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return RuleVO;
	}

	@Override
	public List<RuleVO> getAll() {
		List<RuleVO> list = new ArrayList<RuleVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<RuleVO> query = session.createQuery(GET_ALL_STMT, RuleVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

}
