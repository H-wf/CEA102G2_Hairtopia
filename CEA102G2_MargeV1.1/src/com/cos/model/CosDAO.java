package com.cos.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.coudet.model.CosdetService;
import com.coudet.model.CosdetVO;
import com.lecturer.model.LecturerVO;

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
	
	private static final String INSERT_COURSE = 
			"INSERT INTO course (lecNo, cosTypeNo, cosFrom, cosTo, "
			+ "cosIntro, cosPic, cosAdd, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String GET_ONE_COURSE_STMT = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, " 
					+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
					+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
					+ "cosApplyTo, cosName FROM course where cosNo = ?";
	
	private static final String GET_ALL_COURSES = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, " 
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName FROM course";
	
	private static final String GET_WHICH_DAY_COURSE_APPLYFROM = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, "
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName FROM course where (cosApplyFrom <= NOW() AND NOW() < cosApplyTo)";
	
	private static final String GET_WHICH_DAY_START_COURSE = 
			"SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, "
			+ "cosIntro, cosPic, cosAdd, cosCount, cosRate, "
			+ "cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, "
			+ "cosApplyTo, cosName FROM course where (cosFrom <= NOW() AND NOW() < cosTo)";
				
	private static final String DELETE_COURSE = 
			"DELETE FROM course where cosNo = ?";	
				
	private static final String UPDATE_COURSE = 
			"UPDATE course SET lecNo=?, cosTypeNo=?, cosFrom=?, cosTo=?, "  
			+ "cosIntro=?, cosPic=?, cosAdd=?, "  
			+ "cosStatus=?, cosMinCount=?, cosMaxCount=?, cosPrice=?, cosApplyFrom=?, "  
			+ "cosApplyTo=?, cosName=? where cosNo = ?";
	
	private static final String UPDATE_COURSE_NO_PIC = 
			"UPDATE course SET lecNo=?, cosTypeNo=?, cosFrom=?, cosTo=?, "  
			+ "cosIntro=?, cosAdd=?, "  
			+ "cosStatus=?, cosMinCount=?, cosMaxCount=?, cosPrice=?, cosApplyFrom=?, "  
			+ "cosApplyTo=?, cosName=? where cosNo = ?";
	
	private static final String ADD_COUNT_APPLY_NO = "UPDATE course SET cosCount=? where cosNo = ? ";
	
	private static final String FIND_COUNT_APPLY_NO = "SELECT cosCount FROM course where cosNo = ? ";
	
	private static final String GET_COMMENT_BY_COSNO = 
			"SELECT AVG(cosComment) FROM coudet WHERE cosNo=?";
	

	public void insert(CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_COURSE);
			
			pstmt.setInt(1, cosVO.getLecNo());
			pstmt.setInt(2, cosVO.getCosTypeNo());
			pstmt.setTimestamp(3, cosVO.getCosFrom());
			pstmt.setTimestamp(4, cosVO.getCosTo());
			pstmt.setString(5, cosVO.getCosIntro());
			pstmt.setBytes(6, cosVO.getCosPic());
			pstmt.setString(7, cosVO.getCosAdd());
			pstmt.setBoolean(8, cosVO.isCosStatus());
			pstmt.setInt(9, cosVO.getCosMinCount());
			pstmt.setInt(10, cosVO.getCosMaxCount());
			pstmt.setInt(11, cosVO.getCosPrice());
			pstmt.setTimestamp(12, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(13, cosVO.getCosApplyTo());
			pstmt.setString(14, cosVO.getCosName());

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
			pstmt.setBoolean(8, cosVO.isCosStatus());
			pstmt.setInt(9, cosVO.getCosMinCount());
			pstmt.setInt(10, cosVO.getCosMaxCount());
			pstmt.setInt(11, cosVO.getCosPrice());
			pstmt.setTimestamp(12, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(13, cosVO.getCosApplyTo());
			pstmt.setString(14, cosVO.getCosName());
			pstmt.setInt(15, cosVO.getCosNo());

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
			pstmt.setBoolean(7, cosVO.isCosStatus());
			pstmt.setInt(8, cosVO.getCosMinCount());
			pstmt.setInt(9, cosVO.getCosMaxCount());
			pstmt.setInt(10, cosVO.getCosPrice());
			pstmt.setTimestamp(11, cosVO.getCosApplyFrom());
			pstmt.setTimestamp(12, cosVO.getCosApplyTo());
			pstmt.setString(13, cosVO.getCosName());
			pstmt.setInt(14, cosVO.getCosNo());

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
				cosVO.setCosStatus(rs.getBoolean("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
System.out.println("check");				
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
			pstmt = con.prepareStatement(GET_ALL_COURSES);
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
				cosVO.setCosStatus(rs.getBoolean("cosStatus"));
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
			
//			String finalSQLforLec = "select * from lecturer "
//			          + jdbcUtil_CompositeQuery_Cos.get_WhereCondition(map)
//			          + "order by lecno";
//			PreparedStatement pstmtforLec = con.prepareStatement(finalSQLforLec);
//			System.out.println("●●finalSQL(by DAO) = "+finalSQLforLec);
//			ResultSet rsforLec = pstmtforLec.executeQuery();
	
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
				cosVO.setCosStatus(rs.getBoolean("cosStatus"));
				cosVO.setCosMinCount(rs.getInt("cosMinCount"));
				cosVO.setCosMaxCount(rs.getInt("cosMaxCount"));
				cosVO.setCosPrice(rs.getInt("cosPrice"));
				cosVO.setCosApplyFrom(rs.getTimestamp("cosApplyFrom"));
				cosVO.setCosApplyTo(rs.getTimestamp("cosApplyTo"));
				cosVO.setCosName(rs.getString("cosName"));
//				while (rsforLec.next()) {
////					LecturerVO lecVO = new LecturerVO();
////					List<CosVO> cosVOforLec = new ArrayList<CosVO>();
////					lecVO.setLecIntro(rsforLec.getString("lecIntro"));
////					lecVO.setLecName(rsforLec.getString("lecName"));
////					lecVO.setLecStatus(rsforLec.getInt("lecStatus"));
////					List<LecturerVO> listforLec = new ArrayList<LecturerVO>();
////					listforLec.add(lecVO);
////					cosVOforLec = (List<CosVO>)listforLec;
////					list.add(cosVOforLec);
//					CosVO cosVO1 = new CosVO();
//					cosVO1.setLecIntro(rsforLec.getString("lecIntro"));
//					cosVO1.setLecName(rsforLec.getString("lecName"));
//					cosVO1.setLecStatus(rsforLec.getInt("lecStatus"));
//					list.add(cosVO1);
//					
//				}
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
				System.out.println(rs.getInt("cosNo"));
				System.out.println("cosDAO NO.543 ===============");
				cosVO.setLecNo(rs.getInt("lecNo"));
				cosVO.setCosTypeNo(rs.getInt("cosTypeNo"));
				cosVO.setCosFrom(rs.getTimestamp("cosFrom"));
				cosVO.setCosTo(rs.getTimestamp("cosTo"));
				cosVO.setCosIntro(rs.getString("cosIntro"));
				cosVO.setCosPic(rs.getBytes("cosPic"));
				cosVO.setCosAdd(rs.getString("cosAdd"));
				cosVO.setCosCount(rs.getInt("cosCount"));
				cosVO.setCosRate(rs.getInt("cosRate"));
				cosVO.setCosStatus(rs.getBoolean("cosStatus"));
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
	public List<CosVO> getAllCosFrom() {
		List<CosVO> list = new ArrayList<CosVO>();
		CosVO cosVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WHICH_DAY_START_COURSE);
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
				cosVO.setCosStatus(rs.getBoolean("cosStatus"));
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
	public void AddCountApplyNo(CosVO cosVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(ADD_COUNT_APPLY_NO);
			pstmt.setInt(1, (cosVO.getCosCount()+1));
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
	
	public CosVO FindCountApplyNo(Integer cosNo) {
		CosVO cosVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_COUNT_APPLY_NO);

			pstmt.setInt(1, cosNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				cosVO = new CosVO();
				cosVO.setCosCount(rs.getInt("cosCount"));
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
	
	@Override
	public CosdetVO getAvgCosRateByCosNo(Integer cosNo) {
		CosdetVO cosdetVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COMMENT_BY_COSNO);

			pstmt.setInt(1, cosNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				cosdetVO = new CosdetVO();
				cosdetVO.setCosComment(rs.getInt("cosComment"));
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
		return cosdetVO;
	}
}
