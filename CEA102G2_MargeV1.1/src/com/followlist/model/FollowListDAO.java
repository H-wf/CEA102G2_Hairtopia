package com.followlist.model;

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

public class FollowListDAO implements FollowListDAO_Interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO FOLLOW_LIST(memNo,desNo) VALUES(?,?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.follow_list order by memNo;";
	private static final String GET_ONE_FOLLOWLIST = "SELECT memNo,desNo FROM hairtopia.follow_list where  memNo=? and desNo=?;";	
	
	private static final String DELETE = "";
	private static final String UPDATE = "";
	
	
	@Override
	public void insert(FollowListVO followListVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, followListVo.getMemNo());
			pstmt.setInt(2, followListVo.getDesNo());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	@Override
	public void update(FollowListVO followListVo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(Integer memNO, Integer desNo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Boolean findByPrimaryKey(Integer memNo, Integer desNo) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_FOLLOWLIST);
			
			pstmt.setInt(1,memNo);
			pstmt.setInt(2,desNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. IN followListDAO Method 「findByPrimaryKey」 "
					+ e.getMessage());
		}finally {
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
		return false;
	}
	@Override
	public List<FollowListVO> getAll() {
		List<FollowListVO> list = new ArrayList<FollowListVO>();
		FollowListVO followListVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				followListVo = new FollowListVO();
				followListVo.setMemNo(rs.getInt("memNo"));
				followListVo.setDesNo(rs.getInt("desNo"));
				list.add(followListVo); // Store the row in the list
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
