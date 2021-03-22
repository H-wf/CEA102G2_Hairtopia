package com.QRCode.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class QRCodeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	// 掛上兩個jar檔
	// 1. zxing-core
	// 2. zxing-javase
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/jpeg");
		ServletOutputStream out = res.getOutputStream();
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		Integer cosNo = new Integer(req.getParameter("cosNo"));
		System.out.println(cosNo);
		
//		String url = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/" + req.getServletPath() + "/" + "listOneCosdetail.jsp?";
		String s1 =  "http://localhost:8081/CEA102G2_Merge/coudet/coudet.do?cosNo=";
		String s2 = String.valueOf(cosNo);
		String s3 = "&action=getOne_For_Display";
		String url = s1 + s2 + s3 ;
		int width = 200;
		int height = 200;
		String format = "jpg";
		// 設定編碼格式與容錯率
		Hashtable<EncodeHintType, Object> hints = new Hashtable<>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
		// 開始產生QRCode
		BitMatrix matrix = null;
		try {
			matrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, width, height, hints);
		} catch (WriterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MatrixToImageWriter.writeToStream(matrix, format, out);
		System.out.println(matrix);
		System.out.println(format);
		System.out.println(out);
	}

	private String convert2Byte(InputStream input) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buff = new byte[100];
		int length = 0;
		while ((length = input.read(buff, 0, 100)) > 0) {
			baos.write(buff, 0, length);
		}
		byte[] in2b = baos.toByteArray();
		baos.flush();
		baos.close();
		input.close();
		return new String(Base64.getEncoder().encodeToString(in2b));

	}

}
