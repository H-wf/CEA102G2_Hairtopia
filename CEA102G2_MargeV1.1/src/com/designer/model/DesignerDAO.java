package com.designer.model;

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

import com.designer.model.DesignerVO;


public class DesignerDAO implements DesignerDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
//新增
		//前台申請設計師資格 
	    private static final String INSERT_STMT = 
			"INSERT INTO designer (memNo, salNo, desName, desInfor, desSchedule, desPic) VALUES (?, ?, ?, ?, ?, ?)";
//查詢
	    //後台用來表列設計師清單 ,前台可能可以使用瀏覽所有設計師也可以使用
		private static final String GET_ALL_STMT = 
			"SELECT desNo, memNo, salNo, desName, desInfor, desEndDate, desCount, desTolScore, desStatus, desSchedule,"
			      +"desPic FROM designer order by desNo";
		
		//使用會員編號尋找是否有已申請過設計師
		private static final String GET_ONE_STMT = 
			"SELECT desNo, memNo, salNo, desName, desInfor, desEndDate, desCount, desTolScore, desStatus, desSchedule,"
				  +"desPic FROM designer where memNo = ?";
		
		//前台查看設計師個人頁面可顯示資料 
		private static final String GET_ONE_STMT_des = 
			"SELECT desNo, memNo, salNo, desName, desInfor, desEndDate, desCount, desTolScore, desStatus, desSchedule,"
	              +"desPic FROM designer where desNo = ?";
//刪除
		//僅後台檢查指令使用  上線時期不使用
		private static final String DELETE = 
			"DELETE FROM designer where desNo = ?";

//修改
		//一般修改
		private static final String UPDATE = 
				"UPDATE designer set salNo=?, desName=?, desInfor=?, desSchedule=?, desPic=? where desNo = ?";
		//修改預設上班日與修改資訊但未修改圖片
		private static final String UPDATE_WITHOUT_PIC = 
				"UPDATE designer set salNo=?, desName=?, desInfor=?, desSchedule=? where desNo = ?";
		//用於設計師前台申請後，後台人員用來驗證資訊與檢舉後停權處理
		private static final String UPDATE_DES_STATUS = 
			"UPDATE designer set desEndDate=?, desStatus=? where desNo=?";
		private static final String GET_DES_NAME =	"SELECT desName from designer where desName like ?;";
		private static final String GET_DES_SEARCH = "SELECT salNo, desName, desInfor, desCount, desTolScore,desSchedule,"
		              +"desPic FROM designer where desName like ?;";
	
	public void insert(DesignerVO designerVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, designerVO.getMemNo());
			pstmt.setInt(2, designerVO.getSalNo());
			pstmt.setString(3, designerVO.getDesName());			
			pstmt.setString(4, designerVO.getDesInfor());
			pstmt.setString(5, designerVO.getDesSchedule());
			pstmt.setBytes(6, designerVO.getDesPic());
			
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
	
public void insert2(DesignerVO designerVO,Connection con) {
		
		
		PreparedStatement pstmt = null;

		try {

			
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, designerVO.getMemNo());
			pstmt.setInt(2, designerVO.getSalNo());
			


			pstmt.setString(3, designerVO.getDesName());			
			pstmt.setString(4, designerVO.getDesInfor());
			pstmt.setString(5, designerVO.getDesSchedule());
			pstmt.setBytes(6, designerVO.getDesPic());
			
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {

			if (con != null) {
				try {
				
					System.err.println("rolled back-由-Des");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured..... "
							+ excep.getMessage());
				}
			}
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
		}
		
	
	}
	
	public void update(DesignerVO designerVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, designerVO.getSalNo());
			pstmt.setString(2, designerVO.getDesName());
			pstmt.setString(3, designerVO.getDesInfor());
			pstmt.setString(4, designerVO.getDesSchedule());
			pstmt.setBytes(5, designerVO.getDesPic());
			pstmt.setInt(6, designerVO.getDesNo());

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
	};
	//此方法使用於 修改預設上班日期 與 修改但未更新照片
	public void updateWithoutPic(DesignerVO designerVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_WITHOUT_PIC);
			
			pstmt.setInt(1, designerVO.getSalNo());
			pstmt.setString(2, designerVO.getDesName());
			pstmt.setString(3, designerVO.getDesInfor());
			pstmt.setString(4, designerVO.getDesSchedule());
			pstmt.setInt(5, designerVO.getDesNo());
			
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
	};
	
	public void updateOneStatus(DesignerVO designerVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_DES_STATUS);

			pstmt.setDate(1, designerVO.getDesEndDate());
			pstmt.setInt(2, designerVO.getDesStatus());
			pstmt.setInt(3, designerVO.getDesNo());
			
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
		
	};
	public void delete(Integer desNo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, desNo);

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
	
	public DesignerVO findByMemNo(Integer memNo) {
		
		DesignerVO designerVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, memNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				designerVO = new DesignerVO();
				designerVO.setDesNo(rs.getInt("desNo"));
				designerVO.setMemNo(rs.getInt("memNo"));
				designerVO.setSalNo(rs.getInt("salNo"));
				designerVO.setDesName(rs.getString("desName"));
				designerVO.setDesInfor(rs.getString("desInfor"));
				designerVO.setDesEndDate(rs.getDate("desEndDate"));
				designerVO.setDesCount(rs.getInt("desCount"));
				designerVO.setDesTolScore(rs.getInt("desTolScore"));
				designerVO.setDesStatus(rs.getInt("desStatus"));
				designerVO.setDesSchedule(rs.getString("desSchedule"));
				designerVO.setDesPic(rs.getBytes("desPic"));
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
		return designerVO;
	}
	
	@Override
	public List<DesignerVO> getAll() {
		// TODO Auto-generated method stub
		
		List<DesignerVO> list = new ArrayList<DesignerVO>();
		DesignerVO designerVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// designerVO 也稱為 Domain objects
				designerVO = new DesignerVO();
				designerVO.setDesNo(rs.getInt("desNo"));
				designerVO.setMemNo(rs.getInt("memNo"));
				designerVO.setSalNo(rs.getInt("salNo"));
				designerVO.setDesName(rs.getString("desName"));
				designerVO.setDesInfor(rs.getString("desInfor"));
				designerVO.setDesEndDate(rs.getDate("desEndDate"));
				designerVO.setDesCount(rs.getInt("desCount"));
				designerVO.setDesTolScore(rs.getInt("desTolScore"));
				designerVO.setDesStatus(rs.getInt("desStatus"));
				designerVO.setDesSchedule(rs.getString("desSchedule"));
				designerVO.setDesPic(rs.getBytes("desPic"));
				list.add(designerVO); // Store the row in the list
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
	public DesignerVO findByDesNo(Integer desNo) {
		// TODO Auto-generated method stub
		DesignerVO designerVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_des);

			pstmt.setInt(1, desNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				designerVO = new DesignerVO();
				designerVO.setDesNo(rs.getInt("desNo"));
				designerVO.setMemNo(rs.getInt("memNo"));
				designerVO.setSalNo(rs.getInt("salNo"));
				designerVO.setDesName(rs.getString("desName"));
				designerVO.setDesInfor(rs.getString("desInfor"));
				designerVO.setDesEndDate(rs.getDate("desEndDate"));
				designerVO.setDesCount(rs.getInt("desCount"));
				designerVO.setDesTolScore(rs.getInt("desTolScore"));
				designerVO.setDesStatus(rs.getInt("desStatus"));
				designerVO.setDesSchedule(rs.getString("desSchedule"));
				
				designerVO.setDesPic(rs.getBytes("desPic"));
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
		return designerVO;
	}
	

	@Override
	public List<String> getNameByAJAX(String keyword) {
		
		List<String> ajaxList = new ArrayList<String>();
		String desName = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_DES_NAME);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// salonVO 也稱為 Domain objects
			
				desName = rs.getString("desName");
				ajaxList.add(desName); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured In method named 'getNameByAJAX'. "
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
	
	public List<DesignerVO> searchDes(String keyword){
		
		List<DesignerVO> desList = new ArrayList<DesignerVO>();
		DesignerVO designerVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_DES_SEARCH);

			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				designerVO = new DesignerVO();
				designerVO.setSalNo(rs.getInt("salNo"));
				designerVO.setDesName(rs.getString("desName"));
				designerVO.setDesInfor(rs.getString("desInfor"));
				designerVO.setDesCount(rs.getInt("desCount"));
				designerVO.setDesTolScore(rs.getInt("desTolScore"));
				designerVO.setDesSchedule(rs.getString("desSchedule"));
				
				designerVO.setDesPic(rs.getBytes("desPic"));
				
				desList.add(designerVO);
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
		return desList;
	}
}
