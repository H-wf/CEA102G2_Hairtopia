package com.transactionRecord.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class TransRecDAO implements TransRecDAO_interface{

	private static DataSource ds = null;
	
	static {
		try {
			Context cx = new InitialContext();
			ds = (DataSource)cx.lookup("java:comp/env/jdbc/Hairtopia");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO TRANSACTION_RECORD (memNo, traDes, traPri, traBal) VALUES ( ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM TRANSACTION_RECORD";
	private static final String GET_ONE_STMT = "SELECT * FROM TRANSACTION_RECORD WHERE traNo = ?";
	private static final String GET_RECORD_BY_MEMBER = "SELECT * FROM TRANSACTION_RECORD WHERE memNO = ?";
	private static final String DELETE = "DELETE FROM TRANSACTION_RECORD WHERE traNo = ?";
	private static final String UPDATE = "UPDATE TRANSACTION_RECORD SET memNo=?, traDes=? , traPri=?, traBal=? WHERE traNo = ?";


	@Override
	public void insert(TransRecVO transRecVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, transRecVO.getMemNo());
			pstmt.setInt(2, transRecVO.getTraDes());
			pstmt.setInt(3, transRecVO.getTraPri());
			pstmt.setInt(4, transRecVO.getTraBal());

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(TransRecVO transRecVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, transRecVO.getMemNo());
			pstmt.setInt(2, transRecVO.getTraDes());
			pstmt.setInt(3, transRecVO.getTraPri());
			pstmt.setInt(4, transRecVO.getTraBal());
			pstmt.setInt(5, transRecVO.getTraNo());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void delete(Integer traNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, traNo);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public TransRecVO findByPrimaryKey(Integer traNo) {
		TransRecVO transRecVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, traNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getTimestamp("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));
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
		return transRecVO;
	}

	@Override
	public List<TransRecVO> getAll() {
		List<TransRecVO> list = new ArrayList<TransRecVO>();
		TransRecVO transRecVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getTimestamp("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));

				list.add(transRecVO);
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
		return list;
	}
	
	@Override
	public List<TransRecVO> getMemberRecord(Integer traNo) {
		List<TransRecVO> list = new ArrayList<TransRecVO>();
		TransRecVO transRecVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getTimestamp("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));

				list.add(transRecVO);
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
		return list;
	}

}
