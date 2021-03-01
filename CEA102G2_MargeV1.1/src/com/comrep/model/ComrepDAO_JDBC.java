package com.comrep.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class ComrepDAO_JDBC implements ComrepDAO_Interface{
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/hairtopia?serverTimezone=Asia/Taipei";
	String userid = "root";
	String pw = "1qaz2wsx";
	
	private static final String INSERT_STMT = "INSERT INTO COMREP(comNo,memNo,crepCon) VALUES(?,?,?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.comrep;";
	private static final String GET_ONE_STMT = "SELECT crepNo , comNo, memNo , crepCon , crepTime , crepStatus FROM hairtopia.comrep where crepNo = ?";	//back-end
	private static final String GET_DES_POST = "SELECT desNo , postCon, postPic1 FROM post where desNo = ?";	//front-end 複合查詢設計師名
	
	private static final String DELETE = "";
	private static final String UPDATE = "";
	
	@Override
	public void insert(ComrepVO comrepVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, pw);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, comrepVo.getComNo());
			pstmt.setInt(2, comrepVo.getMemNo());
			pstmt.setString(3, comrepVo.getCrepCon());
			
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
	public void update(ComrepVO comrepVo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(Integer crepNo) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public ComrepVO findByPrimaryKey(Integer crepNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<ComrepVO> getAll() {
		
		List<ComrepVO> list = new ArrayList<ComrepVO>();
		ComrepVO comrepVo = null;

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
				comrepVo = new ComrepVO();
				comrepVo.setCrepNo(rs.getInt("crepNo"));
				comrepVo.setComNo(rs.getInt("comNo"));
				comrepVo.setMemNo(rs.getInt("memNo"));
				comrepVo.setCrepCon(rs.getString("crepCon"));
				comrepVo.setCrepTime(rs.getDate("crepTime"));
				comrepVo.setCrepStatus(rs.getInt("crepStatus"));
				list.add(comrepVo); // Store the row in the list
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
		ComrepDAO_JDBC dao = new ComrepDAO_JDBC();
		
		//新增
		
//		ComrepVO comrepVo = new ComrepVO();
//		
//		comrepVo.setComNo(1);
//		comrepVo.setMemNo(8);
//		comrepVo.setCrepCon("油");
//		dao.insert(comrepVo);
		
	//查全部
		List<ComrepVO> list = dao.getAll();
		for (ComrepVO aComrep : list) {
			System.out.print(aComrep.getCrepNo() + ",");
			System.out.print(aComrep.getComNo() + ",");
			System.out.print(aComrep.getMemNo() + ",");
			System.out.print(aComrep.getCrepCon() + ",");
			System.out.print(aComrep.getCrepTime() + ",");
			System.out.print(aComrep.getCrepStatus());
			System.out.println();
		}
	}

}
