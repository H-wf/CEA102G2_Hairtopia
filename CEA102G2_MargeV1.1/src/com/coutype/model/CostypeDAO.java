package com.coutype.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.cos.model.CosVO;

public class CostypeDAO implements CostypeDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_coutype_STMT = 
			"INSERT INTO coutype (cosTypeName, cosTypeIntro) VALUES (?, ?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT cosTypeNo, cosTypeName, cosTypeIntro FROM coutype";
	private static final String GET_ONE_STMT = 
			"SELECT cosTypeNo, cosTypeName, cosTypeIntro FROM coutype where cosTypeNo = ?";
	private static final String GET_Cos_ByCosTypeNo_STMT = "SELECT cosNo, lecNo, cosTypeNo, cosFrom, cosTo, cosIntro, cosPic, cosAdd, cosCount, cosRate, cosStatus, cosMinCount, cosMaxCount, cosPrice, cosApplyFrom, cosApplyTo, cosName FROM course where costypeno = ? order by cosno";
				
	private static final String DELETE_coutype = 
			"DELETE FROM coutype where cosTypeNo = ?";	
				
	private static final String UPDATE_coutype = 
			"UPDATE coutype SET cosTypeName=?, cosTypeIntro = ? where cosTypeNo = ?";

		@Override
		public void insert(CostypeVO costypeVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_coutype_STMT);

				pstmt.setString(1, costypeVO.getCosTypeName());
				pstmt.setString(2, costypeVO.getCosTypeIntro());


				pstmt.executeUpdate();
				
			} catch (SQLException se) {
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

		@Override
		public void update(CostypeVO costypeVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_coutype);
				
				
				pstmt.setString(1, costypeVO.getCosTypeName());
				pstmt.setString(2, costypeVO.getCosTypeIntro());
				pstmt.setInt(3, costypeVO.getCosTypeNo());

				pstmt.executeUpdate();

			} catch (SQLException se) {
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

		@Override
		public void delete(Integer cosTypeNo) {
			
			int updateCount_coutype = 0;

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();

				con.setAutoCommit(false);

				pstmt = con.prepareStatement(DELETE_coutype);
				pstmt.setInt(1, cosTypeNo);
				updateCount_coutype = pstmt.executeUpdate();

				con.commit();
				con.setAutoCommit(true);
				System.out.println("updateCount_coutype：" + cosTypeNo);

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

		@Override
		public CostypeVO findByPrimaryKeybyCostypeVO(Integer cosTypeNo) {

			CostypeVO costypeVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, cosTypeNo);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					costypeVO = new CostypeVO();
					costypeVO.setCosTypeNo(rs.getInt("cosTypeNo"));
					costypeVO.setCosTypeName(rs.getString("cosTypeName"));
					costypeVO.setCosTypeIntro(rs.getString("cosTypeIntro"));
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
			return costypeVO;
		}

		@Override
		public List<CostypeVO> getAll() {
			
			List<CostypeVO> list = new ArrayList<CostypeVO>();
			CostypeVO costypeVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					costypeVO = new CostypeVO();
					costypeVO.setCosTypeNo(rs.getInt("cosTypeNo"));
					costypeVO.setCosTypeName(rs.getString("cosTypeName"));
					costypeVO.setCosTypeIntro(rs.getString("cosTypeIntro"));
					list.add(costypeVO);
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
			return list;
		}

		@Override
		public Set<CosVO> findByPrimaryKeybyCosVO(Integer cosTypeNo) {
			Set<CosVO> set = new LinkedHashSet<CosVO>();
			CosVO cosVO = null;
		
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		
			try {
		
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_Cos_ByCosTypeNo_STMT);
				pstmt.setInt(1, cosTypeNo);
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
					set.add(cosVO); // Store the row in the vector
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
			return set;
		}
		
	}
	

