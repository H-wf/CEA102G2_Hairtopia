package com.cospost.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CospostDAO implements CospostDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_COURSE_POST_STMT = 
			"INSERT INTO course_post (cosNo, cosPubCon, cosPubTime) VALUES (?, ?, ?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT cosPubNo, cosNo, cosPubCon, cosPubTime FROM course_post";
	private static final String GET_ONE_STMT = 
			"SELECT cosPubNo, cosNo, cosPubCon, cosPubTime FROM course_post where cosPubNo = ?";
				
	private static final String DELETE_COURSE_POST = 
			"DELETE FROM course_post where cosPubNo = ?";	
				
	private static final String UPDATE_COURSE_POST = 
			"UPDATE course_post SET cosNo = ?, cosPubCon = ?, cosPubTime = ? where cosPubNo = ?";

		@Override
		public void insert(CospostVO cospostVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_COURSE_POST_STMT);

				pstmt.setInt(1, cospostVO.getCosNo());
				pstmt.setString(2, cospostVO.getCosPubCon());
				pstmt.setTimestamp(3, cospostVO.getCosPubTime());


				pstmt.executeUpdate();
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
							+ se.getMessage());

			} finally {
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

		}

		@Override
		public void update(CospostVO cospostVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_COURSE_POST);
				
				pstmt.setInt(1, cospostVO.getCosNo());
				pstmt.setString(2, cospostVO.getCosPubCon());
				pstmt.setTimestamp(3, cospostVO.getCosPubTime());
				pstmt.setInt(4, cospostVO.getCosPubNo());

				pstmt.executeUpdate();

			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());

			} finally {
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

		}

		@Override
		public void delete(Integer cosPubNo) {
			
			int updateCount_COURSE_POST = 0;

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();

				con.setAutoCommit(false);

				pstmt = con.prepareStatement(DELETE_COURSE_POST);
				pstmt.setInt(1, cosPubNo);
				updateCount_COURSE_POST = pstmt.executeUpdate();

				con.commit();
				con.setAutoCommit(true);
				System.out.println("updateCount_COURSE_POST：" + cosPubNo);

			} catch (SQLException se) {
				if (con != null) {
					try {
						con.rollback();
					} catch (SQLException excep) {
						throw new RuntimeException("rollback error occured. "
								+ excep.getMessage());
					}
				}
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				
			} finally {
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

		}

		@Override
		public CospostVO findByPrimaryKey(Integer cosPubNo) {

			CospostVO cospostVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, cosPubNo);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					cospostVO = new CospostVO();
					cospostVO.setCosPubNo(rs.getInt("cosPubNo"));
					cospostVO.setCosNo(rs.getInt("cosNo"));
					cospostVO.setCosPubCon(rs.getString("cosPubCon"));
					cospostVO.setCosPubTime(rs.getTimestamp("cosPubTime"));
				}

			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());

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
			return cospostVO;
		}

		@Override
		public List<CospostVO> getAll() {
			
			List<CospostVO> list = new ArrayList<CospostVO>();
			CospostVO cospostVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					cospostVO = new CospostVO();
					cospostVO.setCosPubNo(rs.getInt("cosPubNo"));
					cospostVO.setCosNo(rs.getInt("cosNo"));
					cospostVO.setCosPubCon(rs.getString("cosPubCon"));
					cospostVO.setCosPubTime(rs.getTimestamp("cosPubTime"));
					list.add(cospostVO);
				}

			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
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
			return list;
		}
		
	}
	

