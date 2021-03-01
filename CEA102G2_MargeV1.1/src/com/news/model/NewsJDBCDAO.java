package com.news.model;

import java.sql.DriverManager;
import java.util.*;
import java.sql.*;

public class NewsJDBCDAO implements NewsDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";

	// memNo,memName,memGender,memPic,memInform,memEmail,memPswd,memPhone,memAddr,memBal,memStatus,memEndDate,
	// memCode

	private static final String INSERT_STMT = "INSERT INTO NEWS (newsTitle, newsCon) VALUES ( ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM NEWS";
	private static final String GET_ONE_STMT = "SELECT * FROM NEWS WHERE newsNo = ?";
//	private static final String VALIDATE_STMT = "SELECT * FROM MEMBER WHERE memEmail=? AND memPswd=?";
	private static final String DELETE = "DELETE FROM NEWS WHERE newsNo = ?";
	private static final String UPDATE = "UPDATE NEWS SET newsTitle=?, newsCon=? WHERE newsNo = ?";

	@Override
	public void insert(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, newsVO.getNewsTitle());
			pstmt.setString(2, newsVO.getNewsCon());
//			pstmt.setString(12, memVO.getMemCode());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, newsVO.getNewsTitle());
			pstmt.setString(2, newsVO.getNewsCon());
			pstmt.setInt(3, newsVO.getNewsNo());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void delete(Integer newsNo) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, newsNo);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
	public NewsVO findByPrimaryKey(Integer newsNo) {
		NewsVO newsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, newsNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				newsVO = new NewsVO();
				newsVO.setNewsNo(rs.getInt("newsNo"));
				newsVO.setNewsTitle(rs.getString("newsTitle"));
				newsVO.setNewsCon(rs.getString("newsCon"));
				newsVO.setNewsTime(rs.getDate("newsTime"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
		return newsVO;
	}

	@Override
	public List<NewsVO> getAll() {
		List<NewsVO> list = new ArrayList<NewsVO>();
		NewsVO newsVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				// memName,memGender,memPic,memInform,memEmail,memPswd,memPhone,memAddr,memBal,memStatus,memEndDate,
				// memCode
				newsVO = new NewsVO();
				newsVO.setNewsNo(rs.getInt("newsNo"));
				newsVO.setNewsTitle(rs.getString("newsTitle"));
				newsVO.setNewsCon(rs.getString("newsCon"));
				newsVO.setNewsTime(rs.getDate("newsTime"));

				list.add(newsVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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


	public static void main(String[] args) {
		NewsJDBCDAO dao = new NewsJDBCDAO();

//		System.out.println(123);

		 	//insert test
//			NewsVO newsVO = new NewsVO();
//			newsVO.setNewsTitle("abcd");;
//			newsVO.setNewsCon("Lot of place");;
////			newsVO.set;
//			dao.insert(newsVO);

//		 update test
//			NewsVO newsVO = new NewsVO();
//			newsVO.setNewsNo(6);
//			newsVO.setNewsTitle("ab");;
//			newsVO.setNewsCon("Lot e");;
//
//			dao.update(newsVO);

		// 查詢
//		NewsVO newsVO = dao.findByPrimaryKey(1);
//		System.out.print(newsVO.getNewsNo() + ", ");
//		System.out.print(newsVO.getNewsTime() + ", ");
//		System.out.print(newsVO.getNewsTitle() + ", ");
//		System.out.print(newsVO.getNewsCon() + ", ");
//		System.out.println(newsVO.getNewsPic());
//		System.out.println("--------------------------------------------------------------------------------------");

		// get all
//		List<NewsVO> list = dao.getAll();
//		for (NewsVO newsVO : list) {
//			System.out.print(newsVO.getNewsNo() + ", ");
//			System.out.print(newsVO.getNewsTime() + ", ");
//			System.out.print(newsVO.getNewsTitle() + ", ");
//			System.out.print(newsVO.getNewsCon() + ", ");
//			System.out.println(newsVO.getNewsPic());
//			System.out.println("--------------------------------------------------------------------------------------");
//		}
		// delete
		dao.delete(6);
	}

}
