package com.lecturer.model;

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

public class LecturerDAO implements LecturerDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO lecturer (lecName,lecPic,lecIntro,lecStatus,staNo) VALUES (?, ?, ?, ?,?)";
	private static final String GET_ALL_STMT = "SELECT lecNo,lecName,lecIntro,lecStatus FROM lecturer order by lecNo";
	private static final String GET_ONE_STMT = "SELECT lecNo,lecName,lecIntro,lecStatus FROM lecturer where lecNo= ?";
	private static final String DELETE = "DELETE FROM lecturer where lecNo = ?";
	private static final String UPDATE = "UPDATE lecturer set lecName=?, lecPic=?, lecIntro=?, lecStatus=? where lecNo = ?";
	private static final String UPDATE2 = "UPDATE lecturer set lecName=?,  lecIntro=?, lecStatus=? where lecNo = ?";
	private static final String GET_ONE_UQ = "SELECT lecNo,lecName,lecIntro,lecStatus FROM lecturer where staNo= ?";
	public void insert(LecturerVO lecVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, lecVO.getLecName());
			pstmt.setBytes(2, lecVO.getLecPic());
			pstmt.setString(3, lecVO.getLecIntro());
			pstmt.setInt(4, lecVO.getLecStatus());
			pstmt.setInt(5, lecVO.getStaNo());

			pstmt.executeUpdate();

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

	public void update(LecturerVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, lecVO.getLecName());
			pstmt.setBytes(2, lecVO.getLecPic());
			pstmt.setString(3, lecVO.getLecIntro());
			pstmt.setInt(4, lecVO.getLecStatus());
			pstmt.setInt(5, lecVO.getLecNo());

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

	public void delete(Integer lecNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, lecNo);

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
	
	public LecturerVO findByStaNo(Integer staNo) {

		LecturerVO lecVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_UQ);

			pstmt.setInt(1, staNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				lecVO = new LecturerVO();
				lecVO.setLecNo(rs.getInt("lecno"));
				lecVO.setLecName(rs.getString("lecname"));
				lecVO.setLecIntro(rs.getString("lecintro"));
				lecVO.setLecStatus(rs.getInt("lecstatus"));

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
		return lecVO;
	}

	public LecturerVO findByPrimaryKey(Integer lecNo) {

		LecturerVO lecVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, lecNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				lecVO = new LecturerVO();
				lecVO.setLecNo(rs.getInt("lecno"));
				lecVO.setLecName(rs.getString("lecname"));
				lecVO.setLecIntro(rs.getString("lecintro"));
				lecVO.setLecStatus(rs.getInt("lecstatus"));

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
		return lecVO;
	}

	@Override
	public List<LecturerVO> getAll() {

		List<LecturerVO> list = new ArrayList<LecturerVO>();
		LecturerVO lecVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				lecVO = new LecturerVO();
				lecVO.setLecNo(rs.getInt("lecno"));
				lecVO.setLecName(rs.getString("lecname"));
				lecVO.setLecIntro(rs.getString("lecintro"));
				lecVO.setLecStatus(rs.getInt("lecStatus"));

				list.add(lecVO); // Store the row in the list
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
	public void update2(LecturerVO lecVO) {
		// 更新資料但不更新圖片
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE2);
			pstmt.setString(1, lecVO.getLecName());
			pstmt.setString(2, lecVO.getLecIntro());
			pstmt.setInt(3, lecVO.getLecStatus());
			pstmt.setInt(4, lecVO.getLecNo());

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

}
