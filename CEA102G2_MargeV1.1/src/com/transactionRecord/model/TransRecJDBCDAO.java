package com.transactionRecord.model;

import java.sql.*;
import java.util.*;

public class TransRecJDBCDAO implements TransRecDAO_interface {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";

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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, transRecVO.getMemNo());
			pstmt.setInt(2, transRecVO.getTraDes());
			pstmt.setInt(3, transRecVO.getTraPri());
			pstmt.setInt(4, transRecVO.getTraBal());

			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, transRecVO.getMemNo());
			pstmt.setInt(2, transRecVO.getTraDes());
			pstmt.setInt(3, transRecVO.getTraPri());
			pstmt.setInt(4, transRecVO.getTraBal());
			pstmt.setInt(5, transRecVO.getTraNo());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, traNo);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, traNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getDate("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getDate("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));

				list.add(transRecVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
	
	public List<TransRecVO> getMemberRecord(Integer traNo){
		List<TransRecVO> list = new ArrayList<TransRecVO>();
		TransRecVO transRecVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_RECORD_BY_MEMBER);
			
			pstmt.setInt(1, traNo);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				transRecVO = new TransRecVO();
				transRecVO.setTraNo(rs.getInt("traNo"));
				transRecVO.setMemNo(rs.getInt("memNO"));
				transRecVO.setTraTime(rs.getDate("traTime"));
				transRecVO.setTraDes(rs.getInt("traDes"));
				transRecVO.setTraPri(rs.getInt("traPri"));
				transRecVO.setTraBal(rs.getInt("traBal"));

				list.add(transRecVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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

	public static void main(String[] args) {
		TransRecJDBCDAO dao = new TransRecJDBCDAO();

		// insert test
//		TransRecVO transRecVO = new TransRecVO();
//		
//		transRecVO.setMemNo(2);
//		transRecVO.setTraDes(1);
//		transRecVO.setTraPri(1000);
//		transRecVO.setTraBal(200);
//		
//		dao.insert(transRecVO);

		// update test
//		TransRecVO transRecVO = new TransRecVO();
//		transRecVO.setTraNo(5);
//		transRecVO.setMemNo(5);
//		transRecVO.setTraDes(2);
//		transRecVO.setTraPri(500);
//		transRecVO.setTraBal(300);
//
//		dao.update(transRecVO);

		// 查詢
//		TransRecVO transRecVO = dao.findByPrimaryKey(5);
//		System.out.print(transRecVO.getTraNo() + ", ");
//		System.out.print(transRecVO.getMemNo()+ ", ");
//		System.out.print(transRecVO.getTraTime() + ", ");
//		System.out.print(transRecVO.getTraDes() + ", ");
//		System.out.print(transRecVO.getTraPri() + ", ");
//		System.out.println(transRecVO.getTraBal());
//		System.out.println("--------------------------------------------------------------------------------------");

		// get all
//		List<TransRecVO> list = dao.getAll();
//		for (TransRecVO transRecVO : list) {
//			System.out.print(transRecVO.getTraNo() + ", ");
//			System.out.print(transRecVO.getMemNo() + ", ");
//			System.out.print(transRecVO.getTraTime() + ", ");
//			System.out.print(transRecVO.getTraDes() + ", ");
//			System.out.print(transRecVO.getTraPri() + ", ");
//			System.out.println(transRecVO.getTraBal());
//			System.out
//					.println("--------------------------------------------------------------------------------------");
//		}
		// delete
//		dao.delete(6);
		//getMemberRecord
		List<TransRecVO> list = dao.getMemberRecord(1);
		for (TransRecVO transRecVO : list) {
			System.out.print(transRecVO.getTraNo() + ", ");
			System.out.print(transRecVO.getMemNo() + ", ");
			System.out.print(transRecVO.getTraTime() + ", ");
			System.out.print(transRecVO.getTraDes() + ", ");
			System.out.print(transRecVO.getTraPri() + ", ");
			System.out.println(transRecVO.getTraBal());
			System.out
					.println("--------------------------------------------------------------------------------------");
		}
		
	}

}
