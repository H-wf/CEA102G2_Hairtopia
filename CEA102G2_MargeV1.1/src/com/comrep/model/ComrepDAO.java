package com.comrep.model;

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

public class ComrepDAO implements ComrepDAO_Interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO COMREP(comNo,memNo,crepCon) VALUES(?,?,?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.comrep;";
	private static final String GET_ONE_STMT = "SELECT crepNo , comNo, memNo , crepCon , crepTime , crepStatus FROM hairtopia.comrep where crepNo = ?";	//back-end
	private static final String GET_DES_POST = "SELECT desNo , postCon, postPic1 FROM post where desNo = ?";	//front-end 複合查詢設計師名
	
	private static final String DELETE = "";
	private static final String UPDATE = "";
	
	@Override
	public void insert(ComrepVO comrepVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, comrepVo.getComNo());
			pstmt.setInt(2, comrepVo.getMemNo());
			pstmt.setString(3, comrepVo.getCrepCon());
			
			pstmt.executeUpdate();
			
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
		
	@Override
	public void update(ComrepVO comrepVo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(Integer crepNo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public ComrepVO findByPrimaryKey(Integer crepNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<ComrepVO> getAll() {
		List<ComrepVO> list = new ArrayList<ComrepVO>();
		ComrepVO comrepVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				comrepVo = new ComrepVO();
				comrepVo.setCrepNo(rs.getInt("crepNo"));
				comrepVo.setComNo(rs.getInt("comNo"));
				comrepVo.setMemNo(rs.getInt("memNo"));
				comrepVo.setCrepCon(rs.getString("crepCon"));
				comrepVo.setCrepTime(rs.getDate("crepTime"));
				comrepVo.setCrepStatus(rs.getInt("crepStatus"));
				list.add(comrepVo); // Store the row in the list
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
	
	

}
