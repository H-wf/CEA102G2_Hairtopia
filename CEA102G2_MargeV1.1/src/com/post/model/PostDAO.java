package com.post.model;

import java.sql.*;
import java.util.*;
import java.util.List;

import javax.naming.*;
import javax.sql.*;


public class PostDAO implements PostDAO_Interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = " INSERT INTO POST(desNo,postCon,postPic1,postPic2,postPic3,postStatus,postPror) VALUES(?,?,?,?,?,?,?)";
	private static final String INSERT_STMT2 = " INSERT INTO POST(desNo,postCon,postPic1,postPic2,postStatus,postPror) VALUES(?,?,?,?,?,?)";
	private static final String INSERT_STMT3 = " INSERT INTO POST(desNo,postCon,postPic1,postStatus,postPror) VALUES(?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.post";
	private static final String GET_ONE_STMT = "SELECT postNo,desNo,postCon,postTime,postStatus,postPror FROM hairtopia.post where postNo=?";
	private static final String GET_DES_POST = "SELECT postNo,desNo,postCon,postTime,postStatus,postPror FROM post where desNo = ? order by postNo";
//	private static final String GET_POST_AJAX = "SELECT postNo,desNo,postCon,postPic1,postPic2,postPic3,postTime,postStatus,postPror FROM post where desNo = ? order by postNo";
	private static final String UPDATE = "UPDATE post set postCon=?, postPic1=?, postPic2=?, postPic3=?,postStatus=?,postPror=? where postNo = ?"; // 修改3張照片																															
	private static final String UPDATE2 = "UPDATE post set postCon=?, postPic1=?, postPic2=?,postStatus=?,postPror=? where postNo = ?"; // 修改2張照片
	private static final String UPDATE3 = "UPDATE post set postCon=?, postPic1=?,postStatus=?,postPror=? where postNo = ?";			//修改1張照片
	private static final String UPDATE4 = "UPDATE post set postCon=?,postStatus=?,postPror=? where postNo = ?";	
	private static final String DELETE = "DELETE FROM post where postNo = ?";

	@Override
	public PostVO insert(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			String[] cols = {"post"};
			pstmt = con.prepareStatement(INSERT_STMT,cols);
			pstmt.setInt(1, postVO.getDesNo());
			pstmt.setString(2, postVO.getPostCon());
			pstmt.setBytes(3, postVO.getPostPic1());
			pstmt.setBytes(4, postVO.getPostPic2());
			pstmt.setBytes(5, postVO.getPostPic3());
			pstmt.setInt(6, postVO.getPostStatus());
			pstmt.setBoolean(7, postVO.isPostPror());

			pstmt.executeUpdate();
			
			String next_postno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_postno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_postno +"(剛新增成功的貼文編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			postVO.setPostNo(new Integer(next_postno));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
		return postVO;
	}

	public PostVO insert2(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			String cols[] = {"post"};
			pstmt = con.prepareStatement(INSERT_STMT2,cols);
			pstmt.setInt(1, postVO.getDesNo());
			pstmt.setString(2, postVO.getPostCon());
			pstmt.setBytes(3, postVO.getPostPic1());
			pstmt.setBytes(4, postVO.getPostPic2());
			pstmt.setInt(5, postVO.getPostStatus());
			pstmt.setBoolean(6, postVO.isPostPror());

			pstmt.executeUpdate();
			
			String next_postno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_postno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_postno +"(剛新增成功的貼文編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			postVO.setPostNo(new Integer(next_postno));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
		return postVO;
	}

	public PostVO insert3(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			String cols[] = {"post"};
			pstmt = con.prepareStatement(INSERT_STMT3,cols);
			pstmt.setInt(1, postVO.getDesNo());
			pstmt.setString(2, postVO.getPostCon());
			pstmt.setBytes(3, postVO.getPostPic1());
			pstmt.setInt(4, postVO.getPostStatus());
			pstmt.setBoolean(5, postVO.isPostPror());

			pstmt.executeUpdate();
			
			String next_postno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_postno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_postno +"(剛新增成功的貼文編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			postVO.setPostNo(new Integer(next_postno));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
		return postVO;
	}

	@Override
	public void update(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, postVO.getPostCon());
			pstmt.setBytes(2, postVO.getPostPic1());
			pstmt.setBytes(3, postVO.getPostPic2());
			pstmt.setBytes(4, postVO.getPostPic3());
			pstmt.setInt(5, postVO.getPostStatus());
			pstmt.setBoolean(6, postVO.isPostPror());
			pstmt.setInt(7, postVO.getPostNo());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	public void update2(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE2);

			pstmt.setString(1, postVO.getPostCon());
			pstmt.setBytes(2, postVO.getPostPic1());
			pstmt.setBytes(3, postVO.getPostPic2());
			pstmt.setInt(4, postVO.getPostStatus());
			pstmt.setBoolean(5, postVO.isPostPror());
			pstmt.setInt(6, postVO.getPostNo());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	public void update3(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE3);

			pstmt.setString(1, postVO.getPostCon());
			pstmt.setBytes(2, postVO.getPostPic1());
			pstmt.setInt(3, postVO.getPostStatus());
			pstmt.setBoolean(4, postVO.isPostPror());
			pstmt.setInt(5, postVO.getPostNo());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	public void update4(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE4);

			pstmt.setString(1,postVO.getPostCon());
			pstmt.setInt(2, postVO.getPostStatus());
			pstmt.setBoolean(3, postVO.isPostPror());
			pstmt.setInt(4, postVO.getPostNo());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	public void delete(Integer postNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, postNo);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	public PostVO findByPrimaryKey(Integer postNo) {
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, postNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPostNo(rs.getInt("postNo"));
				postVO.setDesNo(rs.getInt("desNo"));
				postVO.setPostCon(rs.getString("postCon"));
				postVO.setPostTime(rs.getTimestamp("postTime"));
				postVO.setPostStatus(rs.getInt("postStatus"));
				postVO.setPostPror(rs.getBoolean("postPror"));

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
		return postVO;
	}

	@Override
	public List<PostVO> getAll() {

		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVo = new PostVO();
				postVo.setPostNo(rs.getInt("postNo"));
				postVo.setDesNo(rs.getInt("desNo"));
				postVo.setPostCon(rs.getString("postCon"));
				postVo.setPostTime(rs.getTimestamp("postTime"));
				postVo.setPostStatus(rs.getInt("postStatus"));
				postVo.setPostPror(rs.getBoolean("postPror"));
				list.add(postVo); // Store the row in the list
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

	public List<PostVO> getAll(Integer desNo) {

		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		
	
		
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_DES_POST);
			pstmt.setInt(1, desNo);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVo = new PostVO();
				postVo.setPostNo(rs.getInt("postNo"));
				postVo.setDesNo(rs.getInt("desNo"));
				postVo.setPostCon(rs.getString("postCon"));
				postVo.setPostTime(rs.getTimestamp("postTime"));
				postVo.setPostStatus(rs.getInt("postStatus"));
				postVo.setPostPror(rs.getBoolean("postPror"));
				list.add(postVo); // Store the row in the list
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
	
//	public List<PostVO> getAllByAJAX(String keyword) {
//
//		List<PostVO> list = new ArrayList<PostVO>();
//		PostVO postVo = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//	
//		
//		ResultSet rs = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_POST_AJAX);
//			pstmt.setString(1, keyword);
//			
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// empVO 也稱為 Domain objects
//				postVo = new PostVO();
//				postVo.setPostNo(rs.getInt("postNo"));
//				postVo.setDesNo(rs.getInt("desNo"));
//				postVo.setPostCon(rs.getString("postCon"));
//				postVo.setPostPic1(rs.getBytes("postPic1"));
//				postVo.setPostPic2(rs.getBytes("postPic2"));
//				postVo.setPostPic3(rs.getBytes("postPic3"));
//				postVo.setPostTime(rs.getTimestamp("postTime"));
//				postVo.setPostStatus(rs.getInt("postStatus"));
//				postVo.setPostPror(rs.getBoolean("postPror"));
//				list.add(postVo); // Store the row in the list
//			}
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
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
}
