package com.notification.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class NotiJDBCDAO implements NotiDAO_interface{

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";
	
	private static final String INSERT_TEXT_STMT = "INSERT INTO NOTIFICATION (memNo, notiText, notiIsRead) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM NOTIFICATION";
	private static final String GET_ONE_STMT = "SELECT * FROM NOTIFICATION WHERE notiNo = ?";
	private static final String DELETE = "DELETE FROM NOTIFICATION WHERE notiNo = ?";
	private static final String UPDATE = "UPDATE NOTIFICATION set memNo=?, notiText=?, notiIsRead= ? WHERE notiNo = ?";

	
	@Override
	public void insert(NotiVO notiVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_TEXT_STMT);

			pstmt.setInt(1, notiVO.getMemNo());
			pstmt.setString(2, notiVO.getNotiText());
			pstmt.setBoolean(3, notiVO.getNotiIsRead());

			pstmt.execute();

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
	public void update(NotiVO notiVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, notiVO.getMemNo());
			pstmt.setString(2, notiVO.getNotiText());
			pstmt.setBoolean(3, notiVO.getNotiIsRead());
			pstmt.setInt(4, notiVO.getNotiNo());

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
	public void delete(Integer notiNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, notiNo);

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
	public NotiVO findByPrimaryKey(Integer notiNo) {
		NotiVO notiVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, notiNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				notiVO = new NotiVO();
				notiVO.setNotiNo(rs.getInt("notiNo"));
				notiVO.setMemNo(rs.getInt("memNo"));
				notiVO.setNotiText(rs.getString("notiText"));
				notiVO.setNotiTime(rs.getTimestamp("notiTime"));
				notiVO.setNotiIsRead(rs.getBoolean("notiIsRead"));
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
		return notiVO;
	}

	@Override
	public List<NotiVO> getAll() {
		List<NotiVO> list = new ArrayList<NotiVO>();
		NotiVO notiVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				notiVO = new NotiVO();
				notiVO.setNotiNo(rs.getInt("notiNo"));
				notiVO.setMemNo(rs.getInt("memNo"));
				notiVO.setNotiText(rs.getString("notiText"));
				notiVO.setNotiTime(rs.getTimestamp("notiTime"));
				notiVO.setNotiIsRead(rs.getBoolean("notiIsRead"));

				list.add(notiVO);
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
		NotiJDBCDAO dao = new NotiJDBCDAO();

//		System.out.println(123);

		// insert test
//		NotiVO notiVO = new NotiVO();
//		notiVO.setMemNo(4);
//		notiVO.setNotiText("123");
//		notiVO.setNotiIsRead(false);
//		dao.insert(notiVO);

		// update test
//		NotiVO notiVO = new NotiVO();
//		notiVO.setNotiNo(6);
//		notiVO.setMemNo(3);;
//		notiVO.setNotiText("321321");;
//		notiVO.setNotiIsRead(true);
//		dao.update(notiVO);

		// 查詢
//		NotiVO notiVO = dao.findByPrimaryKey(5);
//		System.out.print(notiVO.getNotiNo() + ", ");
//		System.out.print(notiVO.getMemNo() + ", ");
//		System.out.print(notiVO.getNotiText() + ", ");
//		System.out.print(notiVO.getNotiTime() + ", ");
//		System.out.println(notiVO.getNotiIsRead());
//		System.out.println("--------------------------------------------------------------------------------------");

		// get all
//		List<ChatVO> list = dao.getAll();
//		for (ChatVO chatVO : list) {
//			System.out.print(chatVO.getChatNo() + ", ");
//			System.out.print(chatVO.getChatSender() + ", ");
//			System.out.print(chatVO.getChatReceiver() + ", ");
//			System.out.print(chatVO.getChatText() + ", ");
//			System.out.print(chatVO.getChatPic() + ", ");
//			System.out.print(chatVO.getChatIsRead() + ", ");
//			System.out.println(chatVO.getChatTime());
//			System.out
//					.println("--------------------------------------------------------------------------------------");
//		}
		// delete
//		dao.delete(6);
	}	
}
