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

	Connection con;
	
	//private static final String GET_PIC2 = "SELECT COM_PICTURE2 FROM COMMODITY WHERE COM_ID = ?";

	public PicFinder() {
		super();

	}

	public void init() throws ServletException {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Hairtopia");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();

		try {
			String pic = req.getParameter("pic").trim();
			
			if("1".equals(pic)) {
			int ID = Integer.parseInt(req.getParameter("id").trim());
			String table = req.getParameter("table");
			String column = req.getParameter("column");
			String idName = req.getParameter("idname");
			String sql = "SELECT " + column + " FROM " + table +" WHERE "+ idName+"=?";
			PreparedStatement pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, ID);
			ResultSet rs = pstmt.executeQuery();
			
				if(rs.next()) {
					BufferedInputStream bis = new BufferedInputStream(rs.getBinaryStream(1));
					byte[] buff = new byte[4*1024];
					int len;
					while((len = bis.read(buff))!=-1) {
						out.write(buff, 0, len);
					}
					bis.close();
					rs.close();
					pstmt.close();
				}
			
//			}else if("2".equals(pic)) {
//				PreparedStatement pstmt =con.prepareStatement(GET_PIC2);
//				int comID = Integer.parseInt(req.getParameter("id").trim());
//				pstmt.setInt(1, comID);
//				ResultSet rs = pstmt.executeQuery();
//				
//				
//				if(rs.next()) {
//					BufferedInputStream bis = new BufferedInputStream(rs.getBinaryStream("COM_PICTURE2"));
//					byte[] buff = new byte[4*1024];
//					int len;
//					
//					while((len = bis.read(buff))!=-1) {
//						out.write(buff, 0, len);
//					}
//					bis.close();
//					rs.close();
//					pstmt.close();
//				}
			}else{
				InputStream is = getServletContext().getResourceAsStream("/resource/images/unupload.jpg");
				byte buff[] = new byte[is.available()];
				is.read(buff);
				out.write(buff);
				is.close();
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			InputStream is = getServletContext().getResourceAsStream("/resource/images/unupload.jpg");
			byte buff[] = new byte[is.available()];
			is.read(buff);
			out.write(buff);
			is.close();
		}
		
		}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
