package com.ptype.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.product.model.ProductVO;


public class PtypeDAO implements PtypeDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {			
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT= 
			"INSERT INTO PTYPE (PTYPENAME) VALUE (?)";
	private static final String UPDATE_STMT=
			"UPDATE PTYPE SET PTYPENAME=? WHERE PTYPENO=?";
	private static final String DELETE_STMT=
			"DELETE FROM PTYPE WHERE PTYPENO=?";
	private static final String GET_ONE_STMT=
			"SELECT PTYPENO,PTYPENAME FROM PTYPE WHERE PTYPENO=?";
	private static final String GET_ALL_STMT=
			"SELECT PTYPENO,PTYPENAME FROM PTYPE ORDER BY PTYPENO";
	private static final String GET_Products_ByPtypeNo_STMT=
			"SELECT proNo,ptypeNo,braNo,proName,proStatus,proPrice,proMpic,proPic,proDesc FROM PRODUCT WHERE PTYPENO=?";
	@Override
	public void insert(PtypeVO ptypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, ptypeVO.getPtypeName());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(PtypeVO ptypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, ptypeVO.getPtypeName());
			pstmt.setInt(2, ptypeVO.getPtypeNo());
			
			pstmt.executeUpdate();
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void delete(Integer ptypeNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);
						
			pstmt.setInt(1, ptypeNo);
			
			pstmt.executeUpdate();
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public PtypeVO findByPrimaryKey(Integer ptypeNo) {
		PtypeVO ptypeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, ptypeNo);
						
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ptypeVO = new PtypeVO();
				ptypeVO.setPtypeNo(rs.getInt("PTYPENO"));
				ptypeVO.setPtypeName(rs.getString("PTYPENAME"));
			}
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		return ptypeVO;
	}

	@Override
	public List<PtypeVO> getAll() {
		List<PtypeVO> list = new ArrayList<PtypeVO>();
		PtypeVO ptypeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			
							
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ptypeVO = new PtypeVO();
				ptypeVO.setPtypeNo(rs.getInt("PTYPENO"));
				ptypeVO.setPtypeName(rs.getString("PTYPENAME"));
				list.add(ptypeVO);
			}
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public Set<ProductVO> getProductsByPtypeNo(Integer ptypeNo) {
		Set<ProductVO> set = new LinkedHashSet<ProductVO>();
		ProductVO productVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Products_ByPtypeNo_STMT);
			pstmt.setInt(1, ptypeNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				productVO = new ProductVO();
				productVO.setProNo(rs.getInt("proNO"));
				productVO.setPtypeNo(rs.getInt("ptypeNo"));
				productVO.setBraNo(rs.getInt("braNo"));
				productVO.setProName(rs.getString("proName"));
				productVO.setProStatus(rs.getBoolean("proStatus"));
				productVO.setProPrice(rs.getInt("proPrice"));
				productVO.setProMpic(rs.getBytes("proMpic"));
				productVO.setProPic(rs.getBytes("proPic"));
				productVO.setProDesc(rs.getString("proDesc"));
				
				set.add(productVO); // Store the row in the vector
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
