package com.util.imageHandle;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.sun.xml.internal.ws.api.policy.PolicyResolver.ServerContext;

public class ShowImage extends HttpServlet {

	DataSource ds;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;

		try {
			String tableName = req.getParameter("tableName");
			String picColumn = req.getParameter("picColumn");
			String pkColumn = req.getParameter("pkColumn");
			
			String sql = "SELECT " + picColumn + " FROM " + tableName + " WHERE "+ pkColumn + " = ?";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			if("memNo".equals(pkColumn)) {
				Integer pkNo =new Integer(req.getParameter(pkColumn));
				pstmt.setInt(1, pkNo);
			}else if("memName".equals(pkColumn)) {
				String  pkName = req.getParameter(pkColumn);
				pstmt.setString(1, pkName);
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(picColumn));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				InputStream in = getServletContext().getResourceAsStream("/resource/images/unupload.jpg");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}
			rs.close();
		} catch (Exception e) {
			InputStream in = getServletContext().getResourceAsStream("/resource/images/memIcon.png");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
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
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
	}

}