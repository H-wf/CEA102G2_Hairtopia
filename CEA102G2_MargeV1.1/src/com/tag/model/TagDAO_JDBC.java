//package com.tag.model;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.post.model.PostVO;
//
//public class TagDAO_JDBC implements TagDAO_Interface{
//	
//	String driver = "com.mysql.cj.jdbc.Driver";
//	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
//	String userid = "root";
//	String pw = "1qaz2wsx";
//	
//	private static final String INSERT_STMT = "INSERT INTO TAG(tagName) VALUES(?);";
//	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.tag;";
//	private static final String GET_NO_BY_TAG_NAME = "SELECT tagNo FROM hairtopia.tag WHERE tagName=?;";
//	private static final String DELETE = "DELETE FROM hairtopia.tag WHERE tagNo = ?;";
//	private static final String UPDATE = "UPDATE hairtopia.tag SET tagName=? WHERE tagNo=?;";
//	
//	
//	@Override
//	public TagVO insert(TagVO tagVo) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, pw);
//			pstmt = con.prepareStatement(INSERT_STMT);
//			pstmt.setString(1, tagVo.getTagName());
//			
//			pstmt.executeUpdate();
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return tagVo;
//	}
//	
//	@Override
//	public void update(TagVO tagVo) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, pw);
//			pstmt = con.prepareStatement(UPDATE);
//			pstmt.setString(1, tagVo.getTagName());
//			pstmt.setInt(2, tagVo.getTagNo());
//			
//			pstmt.executeUpdate();
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}		
//	}
//	@Override
//	public void delete(Integer tagNo) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, pw);
//			pstmt = con.prepareStatement(DELETE);
//			pstmt.setInt(1, tagNo);
//			
//			pstmt.executeUpdate();
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}				
//	}
//	@Override
//	public TagVO findByPrimaryKey(Integer tagNo) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//	
//	@Override
//	public Integer findByTagName(String tagName) {
//		
//		Integer tagNo = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//			try {
//				Class.forName(driver);
//				con = DriverManager.getConnection(url, userid, pw);
//				pstmt = con.prepareStatement(GET_NO_BY_TAG_NAME);
//				pstmt.setString(1, tagName);
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()) {
//					tagNo = rs.getInt("tagNo");
//				}
//				
//			}catch (ClassNotFoundException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}finally {
//				if (rs != null) {
//					try {
//						rs.close();
//					} catch (SQLException se) {
//						se.printStackTrace(System.err);
//					}
//				}
//				if (pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (SQLException se) {
//						se.printStackTrace(System.err);
//					}
//				}
//				if (con != null) {
//					try {
//						con.close();
//					} catch (Exception e) {
//						e.printStackTrace(System.err);
//					}
//				}
//			}
//		
//		return tagNo;
//	}
//	
//	@Override
//	public List<TagVO> getAll() {
//		List<TagVO> list = new ArrayList<TagVO>();
//		TagVO tagVo = null;
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
//				tagVo = new TagVO();
//				tagVo.setTagNo(rs.getInt("tagNo"));
//				tagVo.setTagName(rs.getString("tagName"));
//				list.add(tagVo); // Store the row in the list
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
//		
//		TagDAO_JDBC dao = new TagDAO_JDBC();
//	//新增
//		
////		TagVO tagVo = new TagVO();
////		
////		tagVo.setTagName("告別油膩");
////		dao.insert(tagVo);
//		
//	//DELETE
//		
////		dao.delete(2);
//		
//	//update
//		
////		TagVO tagVo = new TagVO();
////		tagVo.setTagNo(3);;
////		tagVo.setTagName("11");
////		dao.update(tagVo);
//		
////	//查全部
////		List<TagVO> list = dao.getAll();
////		for (TagVO aTag : list) {
////			System.out.print(aTag.getTagNo() + ",");
////			System.out.print(aTag.getTagName());
////			System.out.println();
////		}
//		
//	//用tag name查
//		Integer x = dao.findByTagName("安安");
////		Integer x = null;
//		System.out.println(x);
//	}
//}
