package com.staff.model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.sql.DataSource;

import com.schedule.model.ScheduleVO;

import jpa.util.JPAUtil;

public class StaffDAO implements StaffDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}


	private static final String GET_ALL_STMT = " FROM StaffVO order by staNo";
	private static final String GET_ONE_STMT = "SELECT staNo,staName,staAcct,staPswd FROM staff where staAcct=? and staPswd=?";


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



	@Override 
	public StaffVO findByAcctAndPwsd(String staAcct, String staPswd) {
		StaffVO staVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, staAcct);
			pstmt.setString(2, staPswd);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				staVO = new StaffVO();
				staVO.setStaNo(rs.getInt("staNo"));
				staVO.setStaName(rs.getString("staName"));
				staVO.setStaAcct(rs.getString("staAcct"));
				staVO.setStaPswd(rs.getString("staPswd"));
				

			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return staVO;
	}
		
	



//	@Override
//	public Set<AuthorityVO> getAuthorByStaNo(Integer staNo) {
//		// TODO Auto-generated method stub
//		return null;
//	}

}
