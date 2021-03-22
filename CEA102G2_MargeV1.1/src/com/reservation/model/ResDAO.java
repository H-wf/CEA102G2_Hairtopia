package com.reservation.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.service.model.ServiceVO;

public class ResDAO implements ResDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
		private static final String INSERT_STMT_RES = 
			"INSERT INTO reservation (memNo,serNo,desNo,resDate,resTime,resPrice) VALUES (?, ?, ?, ?, ?, ?)";
		
		private static final String GET_ALL_STMT = 
			"SELECT resNo,memNo,serNo,desNo,resProDate,resDate,resTime,resStatus,resCom,resCode,resPrice FROM reservation order by resNo";
		private static final String GET_ONE_STMT = 
			"SELECT resNo,memNo,serNo,desNo,resProDate,resDate,resTime,resStatus,resCom,resCode,resPrice FROM reservation where resNo = ?";
		private static final String GET_ALL_BY_DESNO = 
			"SELECT resNo,memNo,serNo,desNo,resProDate,resDate,resTime,resStatus,resCom,resCode,resPrice FROM reservation where desNo = ? order by resNo desc";
		private static final String GET_CONFIRM_BY_DESNO = 
			"SELECT resNo,memNo,serNo,desNo,resProDate,resDate,resTime,resStatus,resCom,resCode,resPrice FROM reservation where resStatus in(0,1,2,3) and desNo = ? order by resTime";
		private static final String GET_ALL_BY_MEMNO = 
			"SELECT resNo,memNo,serNo,desNo,resProDate,resDate,resTime,resStatus,resCom,resCode,resPrice FROM reservation where memNo = ? order by resNo desc";
		
		private static final String DELETE = 
			"DELETE FROM reservation where resNo = ?";
		
		private static final String UPDATE_CONFIRM = 
			"UPDATE reservation set resStatus=?, resCode=? where resNo = ?";
		private static final String UPDATE_STATUS = 
			"UPDATE reservation set resStatus=? where resNo = ?";
		private static final String UPDATE_COM = 
			"UPDATE reservation set resCom=? where resNo = ?";


	@Override
	public ResVO insert(ResVO resVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			String cols[] = {"resNo"};
			pstmt = con.prepareStatement(INSERT_STMT_RES,cols);

			pstmt.setInt(1, resVO.getMemNo());
			pstmt.setInt(2, resVO.getSerNo());
			pstmt.setInt(3, resVO.getDesNo());
			pstmt.setDate(4, resVO.getResDate());
			pstmt.setInt(5, resVO.getResTime());
			pstmt.setInt(6, resVO.getResPrice());

			pstmt.executeUpdate();
			
			//掘取對應的自增主鍵值
			String next_resNo = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_resNo = rs.getString(1);
				System.out.println("自增主鍵值= " + next_resNo +"(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			
			rs.close();
			ResService resSvc = new ResService();
			resVO = resSvc.getOneRes(new Integer(next_resNo));
			
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "//丟出RuntimeException才不會有繼承限制
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
		return resVO;
		
	}

	@Override
	public void update(ResVO resVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_COM);

			pstmt.setInt(1, resVO.getResStatus());
			pstmt.setInt(2, resVO.getResCom());
			pstmt.setInt(3, resVO.getResNo());

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
	public void delete(Integer resNo) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, resNo);

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
	public ResVO findByPrimaryKeyResNo(Integer resNo) {
		// TODO Auto-generated method stub
		ResVO resVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, resNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// resVO 也稱為 Domain objects
				resVO = new ResVO();
				resVO.setResNo(rs.getInt("resNo"));
				resVO.setMemNo(rs.getInt("memNo"));
				resVO.setSerNo(rs.getInt("serNo"));
				resVO.setDesNo(rs.getInt("desNo"));
				resVO.setResProDate(rs.getTimestamp("resProDate"));
				resVO.setResDate(rs.getDate("resDate"));
				resVO.setResTime(rs.getInt("resTime"));
				resVO.setResStatus(rs.getInt("resStatus"));
				resVO.setResCom(rs.getInt("resCom"));
				resVO.setResCode(rs.getString("resCode"));
				resVO.setResPrice(rs.getInt("resPrice"));
			}

			// Handle any driver errors
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
		return resVO;
	}

	@Override
	public List<ResVO> getAll() {
		// TODO Auto-generated method stub
		List<ResVO> list = new ArrayList<ResVO>();
		ResVO resVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// resVO 也稱為 Domain objects
				resVO = new ResVO();
				resVO.setResNo(rs.getInt("resNo"));
				resVO.setMemNo(rs.getInt("memNo"));
				resVO.setSerNo(rs.getInt("serNo"));
				resVO.setDesNo(rs.getInt("desNo"));
				resVO.setResProDate(rs.getTimestamp("resProDate"));
				resVO.setResDate(rs.getDate("resDate"));
				resVO.setResTime(rs.getInt("resTime"));
				resVO.setResStatus(rs.getInt("resStatus"));
				resVO.setResCom(rs.getInt("resCom"));
				resVO.setResCode(rs.getString("resCode"));
				resVO.setResPrice(rs.getInt("resPrice"));
				list.add(resVO); // Store the row in the list
			}

			// Handle any driver errors
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

	@Override
	public void updateConfirm(ResVO resVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CONFIRM);

			pstmt.setInt(1, resVO.getResStatus());
			pstmt.setString(2, resVO.getResCode());
			pstmt.setInt(3, resVO.getResNo());

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
	public void updateStatus(ResVO resVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);

			pstmt.setInt(1, resVO.getResStatus());
			pstmt.setInt(2, resVO.getResNo());

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
	public void updateCom(ResVO resVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_COM);

			pstmt.setInt(1, resVO.getResCom());
			pstmt.setInt(2, resVO.getResNo());

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
	public List<ResVO> findByPrimaryKeyDesNo(Integer desNo) {
		// TODO Auto-generated method stub
		List<ResVO> list = new ArrayList<ResVO>();
		ResVO resVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_DESNO);

			pstmt.setInt(1, desNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// resVO 也稱為 Domain objects
				resVO = new ResVO();
				resVO.setResNo(rs.getInt("resNo"));
				resVO.setMemNo(rs.getInt("memNo"));
				resVO.setSerNo(rs.getInt("serNo"));
				resVO.setDesNo(rs.getInt("desNo"));
				resVO.setResProDate(rs.getTimestamp("resProDate"));
				resVO.setResDate(rs.getDate("resDate"));
				resVO.setResTime(rs.getInt("resTime"));
				resVO.setResStatus(rs.getInt("resStatus"));
				resVO.setResCom(rs.getInt("resCom"));
				resVO.setResCode(rs.getString("resCode"));
				resVO.setResPrice(rs.getInt("resPrice"));
				list.add(resVO);
			}

			// Handle any driver errors
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

	@Override
	public List<ResVO> findByPrimaryKeyMemNo(Integer memNo) {
		// TODO Auto-generated method stub
		List<ResVO> list = new ArrayList<ResVO>();
		ResVO resVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MEMNO);

			pstmt.setInt(1, memNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// resVO 也稱為 Domain objects
				resVO = new ResVO();
				resVO.setResNo(rs.getInt("resNo"));
				resVO.setMemNo(rs.getInt("memNo"));
				resVO.setSerNo(rs.getInt("serNo"));
				resVO.setDesNo(rs.getInt("desNo"));
				resVO.setResProDate(rs.getTimestamp("resProDate"));
				resVO.setResDate(rs.getDate("resDate"));
				resVO.setResTime(rs.getInt("resTime"));
				resVO.setResStatus(rs.getInt("resStatus"));
				resVO.setResCom(rs.getInt("resCom"));
				resVO.setResCode(rs.getString("resCode"));
				resVO.setResPrice(rs.getInt("resPrice"));
				list.add(resVO);
			}

			// Handle any driver errors
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

	@Override
	public List<ResVO> findConfirmByDesNo(Integer desNo) {
		// TODO Auto-generated method stub
		List<ResVO> list = new ArrayList<ResVO>();
		ResVO resVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_CONFIRM_BY_DESNO);

			pstmt.setInt(1, desNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// resVO 也稱為 Domain objects
				resVO = new ResVO();
				resVO.setResNo(rs.getInt("resNo"));
				resVO.setMemNo(rs.getInt("memNo"));
				resVO.setSerNo(rs.getInt("serNo"));
				resVO.setDesNo(rs.getInt("desNo"));
				resVO.setResProDate(rs.getTimestamp("resProDate"));
				resVO.setResDate(rs.getDate("resDate"));
				resVO.setResTime(rs.getInt("resTime"));
				resVO.setResStatus(rs.getInt("resStatus"));
				resVO.setResCom(rs.getInt("resCom"));
				resVO.setResCode(rs.getString("resCode"));
				resVO.setResPrice(rs.getInt("resPrice"));
				list.add(resVO);
			}

			// Handle any driver errors
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

	
	
	
	
	

}
