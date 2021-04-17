package com.news.model;

import org.hibernate.*;
import org.hibernate.query.Query; //Hibernate 5.2 �}�l ���N�� org.hibernate.Query ����

import com.member.model.MemVO;

import hibernate.util.HibernateUtil;
import java.util.*;


public class NewsHibernateDAO implements NewsDAO_interface{

	private static final String GET_ALL_STMT = "FROM NewsVO order by newsNo";
	
	@Override
	public void insert(NewsVO newsVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(newsVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void update(NewsVO newsVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(newsVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public void delete(Integer newsNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			NewsVO newsVO = (NewsVO) session.get(NewsVO.class, newsNo);
			session.delete(newsVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public NewsVO findByPrimaryKey(Integer newsNo) {
		NewsVO newsVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			newsVO = (NewsVO) session.get(NewsVO.class, newsNo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return newsVO;
	}

	@Override
	public List<NewsVO> getAll() {
		List<NewsVO> list = new ArrayList<NewsVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<NewsVO> query = session.createQuery(GET_ALL_STMT, NewsVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

}
