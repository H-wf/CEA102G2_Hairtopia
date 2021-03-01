package com.brand.model;

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

public class BrandDAO implements BrandDAO_interface{
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
			"INSERT INTO brand (BRANAME,BRALOGO,BRAINTRO) VALUES (?,?,?)";
	private static final String UPDATE_STMT = 
			"UPDATE brand set BRANAME=?, BRALOGO=?, BRAINTRO=? where BRANO = ?";
	private static final String DELETE_STMT = 
			"DELETE FROM brand where BRANO = ?";
	private static final String GET_ONE_STMT = 
			"SELECT BRANO,BRANAME,BRALOGO,BRAINTRO FROM brand where BRANO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT BRANO,BRANAME,BRALOGO,BRAINTRO FROM brand order by BRANO";
	private static final String GET_Products_ByBraNo_STMT = 
			"SELECT proNo,ptypeNo,braNo,proName,proStatus,proPrice,proMpic,proPic,proDesc FROM PRODUCT WHERE braNo=?";
	@Override
	public void insert(BrandVO brandVO) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, brandVO.getBraName());
			pstmt.setBytes(2, brandVO.getBraLogo());
			pstmt.setString(3, brandVO.getBraIntro());
			
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
	public void update(BrandVO brandVO) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, brandVO.getBraName());
			pstmt.setBytes(2, brandVO.getBraLogo());
			pstmt.setString(3, brandVO.getBraIntro());
			pstmt.setInt(4, brandVO.getBraNo());
			
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
	public void delete(Integer braNo) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setInt(1, braNo);
			
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
	public BrandVO findByPrimaryKey(Integer braNo) {		
		BrandVO brandVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, braNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				brandVO = new BrandVO();
				brandVO.setBraNo(rs.getInt("BRANO"));
				brandVO.setBraName(rs.getString("BRANAME"));
				brandVO.setBraLogo(rs.getBytes("BRALOGO"));
				brandVO.setBraIntro(rs.getString("BRAINTRO"));
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
		return brandVO;
	}
	@Override
	public List<BrandVO> getAll() {
		List<BrandVO> list = new ArrayList<BrandVO>();
		BrandVO brandVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				brandVO = new BrandVO();
				brandVO.setBraNo(rs.getInt("BRANO"));
				brandVO.setBraName(rs.getString("BRANAME"));
				brandVO.setBraLogo(rs.getBytes("BRALOGO"));
				brandVO.setBraIntro(rs.getString("BRAINTRO"));
				list.add(brandVO);
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
	public Set<ProductVO> getProductsByBraNo(Integer braNo) {
		Set<ProductVO> set = new LinkedHashSet<ProductVO>();
		ProductVO productVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Products_ByBraNo_STMT);
			pstmt.setInt(1, braNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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
