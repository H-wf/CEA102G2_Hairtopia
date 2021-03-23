package com.ordermaster.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
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
import com.orderdetail.model.OrderDetailVO;




public class OrderMasterDAO implements OrderMasterDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {			
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT =
			"INSERT INTO OrderMaster (memNo,ordStatus,ordAmt,ordName,ordEmail,ordPhone,ordAddr) VALUES (?,?,?,?,?,?,?)";
	private static final String UPDATE = 
			"UPDATE OrderMaster set memNo=?, ordStatus=?, ordAmt=? where ordNo = ?";
	private static final String DELETE = 
			"DELETE FROM OrderMaster where ordNo = ?";
	private static final String GET_ONE_STMT = 
			"SELECT ordNo,memNo,ordDate,ordStatus,ordAmt,ordName,ordEmail,ordPhone,ordAddr FROM OrderMaster where ordNo = ?";
	private static final String GET_ALL_STMT = 
			"SELECT ordNo,memNo,ordDate,ordStatus,ordAmt,ordName,ordEmail,ordPhone,ordAddr FROM OrderMaster order by ordNo";
//	private static final String GET_ALL_ByMemNo_STMT = 
//			"SELECT ordNo,memNo,ordDate,ordStatus,ordAmt FROM OrderMaster where memNo=? order by ordNo";
	@Override
	public void insert(OrderMasterVO ordmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, ordmVO.getMemNo());
			pstmt.setInt(2, ordmVO.getOrdStatus());
			pstmt.setInt(2, ordmVO.getOrdAmt());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {			
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}			
			}
			if(con != null) {												
				try {
					con.close();
				} catch (SQLException e) {					
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, ordmVO.getMemNo());
			pstmt.setInt(2, ordmVO.getOrdStatus());
			pstmt.setInt(3, ordmVO.getOrdAmt());
			pstmt.setInt(4, ordmVO.getOrdNo());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {			
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}			
			}
			if(con != null) {												
				try {
					con.close();
				} catch (SQLException e) {					
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, ordNo);
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {			
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}			
			}
			if(con != null) {												
				try {
					con.close();
				} catch (SQLException e) {					
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ordNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ordmVO = new OrderMasterVO();
				ordmVO.setOrdNo(rs.getInt("ordNo"));
				ordmVO.setMemNo(rs.getInt("memNo"));
				ordmVO.setOrdDate(rs.getTimestamp("ordDate"));
				ordmVO.setOrdStatus(rs.getInt("ordStatus"));
				ordmVO.setOrdAmt(rs.getInt("ordAmt"));
				ordmVO.setOrdName(rs.getString("ordName"));
				ordmVO.setOrdEmail(rs.getString("ordEmail"));
				ordmVO.setOrdPhone(rs.getString("ordPhone"));
				ordmVO.setOrdAddr(rs.getString("ordAddr"));
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally{
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ordmVO = new OrderMasterVO();
				ordmVO.setOrdNo(rs.getInt("ordNo"));
				ordmVO.setMemNo(rs.getInt("memNo"));
				ordmVO.setOrdDate(rs.getTimestamp("ordDate"));
				ordmVO.setOrdStatus(rs.getInt("ordStatus"));
				ordmVO.setOrdAmt(rs.getInt("ordAmt"));
				ordmVO.setOrdName(rs.getString("ordName"));
				ordmVO.setOrdEmail(rs.getString("ordEmail"));
				ordmVO.setOrdPhone(rs.getString("ordPhone"));
				ordmVO.setOrdAddr(rs.getString("ordAddr"));
				list.add(ordmVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally{
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public List<OrderMasterVO> getAll(Map<String, String[]> map) {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO ordermasterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();			
			String SQL = "select om.ordNo, om.memNo, ordDate, ordStatus, ordAmt, ordName, ordEmail, ordPhone, ordAddr from ordermaster om " 										
				    	+"join member m on om.memNo = m.memNo ";
			Set<String> keys = map.keySet();
			int count = 0;
			for(String key : keys) {
				String value = map.get(key)[0];
				System.out.print(key+":");
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
				ordermasterVO.setOrdName(rs.getString("ordName"));
				ordermasterVO.setOrdEmail(rs.getString("ordEmail"));
				ordermasterVO.setOrdPhone(rs.getString("ordPhone"));
				ordermasterVO.setOrdAddr(rs.getString("ordAddr"));
				list.add(ordermasterVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally{
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public OrderMasterVO insertWithOrderDetails(OrderMasterVO ordermasterVO, List<OrderDetailVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
			
    		// 先新增訂單
			String cols[] = {"ordNo"};
			pstmt = con.prepareStatement(INSERT_STMT , cols);			
			pstmt.setInt(1, ordermasterVO.getMemNo());
			pstmt.setInt(2, 0);
			pstmt.setInt(3, ordermasterVO.getOrdAmt());
			pstmt.setString(4, ordermasterVO.getOrdName());
			pstmt.setString(5, ordermasterVO.getOrdEmail());
			pstmt.setString(6, ordermasterVO.getOrdPhone());
			pstmt.setString(7, ordermasterVO.getOrdAddr());
			
			pstmt.executeUpdate();
			//掘取對應的自增主鍵值
			String next_ordNo = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_ordNo = rs.getString(1);
				System.out.println("自增主鍵值= " + next_ordNo +"(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			
			rs.close();
			// 再同時新增訂單明細
			OrderDetailDAO dao = new OrderDetailDAO();
			
			for(int i = 0; i < list.size(); i++) {
				OrderDetailVO orderdetailVO = list.get(i);
				orderdetailVO.setOrdNo(new Integer(next_ordNo)) ;
				dao.insert2(orderdetailVO,con);
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

//	@Override
//	public List<OrderMasterVO> getAllByMemNo(Integer memNo) {
//		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
//		OrderMasterVO ordmVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ALL_ByMemNo_STMT);			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				ordmVO = new OrderMasterVO();
//				ordmVO.setOrdNo(rs.getInt("ordNo"));
//				ordmVO.setMemNo(rs.getInt("memNo"));
//				ordmVO.setOrdDate(rs.getTimestamp("ordDate"));
//				ordmVO.setOrdStatus(rs.getInt("ordStatus"));
//				ordmVO.setOrdAmt(rs.getInt("ordAmt"));
//				list.add(ordmVO);
//			}
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured." + se.getMessage());
//		}finally{
//			if(rs != null) {
//				try {
//					rs.close();
//				}catch(SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if(pstmt != null) {
//				try {
//					pstmt.close();
//				}catch(SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if(con != null) {
//				try {
//					con.close();
//				}catch(SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
//	}

}
