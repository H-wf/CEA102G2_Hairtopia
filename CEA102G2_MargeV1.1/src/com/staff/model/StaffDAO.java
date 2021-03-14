package com.staff.model;


import java.util.List;



import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;




import jpa.util.JPAUtil;

public class StaffDAO implements StaffDAO_interface {


	private static final String GET_ALL_STMT = " FROM StaffVO order by staNo";


	@Override
	public void insert(StaffVO staVO) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction(); // 以下兩行不建議使用，會造成多方員工跳十號（因為是同一條連線）
		try {
			tx.begin(); // 以下兩行不建議使用，會造成多方員工跳十號（因為是同一條連線）

			em.persist(staVO); // 新增
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}



	@Override
	public void update(StaffVO staVO) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.merge(staVO);  //修改
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}

	public void delete(Integer staNo) {
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			StaffVO staVO = em.find(StaffVO.class, staNo);
		    em.remove(staVO);
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
	}

	@Override
	public StaffVO findByPrimaryKey(Integer staNo) {
		StaffVO staffVO = null;
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			staffVO = em.find(StaffVO.class, staNo);  //查詢
			tx.commit();
			em.close();
		} catch (Exception ex) {
			tx.rollback();
			throw ex;
		}
		return staffVO;
	}



public List<StaffVO> getAll() {
		
		List<StaffVO> list = null;
		EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Query query = em.createQuery(GET_ALL_STMT, StaffVO.class);
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
		StaffDAO dao = new StaffDAO();
		
		List<StaffVO> list2 = dao.getAll();
		for (StaffVO aDept : list2) {
			System.out.print(aDept.getStaNo() + ",");
			System.out.print(aDept.getStaName() + ",");
			System.out.print(aDept.getStaAcct());
			System.out.print(aDept.getStaPswd());
			System.out.println("\n-----------------");
			
			
			}
			System.out.println();
		}
		
	



//	@Override
//	public Set<AuthorityVO> getAuthorByStaNo(Integer staNo) {
//		// TODO Auto-generated method stub
//		return null;
//	}

}
