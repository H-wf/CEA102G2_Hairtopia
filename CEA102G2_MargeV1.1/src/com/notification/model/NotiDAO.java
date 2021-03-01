package com.notification.model;

import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class NotiDAO implements NotiDAO_interface{

private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_TEXT_STMT = "INSERT INTO NOTIFICATION (memNo, notiText, notiIsRead) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM NOTIFICATION";
	private static final String GET_ONE_STMT = "SELECT * FROM NOTIFICATION WHERE notiNo = ?";
	private static final String DELETE = "DELETE FROM NOTIFICATION WHERE notiNo = ?";
	private static final String UPDATE = "UPDATE NOTIFICATION set memNo=?, notiText=?, notiIsRead= ? WHERE notiNo = ?";

	
	@Override
	public void insert(NotiVO notiVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_TEXT_STMT);

			pstmt.setInt(1, notiVO.getMemNo());
			pstmt.setString(2, notiVO.getNotiText());
			pstmt.setBoolean(3, notiVO.getNotiIsRead());

			pstmt.execute();

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
	public void update(NotiVO notiVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, notiVO.getMemNo());
			pstmt.setString(2, notiVO.getNotiText());
			pstmt.setBoolean(3, (notiVO.getNotiIsRead() == null) ? false : notiVO.getNotiIsRead());
			pstmt.setInt(4, notiVO.getNotiNo());

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
	public void delete(Integer notiNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, notiNo);

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
	public NotiVO findByPrimaryKey(Integer notiNo) {
		NotiVO notiVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, notiNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				notiVO = new NotiVO();
				notiVO.setNotiNo(rs.getInt("notiNo"));
				notiVO.setMemNo(rs.getInt("memNo"));
				notiVO.setNotiText(rs.getString("notiText"));
				notiVO.setNotiTime(rs.getTimestamp("notiTime"));
				notiVO.setNotiIsRead(rs.getBoolean("notiIsRead"));
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
		return notiVO;
	}

	@Override
	public List<NotiVO> getAll() {
		List<NotiVO> list = new ArrayList<NotiVO>();
		NotiVO notiVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				notiVO = new NotiVO();
				notiVO.setNotiNo(rs.getInt("notiNo"));
				notiVO.setMemNo(rs.getInt("memNo"));
				notiVO.setNotiText(rs.getString("notiText"));
				notiVO.setNotiTime(rs.getTimestamp("notiTime"));
				notiVO.setNotiIsRead(rs.getBoolean("notiIsRead"));

				list.add(notiVO);
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
