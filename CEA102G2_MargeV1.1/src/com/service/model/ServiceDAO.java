package com.service.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.service.model.ServiceVO;

public class ServiceDAO implements ServiceDAO_interface{
	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
		private static DataSource ds = null;
		static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
		
			private static final String INSERT_STMT = 
				"INSERT INTO service (desNo,stypeNo,serName,serPrice,serTime,serDesc,serStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			private static final String GET_ALL_STMT = 
				"SELECT serNo,desNo,stypeNo,serName,serPrice,serTime,serDesc,serStatus FROM service order by serNo";
			private static final String GET_ONE_STMT = 
				"SELECT serNo,desNo,stypeNo,serName,serPrice,serTime,serDesc,serStatus FROM service where serNo = ?";
			private static final String GET_ALL_BY_DESNO = 
				"SELECT serNo,desNo,stypeNo,serName,serPrice,serTime,serDesc,serStatus FROM service where desNo = ?";
			private static final String GET_ALL_BY_STYPENO = 
					"SELECT serNo,desNo,stypeNo,serName,serPrice,serTime,serDesc,serStatus FROM service where stypeNo = ?";
			
			private static final String DELETE = 
				"DELETE FROM service where serNo = ?";
			
			private static final String UPDATE = 
				"UPDATE service set desNo=?, stypeNo=?, serName=?, serPrice=?, serTime=?, serDesc=?, serStatus=? where serNo = ?";
			private static final String UPDATE_ONE_BY_SERNO = 
					"UPDATE service set serStatus=? where serNo = ?";

	@Override
	public void insert(ServiceVO serviceVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, serviceVO.getDesNo());
			pstmt.setInt(2, serviceVO.getStypeNo());
			pstmt.setString(3, serviceVO.getSerName());
			pstmt.setInt(4, serviceVO.getSerPrice());
			pstmt.setInt(5, serviceVO.getSerTime());
			pstmt.setString(6, serviceVO.getSerDesc());
			pstmt.setInt(7, serviceVO.getSerStatus());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "//丟出RuntimeException才不會有繼承限制
					+ se.getMessage());
			// Clean up JDBC resources
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
	public void update(ServiceVO serviceVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, serviceVO.getDesNo());
			pstmt.setInt(2, serviceVO.getStypeNo());
			pstmt.setString(3, serviceVO.getSerName());
			pstmt.setInt(4, serviceVO.getSerPrice());
			pstmt.setInt(5, serviceVO.getSerTime());
			pstmt.setString(6, serviceVO.getSerDesc());
			pstmt.setInt(7, serviceVO.getSerStatus());
			pstmt.setInt(8, serviceVO.getSerNo());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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
	public void delete(Integer serNo) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, serNo);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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
	public List<ServiceVO> getAll() {

		List<ServiceVO> list = new ArrayList<ServiceVO>();
		ServiceVO serviceVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// serviceVO 也稱為 Domain objects
				serviceVO = new ServiceVO();
				serviceVO.setSerNo(rs.getInt("serNo"));
				serviceVO.setDesNo(rs.getInt("desNo"));
				serviceVO.setStypeNo(rs.getInt("stypeNo"));
				serviceVO.setSerName(rs.getString("serName"));
				serviceVO.setSerPrice(rs.getInt("serPrice"));
				serviceVO.setSerTime(rs.getInt("serTime"));
				serviceVO.setSerDesc(rs.getString("serDesc"));
				serviceVO.setSerStatus(rs.getInt("serStatus"));
				list.add(serviceVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		
		return list;
		
	}

	@Override
	public ServiceVO findByPrimaryKeySerNo(Integer serNo) {
		// TODO Auto-generated method stub
		ServiceVO serviceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, serNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// serviceVO 也稱為 Domain objects
				serviceVO = new ServiceVO();
				serviceVO.setSerNo(rs.getInt("serNo"));
				serviceVO.setDesNo(rs.getInt("desNo"));
				serviceVO.setStypeNo(rs.getInt("stypeNo"));
				serviceVO.setSerName(rs.getString("serName"));
				serviceVO.setSerPrice(rs.getInt("serPrice"));
				serviceVO.setSerTime(rs.getInt("serTime"));
				serviceVO.setSerDesc(rs.getString("serDesc"));
				serviceVO.setSerStatus(rs.getInt("serStatus"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		
		return serviceVO;
	}

	@Override
	public List<ServiceVO> findByPrimaryKeyDesNo(Integer desNo) {
		// TODO Auto-generated method stub
		List<ServiceVO> list = new ArrayList<ServiceVO>();
		ServiceVO serviceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_DESNO);

			pstmt.setInt(1, desNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// serviceVO 也稱為 Domain objects
				serviceVO = new ServiceVO();
				serviceVO.setSerNo(rs.getInt("serNo"));
				serviceVO.setDesNo(rs.getInt("desNo"));
				serviceVO.setStypeNo(rs.getInt("stypeNo"));
				serviceVO.setSerName(rs.getString("serName"));
				serviceVO.setSerPrice(rs.getInt("serPrice"));
				serviceVO.setSerTime(rs.getInt("serTime"));
				serviceVO.setSerDesc(rs.getString("serDesc"));
				serviceVO.setSerStatus(rs.getInt("serStatus"));
				list.add(serviceVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		
		return list;
	}

	@Override
	public List<ServiceVO> findByPrimaryKeyStypeNo(Integer stypeNo) {
		// TODO Auto-generated method stub
		List<ServiceVO> list = new ArrayList<ServiceVO>();
		ServiceVO serviceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_STYPENO);

			pstmt.setInt(1, stypeNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// serviceVO 也稱為 Domain objects
				serviceVO = new ServiceVO();
				serviceVO.setSerNo(rs.getInt("serNo"));
				serviceVO.setDesNo(rs.getInt("desNo"));
				serviceVO.setStypeNo(rs.getInt("stypeNo"));
				serviceVO.setSerName(rs.getString("serName"));
				serviceVO.setSerPrice(rs.getInt("serPrice"));
				serviceVO.setSerTime(rs.getInt("serTime"));
				serviceVO.setSerDesc(rs.getString("serDesc"));
				serviceVO.setSerStatus(rs.getInt("serStatus"));
				list.add(serviceVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		
		return list;
	}

	@Override
	public void updateSerStatus(ServiceVO serviceVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_ONE_BY_SERNO);

			pstmt.setInt(1, serviceVO.getSerStatus());
			pstmt.setInt(2, serviceVO.getSerNo());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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

	
	
	
	

}
