package util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class PicFinder
 */
@WebServlet("/PicFinder")
public class PicFinder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DataSource ds;

	// private static final String GET_PIC2 = "SELECT COM_PICTURE2 FROM COMMODITY
	// WHERE COM_ID = ?";

	public PicFinder() {
		super();

	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;

		try {
			String pic = req.getParameter("pic").trim();

			if ("1".equals(pic)) {
				int ID = Integer.parseInt(req.getParameter("id").trim());
				String table = req.getParameter("table");
				String column = req.getParameter("column");
				String idName = req.getParameter("idname");
				String sql = "SELECT " + column + " FROM " + table + " WHERE " + idName + "=?";
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ID);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					BufferedInputStream bis = new BufferedInputStream(rs.getBinaryStream(1));
					byte[] buff = new byte[4 * 1024];
					int len;
					while ((len = bis.read(buff)) != -1) {
						out.write(buff, 0, len);
					}
					bis.close();
					rs.close();
					pstmt.close();
				}

			} else {
				InputStream is = getServletContext().getResourceAsStream("/resource/images/memIcon.png");
				byte buff[] = new byte[is.available()];
				is.read(buff);
				out.write(buff);
				is.close();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			InputStream is = getServletContext().getResourceAsStream("/resource/images/memIcon.png");
			byte buff[] = new byte[is.available()];
			is.read(buff);
			out.write(buff);
			is.close();
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

	}

	public void destroy() {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
