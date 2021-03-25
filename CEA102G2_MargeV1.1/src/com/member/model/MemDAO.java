package com.member.model;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class MemDAO implements MemDAO_interface{

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	//memNo,memName,memGender,memPic,memInform,memEmail,memPswd,memPhone,memAddr,memBal,memStatus,memEndDate, memCode
	private static final String INSERT_SIGNUP_STMT = "INSERT INTO MEMBER (memName, memEmail, memPswd) VALUES (?, ?, ?)";
//	private static final String INSERT_NO_PIC = "INSERT INTO MEMBER (memName, memGender , memInform ,memEmail, memPswd, memPhone, memAddr) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT = "INSERT INTO MEMBER (memName, memGender, memInform ,memEmail, memPswd, memPhone, memAddr, memPic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM MEMBER";
	private static final String GET_ONE_STMT = "SELECT * FROM MEMBER WHERE memNO = ?";
	private static final String VALIDATE_STMT = "SELECT * FROM MEMBER WHERE memEmail=? AND memPswd=?";
	private static final String CONFIRM_EMAIL = "SELECT * FROM MEMBER WHERE memEmail=? ";
	private static final String CONFIRM_MEMBER_NAME = "SELECT * FROM MEMBER WHERE memName=? ";
	private static final String DELETE = "DELETE FROM MEMBER WHERE memNO = ?";
	private static final String UPDATE_WITH_PIC = "UPDATE MEMBER set memName=?, memGender=?, memInform=?, memEmail=?, memPswd= ?, memPhone=?, memAddr=?, memPic=? WHERE memNO = ?";
	private static final String UPDATE_PASSWORD_BY_EMAIL = "UPDATE MEMBER set memPswd= ? WHERE memEmail = ?";
	private static final String UPDATE_STATUS_BY_EMAIL = "UPDATE MEMBER set memStatus= ? WHERE memEmail = ?";
	private static final String UPDATE_NOPIC_STMT = "UPDATE MEMBER set memName=?, memGender=?, memInform=?, memEmail=?, memPswd= ?, memPhone=?, memAddr=? WHERE memNO = ?";
	private static final String GET_IMG = "SELECT memPic FROM MEMBER WHERE memNO = ?";

	@Override
	public void insert(MemVO memVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			pstmt.setString(1, memVO.getMemName());
			pstmt.setInt(2, (memVO.getMemGender() == null) ? 0 : memVO.getMemGender());
			pstmt.setString(3, memVO.getMemInform());
			pstmt.setString(4, memVO.getMemEmail());
			pstmt.setString(5, memVO.getMemPswd());
			pstmt.setString(6, memVO.getMemPhone());
			pstmt.setString(7, memVO.getMemAddr());
			pstmt.setBytes(8, memVO.getMemPic());
			
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
	
	public void signUp(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_SIGNUP_STMT);
			pstmt.setString(1, memVO.getMemName());
			pstmt.setString(2, memVO.getMemEmail());
			pstmt.setString(3, memVO.getMemPswd());

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
	public void update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			if(memVO.getMemPic() == null) {
				pstmt = con.prepareStatement(UPDATE_NOPIC_STMT);
				pstmt.setInt(8, memVO.getMemNo());
			}else {
				pstmt = con.prepareStatement(UPDATE_WITH_PIC);
				pstmt.setBytes(8, memVO.getMemPic());
				pstmt.setInt(9, memVO.getMemNo());
			}
			
			
			pstmt.setString(1, memVO.getMemName());
			pstmt.setInt(2, (memVO.getMemGender() == null) ? 0 : memVO.getMemGender());
			pstmt.setString(3, memVO.getMemInform());
			pstmt.setString(4, memVO.getMemEmail());
			pstmt.setString(5, memVO.getMemPswd());
			pstmt.setString(6, memVO.getMemPhone());
			pstmt.setString(7, memVO.getMemAddr());

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
	public void updatePassword(String memEmail, String memPswd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PASSWORD_BY_EMAIL);

			pstmt.setString(1, memPswd);
			pstmt.setString(2, memEmail);
			

			int a = pstmt.executeUpdate();

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
	public void updateStatus(String memEmail, Integer memStatus) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS_BY_EMAIL);
			pstmt.setInt(1, memStatus);
			pstmt.setString(2, memEmail);
			

			int a = pstmt.executeUpdate();

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
	public void delete(Integer memNo) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, memNo);
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public MemVO findByPrimaryKey(Integer memNo) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, memNo);
			System.out.println("MemDAO no.246 for memNo："+ memNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMemNo(rs.getInt("memNo"));
				memVO.setMemName(rs.getString("memName"));
				memVO.setMemGender(rs.getInt("memGender"));
				memVO.setMemPic(rs.getBytes("memPic"));
				memVO.setMemInform(rs.getString("memInform"));
				memVO.setMemEmail(rs.getString("memEmail"));
				memVO.setMemPswd(rs.getString("memPswd"));
				memVO.setMemPhone(rs.getString("memPhone"));
				memVO.setMemAddr(rs.getString("memAddr"));
				memVO.setMemBal(rs.getInt("memBal"));
				memVO.setMemStatus(rs.getInt("memStatus"));
				memVO.setMemEndDate(rs.getDate("memEndDate"));
				memVO.setMemCode(rs.getString("memCode"));
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
		return memVO;
	}

	@Override
	public List<MemVO> getAll() {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				memVO = new MemVO();
				memVO.setMemNo(rs.getInt("memNo"));
				memVO.setMemName(rs.getString("memName"));
				memVO.setMemGender(rs.getInt("memGender"));
				memVO.setMemPic(rs.getBytes("memPic"));
				memVO.setMemInform(rs.getString("memInform"));
				memVO.setMemEmail(rs.getString("memEmail"));
				memVO.setMemPswd(rs.getString("memPswd"));
				memVO.setMemPhone(rs.getString("memPhone"));
				memVO.setMemAddr(rs.getString("memAddr"));
				memVO.setMemBal(rs.getInt("memBal"));
				memVO.setMemStatus(rs.getInt("memStatus"));
				memVO.setMemEndDate(rs.getDate("memEndDate"));
				memVO.setMemCode(rs.getString("memCode"));
				
				list.add(memVO);
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
	
	public MemVO validate(String memEmail, String memPswd) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(VALIDATE_STMT);
			
			pstmt.setString(1, memEmail);
			pstmt.setString(2, memPswd);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memVO = new MemVO();
				memVO.setMemNo(rs.getInt("memNo"));
				memVO.setMemName(rs.getString("memName"));
				memVO.setMemGender(rs.getInt("memGender"));
				memVO.setMemPic(rs.getBytes("memPic"));
				memVO.setMemInform(rs.getString("memInform"));
				memVO.setMemEmail(rs.getString("memEmail"));
				memVO.setMemPswd(rs.getString("memPswd"));
				memVO.setMemPhone(rs.getString("memPhone"));
				memVO.setMemAddr(rs.getString("memAddr"));
				memVO.setMemBal(rs.getInt("memBal"));
				memVO.setMemStatus(rs.getInt("memStatus"));
				memVO.setMemEndDate(rs.getDate("memEndDate"));
				memVO.setMemCode(rs.getString("memCode"));
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
		return memVO;
	}

	@Override
	public String validateEmail(String memEmail) {
		String memName = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(CONFIRM_EMAIL);
			
			pstmt.setString(1, memEmail);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memName = rs.getString("memName");
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
		return memName;
	}
	
	@Override
	public String validateMemberName(String memName) {
		
		String valid = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(CONFIRM_MEMBER_NAME);
			
			pstmt.setString(1, memName);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				valid = rs.getString("memName");
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
		return valid;
		
	}
	

//	public InputStream showImg(Integer memNo) {
//		InputStream memPic= null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_IMG);
//
//			pstmt.setInt(1, memNo);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				memPic = rs.getBinaryStream("memPic");
//			}
//			
//			
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
//		return memPic;
//	}



}
