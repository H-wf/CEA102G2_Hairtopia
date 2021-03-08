package com.trenddescription.model;

import java.util.List;
import java.util.Set;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TrenddescDAO implements TrenddescDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO TREND_DESCRIPTION(treNo,postNo) VALUES(?,?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.TREND_DESCRIPTION;";
	private static final String GET_ONE_STMT = "SELECT treNo FROM hairtopia.TREND_DESCRIPTION where postNo = ?"; // back-end
	

	private static final String DELETE = "";
	private static final String UPDATE = "";

	@Override
	public void insert(TrenddescVO tredVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, tredVO.getTreNo());
			pstmt.setInt(2, tredVO.getPostNo());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void update(TrenddescVO tredVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer treNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Set<Integer> findByPostNo(Integer postNo) {
		Set<Integer> set = new HashSet<Integer>();
		Integer treNo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, postNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				treNo = rs.getInt("treNo");
				set.add(treNo); // Store the row in the list
			}
		} catch (SQLException e) {
			throw new RuntimeException("get TagNo exception. " + e.getMessage());
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

	@Override
	public List<TrenddescVO> getAll() {
		List<TrenddescVO> list = new ArrayList<TrenddescVO>();
		TrenddescVO trenddescVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				trenddescVo = new TrenddescVO();
				trenddescVo.setTreNo(rs.getInt("treNo"));
				trenddescVo.setPostNo(rs.getInt("postNo"));
				list.add(trenddescVo); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
