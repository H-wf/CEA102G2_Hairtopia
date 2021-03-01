package com.chat.model;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

public class ChatJDBCDAO implements ChatDAO_interface {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";

	private static final String INSERT_TEXT_STMT = "INSERT INTO CHAT (chatSender, chatReceiver, chatText) VALUES (?, ?, ?)";
	private static final String INSERT_PIC_STMT = "INSERT INTO CHAT (chatSender, chatReceiver, chatPic) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM CHAT";
	private static final String GET_ONE_STMT = "SELECT * FROM CHAT WHERE chatNo = ?";
	private static final String DELETE = "DELETE FROM CHAT WHERE chatNo = ?";
	private static final String UPDATE = "UPDATE CHAT set chatSender=?, chatReceiver=?, chatText= ? WHERE chatNo = ?";

	@Override
	public void insert(ChatVO chatVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_TEXT_STMT);

			pstmt.setInt(1, chatVO.getChatSender());
			pstmt.setInt(2, chatVO.getChatReceiver());
			pstmt.setString(3, chatVO.getChatText());

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
	public void update(ChatVO chatVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, chatVO.getChatSender());
			pstmt.setInt(2, chatVO.getChatReceiver());
			pstmt.setString(3, chatVO.getChatText());
			pstmt.setInt(4, chatVO.getChatNo());

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
	public void delete(Integer chatNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, chatNo);

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
	public ChatVO findByPrimaryKey(Integer chatNo) {
		ChatVO chatVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, chatNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 也稱為 Domain objects
				chatVO = new ChatVO();
				chatVO.setChatNo(rs.getInt("chatNo"));
				chatVO.setChatSender(rs.getInt("chatSender"));
				chatVO.setChatReceiver(rs.getInt("chatReceiver"));
				chatVO.setChatText(rs.getString("chatText"));
				chatVO.setChatTime(rs.getTimestamp("chatTime"));
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
		return chatVO;
	}

	@Override
	public List<ChatVO> getAll() {
		List<ChatVO> list = new ArrayList<ChatVO>();
		ChatVO chatVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				chatVO = new ChatVO();
				chatVO.setChatNo(rs.getInt("chatNo"));
				chatVO.setChatSender(rs.getInt("chatSender"));
				chatVO.setChatReceiver(rs.getInt("chatReceiver"));
				chatVO.setChatText(rs.getString("chatText"));
				chatVO.setChatTime(rs.getTimestamp("chatTime"));

				list.add(chatVO);
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
		ChatJDBCDAO dao = new ChatJDBCDAO();

//		System.out.println(123);

		// insert test
//		ChatVO chatVO = new ChatVO();
//		chatVO.setChatSender(1);
//		chatVO.setChatReceiver(2);
//		chatVO.setChatText("hello");
//		dao.insert(chatVO);

		// update test
//		ChatVO chatVO = new ChatVO();
//		chatVO.setChatNo(6);
//		chatVO.setChatSender(1);
//		chatVO.setChatReceiver(2);;
//		chatVO.setChatText("132132");;
//		dao.update(chatVO);

		// 查詢
//		ChatVO chatVO = dao.findByPrimaryKey(2);
//		System.out.print(chatVO.getChatNo() + ", ");
//		System.out.print(chatVO.getChatSender() + ", ");
//		System.out.print(chatVO.getChatReceiver() + ", ");
//		System.out.print(chatVO.getChatText() + ", ");
//		System.out.print(chatVO.getChatPic() + ", ");
//		System.out.print(chatVO.getChatIsRead() + ", ");
//		System.out.println(chatVO.getChatTime());
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
		dao.delete(6);
	}
}
