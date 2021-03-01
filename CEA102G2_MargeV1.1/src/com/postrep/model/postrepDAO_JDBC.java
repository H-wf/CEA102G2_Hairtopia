package com.postrep.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.post.model.PostVO;


public class postrepDAO_JDBC implements PostrepDAO_Interface{
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "root";
	String pw = "1qaz2wsx";
	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, pw);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, postrepVo.getPostNo());
			pstmt.setInt(2, postrepVo.getMemNo());
			pstmt.setString(3, postrepVo.getPostRepCon());
			
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, pw);
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
		postrepDAO_JDBC dao = new postrepDAO_JDBC();
		
	//新增
		
//		PostrepVO postrepVo = new PostrepVO();
//		
//		postrepVo.setPostNo(4);
//		postrepVo.setMemNo(1);
//		postrepVo.setPostRepCon("噁心");
//		dao.insert(postrepVo);
		
		//查全部
		List<PostrepVO> list = dao.getAll();
		for (PostrepVO aPostrep : list) {
			System.out.print(aPostrep.getPrepNo() + ",");
			System.out.print(aPostrep.getPostNo() + ",");
			System.out.print(aPostrep.getMemNo() + ",");
			System.out.print(aPostrep.getPostRepCon() + ",");
			System.out.print(aPostrep.getPostRepTime() + ",");
			System.out.print(aPostrep.getPostRepStatus() + ",");
			System.out.println();
		}
	}
	
	
}
