package com.rule.model;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

public class RuleJDBCDAO implements RuleDAO_interface {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO RULE (ruleName, ruleCon) VALUES ( ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM RULE";
	private static final String GET_ONE_STMT = "SELECT * FROM RULE WHERE ruleNo = ?";
	private static final String DELETE = "DELETE FROM RULE WHERE ruleNo = ?";
	private static final String UPDATE = "UPDATE RULE SET ruleName=?, ruleCon=? WHERE ruleNo = ?";

	@Override
	public void insert(RuleVO ruleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, ruleVO.getRuleName());
			pstmt.setString(2, ruleVO.getRuleCon());

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
	public void update(RuleVO ruleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, ruleVO.getRuleName());
			pstmt.setString(2, ruleVO.getRuleCon());
			pstmt.setInt(3, ruleVO.getRuleNo());

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
	public void delete(Integer ruleNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ruleNo);

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
	public RuleVO findByPrimaryKey(Integer ruleNo) {
		RuleVO ruleVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, ruleNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				ruleVO = new RuleVO();
				ruleVO.setRuleNo(rs.getInt("ruleNo"));
				ruleVO.setRuleName(rs.getString("ruleName"));
				ruleVO.setRuleCon(rs.getString("ruleCon"));
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
		return ruleVO;
	}

	@Override
	public List<RuleVO> getAll() {
		List<RuleVO> list = new ArrayList<RuleVO>();
		RuleVO ruleVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				// memName,memGender,memPic,memInform,memEmail,memPswd,memPhone,memAddr,memBal,memStatus,memEndDate,
				// memCode
				ruleVO = new RuleVO();
				ruleVO.setRuleNo(rs.getInt("ruleNo"));
				ruleVO.setRuleName(rs.getString("ruleName"));
				ruleVO.setRuleCon(rs.getString("ruleCon"));

				list.add(ruleVO);
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
		RuleJDBCDAO dao = new RuleJDBCDAO();

		// insert test
//		RuleVO ruleVO = new RuleVO();
//		
//		ruleVO.setRuleName("最夯訊息");
//		ruleVO.setRuleCon("長直髮,短髮");
//		
//		dao.insert(ruleVO);

		// update test
//		RuleVO ruleVO = new RuleVO();
//		ruleVO.setRuleNo(6);
//		ruleVO.setRuleName("ab");
//		ruleVO.setRuleCon("Lot e");
//
//		dao.update(ruleVO);

		// 查詢
//		RuleVO ruleVO = dao.findByPrimaryKey(5);
//		System.out.print(ruleVO.getRuleNo() + ", ");
//		System.out.print(ruleVO.getRuleName() + ", ");
//		System.out.println(ruleVO.getRuleCon());
//		System.out.println("--------------------------------------------------------------------------------------");

		// get all
//		List<RuleVO> list = dao.getAll();
//		for (RuleVO ruleVO : list) {
//			System.out.print(ruleVO.getRuleNo() + ", ");
//			System.out.print(ruleVO.getRuleName() + ", ");
//			System.out.println(ruleVO.getRuleCon() );
//			System.out.println("--------------------------------------------------------------------------------------");
//		}
		// delete
//		dao.delete(6);
	}

}
