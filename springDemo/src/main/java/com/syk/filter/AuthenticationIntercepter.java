package com.syk.filter;

import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AuthenticationIntercepter implements HandlerInterceptor {
	// 登录路径
	public static final String LOGINURL = "/user/login";
	public static final String REGISTER_URL="/view/register";
	public static final String REGISTER_URL2="/user/add";

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//包括以下请求，不予拦截
		String uri = request.getRequestURI();
		if (uri.contains(LOGINURL)||uri.contains(REGISTER_URL)||uri.contains(REGISTER_URL2)) {
			return true;
		}
		HttpSession httpSession = request.getSession();
		httpSession.setMaxInactiveInterval(600);
		Hashtable<String, String> session = (Hashtable<String, String>) httpSession.getAttribute("userInfo");
		
		if (session == null || request.getSession(false) == null) {
			// 如果session为空，转至登录界面
			response.sendRedirect(request.getContextPath() + "/view/login.jsp");
		}
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}