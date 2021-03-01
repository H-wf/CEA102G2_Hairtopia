package com.cos.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import CompositeQuery.jdbcUtil_CompositeQuery_Cos;

public class CosDAO implements CosDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_COURSE_STMT = 
			"INSERT INTO course (lecNo, cosTypeNo, cosFrom, cosTo, "
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
	private static final String GET_ALL_COURSES_STMT = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, " 
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName FROM course";
	
	private static final String GET_ONE_COURSE_STMT = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, " 
					+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
					+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
					+ "cosApplyTo, cosName FROM course where cosNo = ?";
	
	private static final String GET_WHICH_DAY_COURSE_APPLYFROM = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, "
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName FROM course where cosApplyFrom > NOW()";
	
	private static final String UPDATE_COURSE_STATUS = 
			"Update course SET cosStatus = ? where cosNo = ?";
	
	private static final String GET_WHICH_DAY_APPLY_COURSE = 
			"SELECT cosNO FROM course where cosApplyFrom > NOW()";
				
	private static final String DELETE_COURSE = 
			"DELETE FROM course where cosNo = ?";	
				
	private static final String UPDATE_COURSE = 
			"UPDATE course SET lecNo=?, cosTypeNo=?, cosFrom=?, cosTo=?, "  
			+ "cosIntro=?, cosPic=?, cosAdd=?, cosCount=?, cosRate=?, "  
			+ "cosStatus=?, cosMinCount=?, cosMaxCount=?, cosPrice=?, cosApplyFrom=?, "  
			+ "cosApplyTo=?, cosName=? where cosNo = ?";
	
	private static final String UPDATE_COURSE_NO_PIC = 
			"UPDATE course SET lecNo=?, cosTypeNo=?, cosFrom=?, cosTo=?, "  
			+ "cosIntro=?, cosAdd=?, cosCount=?, cosRate=?, "  
			+ "cosStatus=?, cosMinCount=?, cosMaxCount=?, cosPrice=?, cosApplyFrom=?, "  
			+ "cosApplyTo=?, cosName=? where cosNo = ?";
	
	

	public void insert(CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_COURSE_STMT);
			
			pstmt.setInt(1, cosVO.getLecNo());
			pstmt.setInt(2, cosVO.getCosTypeNo());
			pstmt.setTimestamp(3, cosVO.getCosFrom());
			pstmt.setTimestamp(4, cosVO.getCosTo());
			pstmt.setString(5, cosVO.getCosIntro());
			pstmt.setBytes(6, cosVO.getCosPic());
			pstmt.setString(7, cosVO.getCosAdd());
			pstmt.setInt(8, cosVO.getCosCount());
			pstmt.setInt(9, cosVO.getCosRate());
			pstmt.setInt(10, cosVO.getCosStatus());
			pstmt.setInt(11, cosVO.getCosMinCount());
			pstmt.setInt(12, cosVO.getCosMaxCount());
			pstmt.setInt(13, cosVO.getCosPrice());
			pstmt.setTimestamp(14, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(15, cosVO.getCosApplyTo());
			pstmt.setString(16, cosVO.getCosName());

			pstmt.executeUpdate("set auto_increment_offset=3;");
			pstmt.executeUpdate("set auto_increment_increment=3;");
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);//The "standard" error output stream.
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

	public void update(CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_COURSE);
			pstmt.setInt(1, cosVO.getLecNo());
			pstmt.setInt(2, cosVO.getCosTypeNo());
			pstmt.setTimestamp(3, cosVO.getCosFrom());
			pstmt.setTimestamp(4, cosVO.getCosTo());
			pstmt.setString(5, cosVO.getCosIntro());
			pstmt.setBytes(6, cosVO.getCosPic());
			pstmt.setString(7, cosVO.getCosAdd());
			pstmt.setInt(8, cosVO.getCosCount());
			pstmt.setInt(9, cosVO.getCosRate());
			pstmt.setInt(10, cosVO.getCosStatus());
			pstmt.setInt(11, cosVO.getCosMinCount());
			pstmt.setInt(12, cosVO.getCosMaxCount());
			pstmt.setInt(13, cosVO.getCosPrice());
			pstmt.setTimestamp(14, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(15, cosVO.getCosApplyTo());
			pstmt.setString(16, cosVO.getCosName());
			pstmt.setInt(17, cosVO.getCosNo());

			pstmt.executeUpdate();

		// Handle any SQL errors
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
	
	public void updateNoPic (CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_COURSE_NO_PIC);
			pstmt.setInt(1, cosVO.getLecNo());
			pstmt.setInt(2, cosVO.getCosTypeNo());
			pstmt.setTimestamp(3, cosVO.getCosFrom());
			pstmt.setTimestamp(4, cosVO.getCosTo());
			pstmt.setString(5, cosVO.getCosIntro());
			pstmt.setString(6, cosVO.getCosAdd());
			pstmt.setInt(7, cosVO.getCosCount());
			pstmt.setInt(8, cosVO.getCosRate());
			pstmt.setInt(9, cosVO.getCosStatus());
			pstmt.setInt(10, cosVO.getCosMinCount());
			pstmt.setInt(11, cosVO.getCosMaxCount());
			pstmt.setInt(12, cosVO.getCosPrice());
			pstmt.setTimestamp(13, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(14, cosVO.getCosApplyTo());
			pstmt.setString(15, cosVO.getCosName());
			pstmt.setInt(16, cosVO.getCosNo());

			pstmt.executeUpdate();

		// Handle any SQL errors
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
	
	public void updateCosStatus (CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;		

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_COURSE_STATUS);
			 
			
			
			pstmt.setInt(1, cosVO.getCosStatus());
			
			pstmt.setInt(2, cosVO.getCosNo());

			pstmt.executeUpdate();

		// Handle any SQL errors
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
	
	public void delete(Integer cosNo) {
		int updateCount_COURSE = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			con.setAutoCommit(false);

			pstmt = con.prepareStatement(DELETE_COURSE);
			pstmt.setInt(1, cosNo);
			updateCount_COURSE = pstmt.executeUpdate();

			con.commit();
			con.setAutoCommit(true);
			System.out.println("updateCount_COURSE：" + cosNo);
			
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

	public CosVO findByPrimaryKey(Integer cosNo) {
		CosVO cosVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_COURSE_STMT);

			pstmt.setInt(1, cosNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				cosVO = new CosVO();
				cosVO.setCosNo(rs.getInt("cosNo"));
				cosVO.setLecNo(rs.getInt("lecNo"));
				cosVO.setCosTypeNo(rs.getInt("cosTypeNo"));
				cosVO.setCosFrom(rs.getTimestamp("cosFrom"));
				cosVO.setCosTo(rs.getTimestamp("cosTo"));
				cosVO.setCosIntro(rs.getString("cosIntro"));
				cosVO.setCosPic(rs.getBytes("cosPic"));
				cosVO.setCosAdd(rs.getString("cosAdd"));
				cosVO.setCosCount(rs.getInt("cosCount"));
				cosVO.setCosRate(rs.getInt("cosRate"));
				cosVO.setCosStatus(rs.getInt("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
			}

			// Handle any SQL errors
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
		return cosVO;
	}

	public List<CosVO> getAll() {
		List<CosVO> list = new ArrayList<CosVO>();
		CosVO cosVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_COURSES_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				cosVO = new CosVO();
				cosVO.setCosNo(rs.getInt("cosNo"));
				cosVO.setLecNo(rs.getInt("lecNo"));
				cosVO.setCosTypeNo(rs.getInt("cosTypeNo"));
				cosVO.setCosFrom(rs.getTimestamp("cosFrom"));
				cosVO.setCosTo(rs.getTimestamp("cosTo"));
				cosVO.setCosIntro(rs.getString("cosIntro"));
				cosVO.setCosPic(rs.getBytes("cosPic"));
				cosVO.setCosAdd(rs.getString("cosAdd"));
				cosVO.setCosCount(rs.getInt("cosCount"));
				cosVO.setCosRate(rs.getInt("cosRate"));
				cosVO.setCosStatus(rs.getInt("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
				list.add(cosVO); // Store the row in the list
			}

			// Handle any SQL errors
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

	@Override
	public List<CosVO> getAll(Map<String, String[]> map) {
		List<CosVO> list = new ArrayList<CosVO>();
		CosVO cosVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from course "
		          + jdbcUtil_CompositeQuery_Cos.get_WhereCondition(map)
		          + "order by cosno";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				cosVO = new CosVO();
				cosVO.setCosNo(rs.getInt("cosNo"));
				cosVO.setLecNo(rs.getInt("lecNo"));
				cosVO.setCosTypeNo(rs.getInt("cosTypeNo"));
				cosVO.setCosFrom(rs.getTimestamp("cosFrom"));
				cosVO.setCosTo(rs.getTimestamp("cosTo"));
				cosVO.setCosIntro(rs.getString("cosIntro"));
				cosVO.setCosPic(rs.getBytes("cosPic"));
				cosVO.setCosAdd(rs.getString("cosAdd"));
				cosVO.setCosCount(rs.getInt("cosCount"));
				cosVO.setCosRate(rs.getInt("cosRate"));
				cosVO.setCosStatus(rs.getInt("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
				list.add(cosVO); // Store the row in the List
			}
	
			// Handle any SQL errors
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

	@Override
	public List<CosVO> getAllCosApplyFrom() {
		List<CosVO> list = new ArrayList<CosVO>();
		CosVO cosVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WHICH_DAY_COURSE_APPLYFROM);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				cosVO = new CosVO();
				cosVO.setCosNo(rs.getInt("cosNo"));
				cosVO.setLecNo(rs.getInt("lecNo"));
				cosVO.setCosTypeNo(rs.getInt("cosTypeNo"));
				cosVO.setCosFrom(rs.getTimestamp("cosFrom"));
				cosVO.setCosTo(rs.getTimestamp("cosTo"));
				cosVO.setCosIntro(rs.getString("cosIntro"));
				cosVO.setCosPic(rs.getBytes("cosPic"));
				cosVO.setCosAdd(rs.getString("cosAdd"));
				cosVO.setCosCount(rs.getInt("cosCount"));
				cosVO.setCosRate(rs.getInt("cosRate"));
				cosVO.setCosStatus(rs.getInt("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
				list.add(cosVO); // Store the row in the list
			}

			// Handle any SQL errors
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
