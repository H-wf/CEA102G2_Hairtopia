package com.followlist.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class FollowListDAO_JDBC implements FollowListDAO_Interface{
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "root";
	String pw = "1qaz2wsx";

	private static final String INSERT_STMT = " INSERT INTO FOLLOW_LIST(memNo,desNo) VALUES(?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.follow_list order by memNo;";
	private static final String GET_ONE_STMT = "SELECT desNo , postCon, postPic1 FROM post where postNo = ?";	//back-end
	private static final String GET_DES_POST = "SELECT desNo , postCon, postPic1 FROM post where desNo = ?";	//front-end 複合查詢設計師名
	
	private static final String DELETE = "";
	private static final String UPDATE = "";
	
	
	@Override
	public void insert(FollowListVO followListVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, pw);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, followListVo.getMemNo());
			pstmt.setInt(2, followListVo.getDesNo());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public FollowListVO findByPrimaryKey(Integer memNO, Integer desNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<FollowListVO> getAll() {
		List<FollowListVO> list = new ArrayList<FollowListVO>();
		FollowListVO followListVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, pw);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	
	public static void main(String[] args) {
		FollowListDAO_JDBC dao = new FollowListDAO_JDBC();
		//新增
			
//		FollowListVO followListVo = new FollowListVO();
//			
//		followListVo.setMemNo(1);
//		followListVo.setDesNo(3);
//			dao.insert(followListVo);
			
		//查全部
			List<FollowListVO> list = dao.getAll();
			for (FollowListVO afollowList : list) {
				System.out.print(afollowList.getMemNo() + ",");
				System.out.print(afollowList.getDesNo());
				System.out.println();
			}
	}
	
}
