package com.chat.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;


public class ChatDAO implements ChatDAO_interface{

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_TEXT_STMT = "INSERT INTO CHAT (chatSender, chatReceiver, chatText, chatPic) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM CHAT";
	private static final String GET_ONE_STMT = "SELECT * FROM CHAT WHERE chatNo = ?";
	private static final String DELETE = "DELETE FROM CHAT WHERE chatNo = ?";
	private static final String UPDATE = "UPDATE CHAT set chatSender=?, chatReceiver=?, chatText= ? WHERE chatNo = ?";
	private static final String UPDATE_WITH_PIC = "UPDATE CHAT set chatSender=?, chatReceiver=?, chatText=?, chatPic=? WHERE chatNo = ?";
	
	@Override
	public void insert(ChatVO chatVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_TEXT_STMT);

			pstmt.setInt(1, chatVO.getChatSender());
			pstmt.setInt(2, chatVO.getChatReceiver());
			pstmt.setString(3, chatVO.getChatText());
			pstmt.setBytes(4, chatVO.getChatPic());

			pstmt.execute();

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
			con = ds.getConnection();
			if(chatVO.getChatPic() == null) {
				pstmt = con.prepareStatement(UPDATE);
				pstmt.setInt(4, chatVO.getChatNo());
			}else {
				pstmt = con.prepareStatement(UPDATE_WITH_PIC);
				pstmt.setBytes(4, chatVO.getChatPic());
				pstmt.setInt(5, chatVO.getChatNo());
			}
			

			pstmt.setInt(1, chatVO.getChatSender());
			pstmt.setInt(2, chatVO.getChatReceiver());
			pstmt.setString(3, chatVO.getChatText());
			

			pstmt.executeUpdate();

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

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, chatNo);

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
	public ChatVO findByPrimaryKey(Integer chatNo) {
		ChatVO chatVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, chatNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// deptVO 銋迂� Domain objects
				chatVO = new ChatVO();
				chatVO.setChatNo(rs.getInt("chatNo"));
				chatVO.setChatSender(rs.getInt("chatSender"));
				chatVO.setChatReceiver(rs.getInt("chatReceiver"));
				chatVO.setChatText(rs.getString("chatText"));
				chatVO.setChatTime(rs.getTimestamp("chatTime"));
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				chatVO = new ChatVO();
				chatVO.setChatNo(rs.getInt("chatNo"));
				chatVO.setChatSender(rs.getInt("chatSender"));
				chatVO.setChatReceiver(rs.getInt("chatReceiver"));
				chatVO.setChatText(rs.getString("chatText"));
				chatVO.setChatTime(rs.getTimestamp("chatTime"));
				chatVO.setChatIsRead(rs.getBoolean("chatIsRead"));

				list.add(chatVO);
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

}
