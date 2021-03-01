package com.postrep.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PostrepDAO implements PostrepDAO_Interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO POSTREP (postNo,memNo,postrepCon) VALUES(?,?,?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.postrep;";
	private static final String GET_ONE_STMT = "SELECT desNo , postCon, postPic1 FROM post where postNo = ?";	//back-end
	private static final String GET_DES_POST = "SELECT desNo , postCon, postPic1 FROM post where desNo = ?";	//front-end 複合查詢設計師名
	
	private static final String DELETE = "";
	private static final String UPDATE = "";
	
	@Override
	public void insert(PostrepVO postrepVo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, postrepVo.getPostNo());
			pstmt.setInt(2, postrepVo.getMemNo());
			pstmt.setString(3, postrepVo.getPostRepCon());
			
			pstmt.executeUpdate();
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
	public void update(PostrepVO postrepVo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(Integer postrepNo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public PostrepVO findByPrimaryKey(Integer postrepNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<PostrepVO> getAll() {
		List<PostrepVO> list = new ArrayList<PostrepVO>();
		PostrepVO postrepVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postrepVo = new PostrepVO();
				postrepVo.setPrepNo(rs.getInt("prepNo"));
				postrepVo.setPostNo(rs.getInt("postNo"));
				postrepVo.setMemNo(rs.getInt("memNo"));
				postrepVo.setPostRepCon(rs.getString("postrepCon"));
				postrepVo.setPostRepTime(rs.getDate("postRepTime"));
				postrepVo.setPostRepStatus(rs.getInt("postRepStatus"));
				list.add(postrepVo); // Store the row in the list
			}

			// Handle any driver errors
			}  catch (SQLException se) {
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
