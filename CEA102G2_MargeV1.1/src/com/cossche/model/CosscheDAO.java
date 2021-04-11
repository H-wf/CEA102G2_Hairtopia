package com.cossche.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CosscheDAO implements Cossche_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String UPDATE_COS_STATUS_WHEN_APPLY_START = 
			"UPDATE course SET cosStatus = 1 where cosApplyTo > now()";
//	private static final String UPDATE_COS_STATUS_WHEN_APPLY_OVER = 
//			"UPDATE course SET cosStatus = 0 where now() <= cosApplyFrom AND now() > cosApplyTo";

//		@Override
//		public void updateCosStatusWhenApplyOver() {
//
//			Connection con = null;
//			PreparedStatement pstmt = null;
//
//			try {
//				con = ds.getConnection();
//				pstmt = con.prepareStatement(UPDATE_COS_STATUS_WHEN_APPLY_START);
//
//				pstmt.executeUpdate("set auto_increment_offset=3;");
//				pstmt.executeUpdate("set auto_increment_increment=3;");
//				pstmt.executeUpdate();
//				
//			} catch (SQLException se) {
//				throw new RuntimeException("A database error occured. "
//							+ se.getMessage());
//
//			} finally {
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
//		}
		
		@Override
		public void updateCosStatusWhenApplyStart() {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_COS_STATUS_WHEN_APPLY_START);

				pstmt.executeUpdate();
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
							+ se.getMessage());

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

}
	

