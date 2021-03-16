package com.salon.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.designer.model.*;

public class SalonDAO implements SalonDAO_interface{
	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO salon (salName,salAdd,salTime,salPhone,salStatus) VALUES (?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT salNo,salName,salAdd,salTime,salPhone,salStatus FROM salon order by salNo";
		private static final String GET_ONE_STMT = 
			"SELECT salNo,salName,salAdd,salTime,salPhone,salStatus FROM salon where salNo = ?";
		private static final String DELETE = 
			"DELETE FROM salon where salNo = ?";
		private static final String UPDATE = 
			"UPDATE salon set salName=?, salAdd=?, salTime=?, salPhone=?, salStatus=? where salNo = ?";
		private static final String GET_SAL_NAME =	"SELECT salName from hairtopia.salon where salName like ?;";
		private static final String GET_SAL_NAME_BY_Ajax =
				"SELECT salNo,salName,salAdd,salTime,salPhone from salon where salName = ? ";	
//		private static final String GET_SAL_SEARCH =
//				"SELECT salNo,salName,salAdd,salTime,salPhone,salLat,salLng from salon where salName like ? ";	
		private static final String GET_SAL_SEARCH =
				"SELECT salNo,salName,salAdd,salTime,salPhone,salStatus from salon where salName like ? ";	
	
	@Override
	public void insert(SalonVO salonVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, salonVO.getSalName());
			pstmt.setString(2, salonVO.getSalAdd());
			pstmt.setString(3, salonVO.getSalTime());
			pstmt.setString(4, salonVO.getSalPhone());
			pstmt.setInt(5, salonVO.getSalStatus());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "//丟出RuntimeException才不會有繼承限制
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

	@Override
	public void update(SalonVO salonVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, salonVO.getSalName());
			pstmt.setString(2, salonVO.getSalAdd());
			pstmt.setString(3, salonVO.getSalTime());
			pstmt.setString(4, salonVO.getSalPhone());
			pstmt.setInt(5, salonVO.getSalStatus());
			pstmt.setInt(6, salonVO.getSalNo());

			pstmt.executeUpdate();

			// Handle any driver errors
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

	@Override
	public void delete(Integer salNo) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, salNo);

			pstmt.executeUpdate();

			// Handle any driver errors
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

	@Override
	public SalonVO findByPrimaryKey(Integer salNo) {

		SalonVO salonVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, salNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVo 也稱為 Domain objects
				salonVO = new SalonVO();
				salonVO.setSalNo(rs.getInt("salNo"));
				salonVO.setSalName(rs.getString("salName"));
				salonVO.setSalAdd(rs.getString("salAdd"));
				salonVO.setSalTime(rs.getString("salTime"));
				salonVO.setSalPhone(rs.getString("salPhone"));
				salonVO.setSalStatus(rs.getInt("salStatus"));
			}

			// Handle any driver errors
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
		
		return salonVO;
	}

	@Override
	public List<SalonVO> getAll() {

		List<SalonVO> list = new ArrayList<SalonVO>();
		SalonVO salonVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVO 也稱為 Domain objects
				salonVO = new SalonVO();
				salonVO.setSalNo(rs.getInt("salNo"));
				salonVO.setSalName(rs.getString("salName"));
				salonVO.setSalAdd(rs.getString("salAdd"));
				salonVO.setSalTime(rs.getString("salTime"));
				salonVO.setSalPhone(rs.getString("salPhone"));
				salonVO.setSalStatus(rs.getInt("salStatus"));
				list.add(salonVO); // Store the row in the list
			}

			// Handle any driver errors
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
		
		return list;
	}
	
	@Override
	public List<String> getSalAJAX(String keyword) {
		List<String> ajaxList = new ArrayList<String>();
		String salName = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SAL_NAME);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// salonVO 也稱為 Domain objects
				salName = rs.getString("salName");
				ajaxList.add(salName); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured In method named 'getTagAJAX'. "
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
		
		return ajaxList;
	}
	
	@Override
	public void insertWithDes(SalonVO salonVO, List<DesignerVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			// 1●設定於 pstm.executeUpdate()之前
			con.setAutoCommit(false);
			
    		// 先新增部門
			String cols[] = {"salNo"};

			pstmt = con.prepareStatement(INSERT_STMT , cols);			
			pstmt.setString(1, salonVO.getSalName());
			pstmt.setString(2, salonVO.getSalAdd());
			pstmt.setString(3, salonVO.getSalTime());
			pstmt.setString(4, salonVO.getSalPhone());
			pstmt.setInt(5, salonVO.getSalStatus());
			pstmt.setString(6, salonVO.getSalLat());
			pstmt.setString(7, salonVO.getSalLng());
			pstmt.executeUpdate();

			
			//掘取對應的自增主鍵值
			String next_salNo = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_salNo = rs.getString(1);
				System.out.println("自增主鍵值= " + next_salNo +"(剛新增成功的髮廊編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			// 再同時
			DesignerService dao = new DesignerService();
			System.out.println("list.size()-A="+list.size());
			for (DesignerVO aDes : list) {
				aDes.setSalNo(new Integer(next_salNo)) ;
				dao.addDesigner(aDes,con);

	
			}

			// 2●設定於 pstm.executeUpdate()之後

			con.commit();
			con.setAutoCommit(true);
		
			
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-des");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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

	@Override
	public List<SalonVO> getAllByAjax(String keyword) {

		List<SalonVO> ajaxList = new ArrayList<SalonVO>();
		SalonVO salonVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SAL_NAME);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVO 也稱為 Domain objects
			
				salonVO = new SalonVO();
				salonVO.setSalName(rs.getString("salName"));
				ajaxList.add(salonVO); // Store the row in the list
			}

			// Handle any driver errors
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
		
		return ajaxList;
	}
	
	public SalonVO findBySalName(String salName) {

		SalonVO salonVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SAL_NAME_BY_Ajax);

			pstmt.setString(1, salName);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVo 也稱為 Domain objects
				salonVO = new SalonVO();
				salonVO.setSalNo(rs.getInt("salNo"));
				salonVO.setSalName(rs.getString("salName"));
				salonVO.setSalAdd(rs.getString("salAdd"));
				salonVO.setSalTime(rs.getString("salTime"));
				salonVO.setSalPhone(rs.getString("salPhone"));
			
			}

			// Handle any driver errors
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
		
		return salonVO;
	}
	
	@Override
	public List<SalonVO> getAllSearch(String keyword) {

		List<SalonVO> salList = new ArrayList<SalonVO>();
		SalonVO salonVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SAL_SEARCH);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVO 也稱為 Domain objects
			
				salonVO = new SalonVO();
				salonVO.setSalNo(rs.getInt("salNo"));
				salonVO.setSalName(rs.getString("salName"));
				salonVO.setSalAdd(rs.getString("salAdd"));
				salonVO.setSalTime(rs.getString("salTime"));
				salonVO.setSalPhone(rs.getString("salPhone"));
//				salonVO.setSalStatus(rs.getInt("salStatus"));
//				salonVO.setSalLat(rs.getString("salLat"));
//				salonVO.setSalLng(rs.getString("salLng"));
				
				salList.add(salonVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured in method named 'getAllSearch'. "
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
		
		return salList;
	}
	
	

}
