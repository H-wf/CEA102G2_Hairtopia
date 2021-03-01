package com.orderdetail.model;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class OrderDetailJDBCDAO implements OrderDetailDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/db01?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO OrderDetail (ordNo,proNo,ordDetAmt,ordDetPrice) VALUES (?,?,?,?)";
	private static final String UPDATE = 
			"UPDATE OrderDetail set ordDetAmt=?, ordDetPrice=? where ordNo=? and proNo=?";
	private static final String DELETE = 
			"DELETE FROM OrderDetail where ordNo=? and proNo=?";
	private static final String GET_ONE_STMT = 
			"SELECT ordNo,proNo,ordDetAmt,ordDetPrice FROM OrderDetail where ordNo=? and proNo=?";
	private static final String GET_ALL_STMT = 
			"SELECT ordNo,proNo,ordDetAmt,ordDetPrice FROM OrderDetail order by ordNo";
	
	@Override
	public void insert(OrderDetailVO orddVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, orddVO.getOrdNo());
			pstmt.setInt(2, orddVO.getProNo());
			pstmt.setInt(3, orddVO.getOrdDetAmt());
			pstmt.setInt(4, orddVO.getOrdDetPrice());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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

	@Override
	public void update(OrderDetailVO orddVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			

			pstmt.setInt(1, orddVO.getOrdDetAmt());
			pstmt.setInt(2, orddVO.getOrdDetPrice());
			pstmt.setInt(3, orddVO.getOrdNo());
			pstmt.setInt(4, orddVO.getProNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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

	@Override
	public void delete(Integer ordNo, Integer proNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, ordNo);
			pstmt.setInt(2, proNo);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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

	@Override
	public OrderDetailVO findByPrimaryKey(Integer ordNo, Integer proNo) {
		OrderDetailVO orddVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ordNo);
			pstmt.setInt(2, proNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orddVO = new OrderDetailVO();
				orddVO.setOrdNo(rs.getInt("ordNo"));
				orddVO.setProNo(rs.getInt("proNo"));
				orddVO.setOrdDetAmt(rs.getInt("ordDetAmt"));
				orddVO.setOrdDetPrice(rs.getInt("ordDetPrice"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		return orddVO;
	}

	@Override
	public List<OrderDetailVO> getAll() {
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orddVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orddVO = new OrderDetailVO();
				orddVO.setOrdNo(rs.getInt("ordNo"));
				orddVO.setProNo(rs.getInt("proNo"));
				orddVO.setOrdDetAmt(rs.getInt("ordDetAmt"));
				orddVO.setOrdDetPrice(rs.getInt("ordDetPrice"));
				list.add(orddVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		return list;
	
	}

	@Override
	public void insert2(OrderDetailVO orderdetailVO, Connection con) {
		PreparedStatement pstmt = null;

		try {

     		pstmt = con.prepareStatement(INSERT_STMT);
     		
     		pstmt.setInt(1, orderdetailVO.getOrdNo());
			pstmt.setInt(2, orderdetailVO.getProNo());
			pstmt.setInt(3, orderdetailVO.getOrdDetAmt());
			pstmt.setInt(4, orderdetailVO.getOrdDetPrice());
			
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-orderdetail");
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
		}
		
	}

	@Override
	public List<OrderDetailVO> getAll(Map<String, String[]> map) {
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderdetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);	
			String SQL = "select od.ordNo, od.proNo, ordDetAmt, ordDetPrice from orderdetail od " 										
				    	+"join ordermaster om on od.ordNo = om.ordNo "
				    	+"join product p on od.proNo = p.proNo ";
			Set<String> keys = map.keySet();
			int count = 0;
			for(String key : keys) {
				String value = map.get(key)[0];
				System.out.println(value);
				if (!"".equals(value) && !"action".equals(key)) {
					if(count==0) {
						SQL += "where ";
						count++;
					}else {
						SQL +="and ";
					}
					if(key.equals("search")){
						SQL +=  "concat(od.ordNo,proName,ordDetAmt,ordDetPrice) like "+ "'%"+value+"%' ";								
					}else {
						SQL += ("od." + key + "=" + value + " ");
					}					
				}
				
			}			
			SQL += "order by ordNo;";
			System.out.println(SQL);
			pstmt = con.prepareStatement(SQL);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderdetailVO = new OrderDetailVO();
				orderdetailVO.setOrdNo(rs.getInt("ordNo"));
				orderdetailVO.setProNo(rs.getInt("proNo"));
				orderdetailVO.setOrdDetAmt(rs.getInt("ordDetAmt"));
				orderdetailVO.setOrdDetPrice(rs.getInt("ordDetPrice"));
				list.add(orderdetailVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		return list;
	}

	
}
