package com.coudet.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CosdetDAO implements CosdetDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_coudet_STMT = 
			"INSERT INTO coudet (cosNo, memNo, cosComment, cosDetailPrice) VALUES (?, ?, ?, ?)";
			
	private static final String GET_ALL_STMT = 
			"SELECT cosNo, memNo, cosComment, cosDetailPrice FROM coudet";
	private static final String GET_ONE_STMT = 
			"SELECT cosNo, memNo, cosComment, cosDetailPrice FROM coudet where cosNo = ?";
				
	private static final String DELETE_coudet = 
			"DELETE FROM coudet where cosNo = ?";	
				
	private static final String UPDATE_coudet = 
			"UPDATE coudet SET memNo =?, cosComment =?, cosDetailPrice = ? where cosNo = ?";

		@Override
		public void insert(CosdetVO cosdetVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_coudet_STMT);

				pstmt.setInt(1, cosdetVO.getCosNo());
				pstmt.setInt(2, cosdetVO.getMemNo());
				pstmt.setString(3, cosdetVO.getCosComment());
				pstmt.setInt(4, cosdetVO.getCosDetailPrice());

				pstmt.executeUpdate("set auto_increment_offset=3;");
				pstmt.executeUpdate("set auto_increment_increment=3;");
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
		public void update(CosdetVO cosdetVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_coudet);
				
				
				pstmt.setInt(1, cosdetVO.getMemNo());
				pstmt.setString(2, cosdetVO.getCosComment());
				pstmt.setInt(3, cosdetVO.getCosDetailPrice());
				pstmt.setInt(4, cosdetVO.getCosNo());

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
		public void delete(Integer cosNo) {
			
			int update_coudet = 0;

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();

				con.setAutoCommit(false);

				pstmt = con.prepareStatement(DELETE_coudet);
				pstmt.setInt(1, cosNo);
				update_coudet = pstmt.executeUpdate();

				con.commit();
				con.setAutoCommit(true);
				System.out.println("update_coudet：" + cosNo);

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
		public CosdetVO findByPrimaryKey(Integer cosNo) {

			CosdetVO cosdetVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, cosNo);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(rs.getInt("cosNo"));
					cosdetVO.setMemNo(rs.getInt("memNo"));
					cosdetVO.setCosComment(rs.getString("cosComment"));
					cosdetVO.setCosDetailPrice(rs.getInt("cosDetailPrice"));
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

		@Override
		public List<CosdetVO> getAll() {
			
			List<CosdetVO> list = new ArrayList<CosdetVO>();
			CosdetVO cosdetVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					cosdetVO = new CosdetVO();
					cosdetVO.setCosNo(rs.getInt("cosNo"));
					cosdetVO.setMemNo(rs.getInt("memNo"));
					cosdetVO.setCosComment(rs.getString("cosComment"));
					cosdetVO.setCosDetailPrice(rs.getInt("cosDetailPrice"));
					list.add(cosdetVO);
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

		
	}
	

