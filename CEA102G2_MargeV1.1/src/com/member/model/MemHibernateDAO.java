package com.member.model;

import org.hibernate.*;
import org.hibernate.query.Query; //Hibernate 5.2 �}�l ���N�� org.hibernate.Query ����


import hibernate.util.HibernateUtil;
import java.util.*;



public class MemHibernateDAO implements MemDAO_interface{

	
	//memNo,memName,memGender,memPic,memInform,memEmail,memPswd,memPhone,memAddr,memBal,memStatus,memEndDate, memCode
//	private static final String INSERT_SIGNUP_STMT = "INSERT INTO MEMBER (memName, memEmail, memPswd) VALUES (?, ?, ?)";
//	private static final String INSERT_NO_PIC = "INSERT INTO MEMBER (memName, memGender , memInform ,memEmail, memPswd, memPhone, memAddr) VALUES (?, ?, ?, ?, ?, ?, ?)";
//	private static final String INSERT = "INSERT INTO MEMBER (memName, memGender, memInform ,memEmail, memPswd, memPhone, memAddr, memPic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "from MemVO order by memNo";
//	private static final String GET_ONE_STMT = "SELECT * FROM MEMBER WHERE memNO = ?";
//	private static final String VALIDATE_STMT = "SELECT * FROM MEMBER WHERE memEmail=? AND memPswd=?";
//	private static final String CONFIRM_EMAIL = "SELECT * FROM MEMBER WHERE memEmail=? ";
//	private static final String CONFIRM_MEMBER_NAME = "SELECT * FROM MEMBER WHERE memName=? ";
//	private static final String DELETE = "DELETE FROM MEMBER WHERE memNO = ?";
//	private static final String UPDATE_WITH_PIC = "UPDATE MEMBER set memName=?, memGender=?, memInform=?, memEmail=?, memPswd= ?, memPhone=?, memAddr=?, memPic=? WHERE memNO = ?";
//	private static final String UPDATE_PASSWORD_BY_EMAIL = "UPDATE MEMBER set memPswd= ? WHERE memEmail = ?";
//	private static final String UPDATE_STATUS_BY_EMAIL = "UPDATE MEMBER set memStatus= ? WHERE memEmail = ?";
//	private static final String UPDATE_NOPIC_STMT = "UPDATE MEMBER set memName=?, memGender=?, memInform=?, memEmail=?, memPswd= ?, memPhone=?, memAddr=? WHERE memNO = ?";
//	private static final String GET_IMG = "SELECT memPic FROM MEMBER WHERE memNO = ?";

	@Override
	public void insert(MemVO memVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(memVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}
	@Override
	public void signUp(MemVO memVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			
			session.saveOrUpdate(memVO);
			
			session.getTransaction().commit();

		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	
	@Override
	public void update(MemVO memVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(memVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public void updatePassword(String memEmail, String memPswd) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("update MemVO set memPswd=?0 where memEmail=?1");
			query.setParameter(1, memEmail);
			query.setParameter(0, memPswd);
			int updateCount = query.executeUpdate();
			System.out.println(updateCount);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}
	
	@Override
	public void updateStatus(String memEmail, Integer memStatus) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("update MemVO set memStatus=?0 where memEmail=?1");
			query.setParameter(1, memEmail);
			query.setParameter(0, memStatus);
			int updateCount = query.executeUpdate();
			System.out.println(updateCount);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		
	}
	
	@Override
	public void delete(Integer memNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			MemVO empvo = (MemVO) session.get(MemVO.class, memNo);
			session.delete(empvo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
	}

	@Override
	public MemVO findByPrimaryKey(Integer memNo) {
		MemVO memVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			memVO = (MemVO) session.get(MemVO.class, memNo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return memVO;
	}

	@Override
	public List<MemVO> getAll() {
		List<MemVO> list = new ArrayList<MemVO>();
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query<MemVO> query = session.createQuery(GET_ALL_STMT, MemVO.class);
			list = query.getResultList();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	@Override
	public MemVO validate(String memEmail, String memPswd) {
		MemVO memVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();

		try {
			session.beginTransaction();
			Query query = session.createQuery("from MemVO where memEmail=?0 and memPswd=?1");
			query.setParameter(0, memEmail);
			query.setParameter(1, memPswd);
			memVO = (MemVO)query.uniqueResult();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
			// Clean up JDBC resources
		} 
		return memVO;
	}

	@Override
	public MemVO validateEmail(String memEmail) {
		MemVO memVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from MemVO where memEmail=?0");
			query.setParameter(0, memEmail);
			memVO = (MemVO)query.uniqueResult();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return memVO;
	}
	
	@Override
	public String validateMemberName(String memName) {
		String valid = null;
		MemVO memVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from MemVO where memName=?0");
			query.setParameter(0, memName);
			memVO = (MemVO)query.uniqueResult();
			if(memVO != null) {
				valid = memVO.getMemName();
			}
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		} 
		return valid;
	}
	
	public static void main(String[] args) {
		MemHibernateDAO dao = new MemHibernateDAO();
		MemVO memVO1 = new MemVO();
//		memVO1.setMemName("King111");
//		memVO1.setMemEmail("123@123");
//		memVO1.setMemPswd("123456");
//
//		dao.insert(memVO1);
//		if(dao.validate("123@123", "12456") != null) {
//			System.out.println("true");
//		}else {
//			System.out.println("false");
//		}
//		memVO1 = dao.findByPrimaryKey(14);
//		memVO1.setMemStatus(1);
//		dao.update(memVO1);
		
//		System.out.println(dao.validateMemberName("Aragaki Yu"
//				+ ""));
		dao.updatePassword("PRESIDENT6@sss","12345666");
	}

//	public InputStream showImg(Integer memNo) {
//		InputStream memPic= null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_IMG);
//
//			pstmt.setInt(1, memNo);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				memPic = rs.getBinaryStream("memPic");
//			}
//			
//			
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return memPic;
//	}



}
