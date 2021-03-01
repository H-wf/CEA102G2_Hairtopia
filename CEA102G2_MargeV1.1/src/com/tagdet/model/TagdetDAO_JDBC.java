//package com.tagdet.model;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//
//
//public class TagdetDAO_JDBC implements TagdetDAO_Interface{
//	
//	String driver = "com.mysql.cj.jdbc.Driver";
//	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
//	String userid = "root";
//	String pw = "1qaz2wsx";
//	
//	private static final String INSERT_STMT = "INSERT INTO TAGDET(tagNo,postNo) VALUES(?,?)";
//	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.tagdet;";
//	private static final String GET_ONE_STMT = "SELECT desNo , postCon, postPic1 FROM post where postNo = ?";	//back-end
//	private static final String GET_DES_POST = "SELECT desNo , postCon, postPic1 FROM post where desNo = ?";	//front-end 複合查詢設計師名
//	
//	private static final String DELETE = "";
//	private static final String UPDATE = "";
//	
//	@Override
//	public void insert(TagdetVO tagdetVo) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, pw);
//			pstmt = con.prepareStatement(INSERT_STMT);
//			pstmt.setInt(1, tagdetVo.getTagNo());
//			pstmt.setInt(2, tagdetVo.getPostNo());
//			
//			pstmt.executeUpdate();
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}
//		
//	
//	@Override
//	public void update(TagdetVO tagdetVo) {
//		// TODO Auto-generated method stub
//		
//	}
//	@Override
//	public void delete(Integer tagdetNo) {
//		// TODO Auto-generated method stub
//		
//	}
//	@Override
//	public TagdetVO findByPrimaryKey(Integer tagdetNo) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//	@Override
//	public List<TagdetVO> getAll() {
//		List<TagdetVO> list = new ArrayList<TagdetVO>();
//		TagdetVO tagdetVo = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, pw);
//			pstmt = con.prepareStatement(GET_ALL_STMT);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// empVO 也稱為 Domain objects
//				tagdetVo = new TagdetVO();
//				tagdetVo.setTagNo(rs.getInt("tagNo"));
//				tagdetVo.setPostNo(rs.getInt("postNo"));
//				list.add(tagdetVo); // Store the row in the list
//			}
//
//			// Handle any driver errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
//	}
//	
//	public static void main(String[] args) {
//		TagdetDAO_JDBC dao = new TagdetDAO_JDBC();
//		//新增
//			
////			TagdetVO tagdetVo = new TagdetVO();
////			
////			tagdetVo.setTagNo(8);
////			tagdetVo.setPostNo(8);
////			dao.insert(tagdetVo);
//			
//		//查全部
//			List<TagdetVO> list = dao.getAll();
//			for (TagdetVO aTagdet : list) {
//				System.out.print(aTagdet.getTagNo() + ",");
//				System.out.print(aTagdet.getPostNo());
//				System.out.println();
//			}
//	}
//
//}
