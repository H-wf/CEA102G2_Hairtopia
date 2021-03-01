package com.rule.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RuleDAO implements RuleDAO_interface{

	private static DataSource ds = null;
	
	static {
		try {
			Context cx = new InitialContext();
			ds = (DataSource)cx.lookup("java:comp/env/jdbc/Hairtopia");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, ruleVO.getRuleName());
			pstmt.setString(2, ruleVO.getRuleCon());

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
	public void update(RuleVO ruleVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, ruleVO.getRuleName());
			pstmt.setString(2, ruleVO.getRuleCon());
			pstmt.setInt(3, ruleVO.getRuleNo());

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
	public void delete(Integer ruleNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ruleNo);

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
	public RuleVO findByPrimaryKey(Integer ruleNo) {
		RuleVO ruleVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
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

			con = ds.getConnection();
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
