package com.websocketchat.controller;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;

/**
 * Application Lifecycle Listener implementation class RequestListener
 *
 */
@WebListener
public class RequestListener implements ServletRequestListener {

	public void requestInitialized(ServletRequestEvent sre) {
		// 將所有request請求都攜帶上httpSession
		((HttpServletRequest) sre.getServletRequest()).getSession();
	}

	public RequestListener() {
	}

	public void requestDestroyed(ServletRequestEvent arg0) {
	}

}
