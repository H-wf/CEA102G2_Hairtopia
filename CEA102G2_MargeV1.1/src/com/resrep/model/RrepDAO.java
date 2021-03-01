package com.resrep.model;

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

public class RrepDAO implements RrepDAO_interface{
	
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
		"INSERT INTO resrep (resNo,desNo,rrepCon,rrepTime,rrepStatus) VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT rrepNo,resNo,desNo,rrepCon,rrepTime,rrepStatus FROM resrep order by rrepNo";
	private static final String GET_ONE_STMT = 
		"SELECT rrepNo,resNo,desNo,rrepCon,rrepTime,rrepStatus FROM resrep where rrepNo = ?";
	private static final String DELETE = 
		"DELETE FROM resrep where rrepNo = ?";
	private static final String UPDATE = 
		"UPDATE resrep set rrepCon=? where rrepNo = ?";
	private static final String UPDATE_STATUS = 
		"UPDATE resrep set rrepStatus=? where rrepNo = ?";

	@Override
	public void insert(RrepVO rrepVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, rrepVO.getResNo());
			pstmt.setInt(2, rrepVO.getDesNo());
			pstmt.setString(3, rrepVO.getRrepCon());
			pstmt.setDate(4, rrepVO.getRrepTime());
			pstmt.setInt(5, rrepVO.getRrepStatus());

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
	public void update(RrepVO rrepVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

//			pstmt.setInt(1, rrepVO.getRrepNo());
//			pstmt.setInt(2, rrepVO.getResNo());
//			pstmt.setInt(3, rrepVO.getDesNo());
//			pstmt.setString(4, rrepVO.getRrepCon());
//			pstmt.setDate(5, rrepVO.getRrepTime());
//			pstmt.setInt(6, rrepVO.getRrepStatus());
			
			pstmt.setString(1, rrepVO.getRrepCon());
			pstmt.setInt(2, rrepVO.getRrepNo());

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
	public void updateStatus(RrepVO rrepVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setInt(1, rrepVO.getRrepStatus());
			pstmt.setInt(2, rrepVO.getRrepNo());

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
	public void delete(Integer rrepNo) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, rrepNo);

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
	public RrepVO findByPrimaryKey(Integer rrepNo) {
		// TODO Auto-generated method stub
		RrepVO rrepVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, rrepNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// rrepVO 也稱為 Domain objects
				rrepVO = new RrepVO();

				rrepVO.setRrepNo(rs.getInt("rrepNo"));
				rrepVO.setResNo(rs.getInt("resNo"));
				rrepVO.setDesNo(rs.getInt("desNo"));
				rrepVO.setRrepCon(rs.getString("rrepCon"));
				rrepVO.setRrepTime(rs.getDate("rrepTime"));
				rrepVO.setRrepStatus(rs.getInt("rrepStatus"));
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
		return rrepVO;
	}

	@Override
	public List<RrepVO> getAll() {
		// TODO Auto-generated method stub
		List<RrepVO> list = new ArrayList<RrepVO>();
		RrepVO rrepVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				rrepVO = new RrepVO();

				rrepVO.setRrepNo(rs.getInt("rrepNo"));
				rrepVO.setResNo(rs.getInt("resNo"));
				rrepVO.setDesNo(rs.getInt("desNo"));
				rrepVO.setRrepCon(rs.getString("rrepCon"));
				rrepVO.setRrepTime(rs.getDate("rrepTime"));
				rrepVO.setRrepStatus(rs.getInt("rrepStatus"));
				list.add(rrepVO); // Store the row in the list
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

	

}
