package com.ordermaster.model;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.orderdetail.model.OrderDetailDAO;
import com.orderdetail.model.OrderDetailJDBCDAO;
import com.orderdetail.model.OrderDetailService;
import com.orderdetail.model.OrderDetailVO;


public class OrderMasterJDBCDAO implements OrderMasterDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO OrderMaster (memNo,ordStatus,ordAmt) VALUES (?,?,?)";
	private static final String UPDATE = 
			"UPDATE OrderMaster set memNo=?, ordStatus=?, ordAmt=? where ordNo = ?";
	private static final String DELETE = 
			"DELETE FROM OrderMaster where ordNo = ?";
	private static final String GET_ONE_STMT = 
			"SELECT ordNo,memNo,ordStatus,ordAmt FROM OrderMaster where ordNo = ?";
	private static final String GET_ALL_STMT = 
			"SELECT ordNo,memNo,ordStatus,ordAmt FROM OrderMaster order by ordNo";
	@Override
	public void insert(OrderMasterVO ordermasterVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, ordermasterVO.getMemNo());
			pstmt.setInt(2, ordermasterVO.getOrdStatus());
			pstmt.setInt(3, ordermasterVO.getOrdAmt());
			
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
	public void update(OrderMasterVO ordmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, ordmVO.getMemNo());
			pstmt.setInt(2, ordmVO.getOrdStatus());
			pstmt.setInt(3, ordmVO.getOrdAmt());
			pstmt.setInt(4, ordmVO.getOrdNo());
			
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
	public void delete(Integer ordNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, ordNo);
			
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
	public OrderMasterVO findByPrimaryKey(Integer ordNo) {
		OrderMasterVO ordmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ordNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ordmVO = new OrderMasterVO();
				ordmVO.setOrdNo(rs.getInt("ordNo"));
				ordmVO.setMemNo(rs.getInt("memNo"));
				ordmVO.setOrdStatus(rs.getInt("ordStatus"));
				ordmVO.setOrdAmt(rs.getInt("ordAmt"));
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
		return ordmVO;
	}

	@Override
	public List<OrderMasterVO> getAll() {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO ordmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ordmVO = new OrderMasterVO();
				ordmVO.setOrdNo(rs.getInt("ordNo"));
				ordmVO.setMemNo(rs.getInt("memNo"));
				ordmVO.setOrdStatus(rs.getInt("ordStatus"));
				ordmVO.setOrdAmt(rs.getInt("ordAmt"));
				list.add(ordmVO);
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

	
	public OrderMasterVO insertWithOrderDetails(OrderMasterVO ordermasterVO, List<OrderDetailVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
			
    		// 先新增訂單
			String cols[] = {"ordNo"};
			pstmt = con.prepareStatement(INSERT_STMT , cols);			
			pstmt.setInt(1, ordermasterVO.getMemNo());
			pstmt.setInt(2, ordermasterVO.getOrdStatus());
			pstmt.setInt(3, ordermasterVO.getOrdAmt());
			
			pstmt.executeUpdate();
			//掘取對應的自增主鍵值
			String next_ordNo = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_ordNo = rs.getString(1);
				System.out.println("自增主鍵值= " + next_ordNo +"(剛新增成功的部門編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			// 再同時新增訂單明細
			OrderDetailJDBCDAO dao = new OrderDetailJDBCDAO();
			System.out.println("list.size()-A="+list.size());
			for (OrderDetailVO aOrderDetail : list) {
				aOrderDetail.setOrdNo(new Integer(next_ordNo)) ;
				dao.insert2(aOrderDetail,con);
			}

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-B="+list.size());
			System.out.println("新增訂單編號" + next_ordNo + "時,共有訂單明細" + list.size()
					+ "筆同時被新增");
			
			OrderMasterService ordermasterSvc = new OrderMasterService();
			ordermasterVO = ordermasterSvc.getOneOrderMaster(new Integer(next_ordNo));
			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-ordermaster");
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
		return ordermasterVO;
	}
	
//	public static void main(String[] args) {
//
//		OrderMasterJDBCDAO dao = new OrderMasterJDBCDAO();
//
//		OrderMasterVO ordermasterVO = new OrderMasterVO();
//		ordermasterVO.setMemNo(1);
//		ordermasterVO.setOrdStatus(1);
//		ordermasterVO.setOrdAmt(900);
//		
//		Vector<OrderDetailVO> testVector = new Vector<OrderDetailVO>(); // 準備置入訂單明細
//		
//		OrderDetailVO first = new OrderDetailVO();   // 訂單1
//		first.setProNo(1);
//		first.setOrdDetAmt(1);
//		first.setOrdDetPrice(500);
//				
//		OrderDetailVO second = new OrderDetailVO();    // 訂單2
//		second.setProNo(2);
//		second.setOrdDetAmt(1);
//		second.setOrdDetPrice(400);
//
//		testVector.add(first);
//		testVector.add(second);
//		
//		dao.insertWithOrderDetails(ordermasterVO , testVector);
		
		// 新增
//		DeptVO deptVO1 = new DeptVO();
//		deptVO1.setDname("製造部");
//		deptVO1.setLoc("中國江西");
//		dao.insert(deptVO1);

		// 修改
//		DeptVO deptVO2 = new DeptVO();
//		deptVO2.setDeptno(10);
//		deptVO2.setDname("財務部2");
//		deptVO2.setLoc("臺灣台北2");
//		dao.update(deptVO2);

		// 刪除
//		dao.delete(30);

		// 查詢
//		DeptVO deptVO3 = dao.findByPrimaryKey(10);
//		System.out.print(deptVO3.getDeptno() + ",");
//		System.out.print(deptVO3.getDname() + ",");
//		System.out.println(deptVO3.getLoc());
//		System.out.println("---------------------");

		// 查詢部門
//		List<DeptVO> list = dao.getAll();
//		for (DeptVO aDept : list) {
//			System.out.print(aDept.getDeptno() + ",");
//			System.out.print(aDept.getDname() + ",");
//			System.out.print(aDept.getLoc());
//			System.out.println();
//		}
		
		// 查詢某部門的員工
//		Set<EmpVO> set = dao.getEmpsByDeptno(10);
//		for (EmpVO aEmp : set) {
//			System.out.print(aEmp.getEmpno() + ",");
//			System.out.print(aEmp.getEname() + ",");
//			System.out.print(aEmp.getJob() + ",");
//			System.out.print(aEmp.getHiredate() + ",");
//			System.out.print(aEmp.getSal() + ",");
//			System.out.print(aEmp.getComm() + ",");
//			System.out.print(aEmp.getDeptno());
//			System.out.println();
//		}
//	}

	@Override
	public List<OrderMasterVO> getAll(Map<String, String[]> map) {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO ordermasterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String SQL = "select om.ordNo, om.memNo, ordDate, ordStatus, ordAmt from ordermaster om " 										
				    	+"join member m on om.memNo = m.memNo ";
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
						SQL +=  "concat(om.ordNo,om.memNo,memName,ordStatus,ordAmt) like "+ "'%"+value+"%' ";								
					}else {
						SQL += ("om." + key + "=" + value + " ");
					}					
				}
				
			}			
			SQL += "order by ordNo;";
			System.out.println(SQL);
			pstmt = con.prepareStatement(SQL);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ordermasterVO = new OrderMasterVO();
				ordermasterVO.setOrdNo(rs.getInt("ordNo"));
				ordermasterVO.setMemNo(rs.getInt("memNo"));
				ordermasterVO.setOrdDate(rs.getTimestamp("ordDate"));
				ordermasterVO.setOrdStatus(rs.getInt("ordStatus"));
				ordermasterVO.setOrdAmt(rs.getInt("ordAmt"));
				list.add(ordermasterVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-ordermaster");
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
		return list;
	}

}
