package com.notification.model;

import org.hibernate.*;
import org.hibernate.query.Query; //Hibernate 5.2 �}�l ���N�� org.hibernate.Query ����

import com.member.model.MemVO;

import hibernate.util.HibernateUtil;
import java.util.*;


public class NotiHibernateDAO implements NotiDAO_interface{

	private static final String GET_ALL_STMT = "FROM NotiVO order by notiNo";
	
	@Override
	public void insert(NotiVO notiVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(notiVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void update(NotiVO notiVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(notiVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public void delete(Integer notiNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			NotiVO notiVO = (NotiVO) session.get(NotiVO.class, notiNo);
			session.delete(notiVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public NotiVO findByPrimaryKey(Integer notiNo) {
		NotiVO notiVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			notiVO = (NotiVO) session.get(NotiVO.class, notiNo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return notiVO;
	}

	@Override
	public List<NotiVO> getAll() {
		List<NotiVO> list = new ArrayList<NotiVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<NotiVO> query = session.createQuery(GET_ALL_STMT, NotiVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

}
