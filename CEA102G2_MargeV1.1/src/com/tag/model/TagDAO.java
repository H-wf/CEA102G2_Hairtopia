package com.tag.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TagDAO implements TagDAO_Interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO TAG(tagName) VALUES(?);";
	private static final String GET_ALL_STMT = "SELECT * FROM hairtopia.tag;";
	private static final String GET_NO_BY_TAG_NAME = "SELECT tagNo FROM hairtopia.tag WHERE tagName=?;";
	private static final String GET_NO_BY_TAG_NO = "SELECT tagName FROM hairtopia.tag WHERE tagNo=?;";
	private static final String DELETE = "DELETE FROM hairtopia.tag WHERE tagNo = ?;";
	private static final String UPDATE = "UPDATE hairtopia.tag SET tagName=? WHERE tagNo=?;";
	private static final String GET_TAG_NAME =	"SELECT tagName from hairtopia.tag where tagName like ?;";
	private static final String GET_TAGNO =	"SELECT tagNo from hairtopia.tag where tagName like ?;";
	
	
	@Override
	public TagVO insert(TagVO tagVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			String cols[] = {"tagNo"};
			pstmt = con.prepareStatement(INSERT_STMT,cols);
			pstmt.setString(1, tagVo.getTagName());
			
			pstmt.executeUpdate();
			
			String next_tagno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_tagno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_tagno +"(剛新增成功的標籤編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			tagVo.setTagNo(new Integer(next_tagno));
			
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		
		return tagVo;
	}
	@Override
	public void update(TagVO tagVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, tagVo.getTagName());
			pstmt.setInt(2, tagVo.getTagNo());
			
			pstmt.executeUpdate();
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}				
	}
	@Override
	public void delete(Integer tagNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, tagNo);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	@Override
	public String findByTagNo(Integer tagNo) {
		String tagName = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_NO_BY_TAG_NO);
			pstmt.setInt(1, tagNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tagName = rs.getString("tagName");
			}
		} catch (SQLException e) {
			throw new RuntimeException("Get tagName excetion. "
					+ e.getMessage());
		}
		
		return tagName;
	}
	
	@Override
	public Integer findByTagName(String tagName) {
		
		Integer tagNo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_NO_BY_TAG_NAME);
				pstmt.setString(1, tagName);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					tagNo = rs.getInt("tagNo");
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
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
		
		return tagNo;
	}
	
	@Override
	public List<TagVO> getAll() {
		List<TagVO> list = new ArrayList<TagVO>();
		TagVO tagVo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				tagVo = new TagVO();
				tagVo.setTagNo(rs.getInt("tagNo"));
				tagVo.setTagName(rs.getString("tagName"));
				list.add(tagVo); // Store the row in the list
			}

			// Handle any driver errors
		}  catch (SQLException se) {
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
	public List<String> getTagAJAX(String keyword) {
		List<String> ajaxList = new ArrayList<String>();
		String tagName = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_TAG_NAME);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// salonVO 也稱為 Domain objects
				tagName = rs.getString("tagName");
				ajaxList.add(tagName); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured In method named 'getTagAJAX'. "
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
		
		return ajaxList;
	}
	
    public Set<Integer> searchTagNo(String keyword){
    	Set<Integer> tagNoSet = new HashSet<Integer>();
		Integer tagNo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_TAGNO);
			pstmt.setString(1,"%" + keyword + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// salonVO 也稱為 Domain objects
				tagNo = rs.getInt("tagNo");
				tagNoSet.add(tagNo); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured In method named 'searchTagNo'. "
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
		
		return tagNoSet;
    }

}
